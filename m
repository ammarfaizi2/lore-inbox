Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964879AbWJJAmj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964879AbWJJAmj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 20:42:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751932AbWJJAmj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 20:42:39 -0400
Received: from smtp105.mail.mud.yahoo.com ([209.191.85.215]:41551 "HELO
	smtp105.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751931AbWJJAmi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 20:42:38 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=ND5f61owyDaUPXy5G9S3AJo7MTZmhmh2+tHhnWeNvCR9YIPrwikkVSf+U3lj7dmmhRsYT3sSjO9Jxh9QikOFWddoRJIZ/aEM5dwJane9TJ/hdKfHNd4GM0foXuf31Y2GYrHKnlUD2TtqDUC8sjsqxixNmVMSnGw5J4paEKQ/ZvQ=  ;
Message-ID: <452AEC8B.2070008@yahoo.com.au>
Date: Tue, 10 Oct 2006 10:42:51 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC: Nick Piggin <npiggin@suse.de>, Hugh Dickins <hugh@veritas.com>,
       Linux Memory Management <linux-mm@kvack.org>,
       Andrew Morton <akpm@osdl.org>, Jes Sorensen <jes@sgi.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch 4/5] mm: add vm_insert_pfn helpler
References: <20061009140354.13840.71273.sendpatchset@linux.site>	 <20061009140447.13840.20975.sendpatchset@linux.site> <1160427785.7752.19.camel@localhost.localdomain>
In-Reply-To: <1160427785.7752.19.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Herrenschmidt wrote:
>>+	vma->vm_flags |= VM_PFNMAP;
> 
> 
> I wouldn't do that here. I would keep that to the caller (and set it
> before setting the PTE along with a wmb maybe to make sure it's visible
> before the PTE no ?)

Oops, good catch. You're right.

We probably don't need a barrier because we take the ptl lock
around setting the pte, and the only other readers who care should
be ones that also take the same ptl lock.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
