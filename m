Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030356AbVIOMqb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030356AbVIOMqb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 08:46:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030363AbVIOMqb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 08:46:31 -0400
Received: from smtp204.mail.sc5.yahoo.com ([216.136.130.127]:38840 "HELO
	smtp204.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S1030356AbVIOMqb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 08:46:31 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=EixRhHBnPhihHUihos1+BCspy43owKHg93cra5A2xM0693WVtOB45Y5bKBr8XpaIfkqxAFuFqt405tXCL6Hpf7zLgjCag/A7SSxcz6mpnACaEjLW3dM3dyFXOrdWdjlnL88NaDsofSeOCNmwHF8Jh82j1vaI2goDCm7bKXodlMk=  ;
Message-ID: <43296D1D.4000407@yahoo.com.au>
Date: Thu, 15 Sep 2005 22:46:21 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.10) Gecko/20050802 Debian/1.7.10-1
X-Accept-Language: en
MIME-Version: 1.0
To: "liyu@WAN" <liyu@ccoss.com.cn>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [Question] Can we release vma that include code when one process
 is running?
References: <432919C3.7060708@ccoss.com.cn>
In-Reply-To: <432919C3.7060708@ccoss.com.cn>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

liyu@WAN wrote:

>    It seem that code in other place jump here to enter kernel. this is 
> in a anonymous
> code area.
>    At first time, I think this SIGSEGV will trigger by anonymous code 
> that is swapped,
> but I wrote one specical condition check to filte out this sort of code, 
> IOW, I do
> not swap out it. but I still get SIGSEGV.
> 
>    May be, we can not be release the vma that include code? or, Is there 
> have some errors
> in my words for page fault?
> 

That's right, you cannot release the VMA if the application still
expects to use memory in that area. The page fault handler will
see that no VMA exists in that region and raise a SIGSEGV.

See arch/i386/mm/fault.c:do_page_fault


Nick

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
