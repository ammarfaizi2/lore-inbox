Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422769AbWJRSbf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422769AbWJRSbf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 14:31:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422770AbWJRSbf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 14:31:35 -0400
Received: from smtp109.mail.mud.yahoo.com ([209.191.85.219]:20323 "HELO
	smtp109.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1422769AbWJRSb3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 14:31:29 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=3ds8FBH/O3kQFmP4PMEtShLFsmjPFgcskMDf9H2Et+fu1teWAXVBAWIPpd6g6icepAdxUsmlz9x78ssGE6CsdSwQud1TAnMGvSX31ajxiRfD4Mo7Sy0lDnFAuejCtbn3kCvOQc8gypcn/OgVKSiGoKiUjE8BY1Cma/ywzgbPwIg=  ;
Message-ID: <453672FD.9080206@yahoo.com.au>
Date: Thu, 19 Oct 2006 04:31:25 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Nick Piggin <nickpiggin@yahoo.com.au>
CC: Badari Pulavarty <pbadari@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>,
       Chris Mason <chris.mason@oracle.com>
Subject: Re: 2.6.19-rc2-mm1
References: <20061016230645.fed53c5b.akpm@osdl.org>	 <1161185599.18117.1.camel@dyn9047017100.beaverton.ibm.com>	 <45364CE9.7050002@yahoo.com.au>	 <1161191747.18117.9.camel@dyn9047017100.beaverton.ibm.com>	 <45366515.4050308@yahoo.com.au> <1161194303.18117.17.camel@dyn9047017100.beaverton.ibm.com> <45366F08.6050903@yahoo.com.au>
In-Reply-To: <45366F08.6050903@yahoo.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote:

> I can't see anything yet, but I'll keep looking (and try to reproduce
> if I can get TLP working).

Ah, it is probably exercising the -EFAULT path, and the code in
Andrew's tree goes into an infinite loop I think.

We can't test for a fault off the atomic copy, because that needn't
indicate an unmapped area. What we need to do is change
fault_in_pages_readable to return ret, and catch and return that
in the caller if it is an error.

My usual workstation is down ATM otherwise I would send you a patch.
Unless someone beats me to it, I'll send you one tomorrow.

Thanks,
Nick

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
