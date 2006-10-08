Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750748AbWJHCRO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750748AbWJHCRO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Oct 2006 22:17:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750749AbWJHCRO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Oct 2006 22:17:14 -0400
Received: from smtp106.mail.mud.yahoo.com ([209.191.85.216]:33398 "HELO
	smtp106.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750748AbWJHCRO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Oct 2006 22:17:14 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=CrnLXefmLgpGw8c9VWSm9ZM//N4EjkcILT+U6dh97NNtJggxDkU1AhY6XuqoXZM9DmLvF2okrnm2U1VB0/6qMjGKzQe6e11IRkAxuWpp8TD6QwNQd4RmuJPxCCiJ6AMnHxyCMC9Aebd6vCUfYuFmVamYaq0XspFNchMBx4/HWCE=  ;
Message-ID: <45285FA5.3090205@yahoo.com.au>
Date: Sun, 08 Oct 2006 12:17:09 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20060216 Debian/1.7.12-1.1ubuntu2
X-Accept-Language: en
MIME-Version: 1.0
To: Jeff Garzik <jeff@garzik.org>
CC: Nick Piggin <npiggin@suse.de>,
       Linux Memory Management <linux-mm@kvack.org>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch 3/3] mm: fault handler to replace nopage and populate
References: <20061007105758.14024.70048.sendpatchset@linux.site> <20061007105853.14024.95383.sendpatchset@linux.site> <4527C46F.5050505@garzik.org>
In-Reply-To: <4527C46F.5050505@garzik.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:

> That's pretty nice.
>
> Back when I was writing [the now slated for death] 
> sound/oss/via82xxx_audio.c driver, Linus suggested that I implement 
> ->nopage() for accessing the mmap'able DMA'd audio buffers, rather 
> than using remap_pfn_range().  It worked out very nicely, because it 
> allowed the sound driver to retrieve $N pages for the mmap'able buffer 
> (passed as an s/g list to the hardware) rather than requiring a single 
> humongous buffer returned by pci_alloc_consistent().
>
> And although probably not your primary motivation, your change does 
> IMO improve this area of the kernel.


Thanks. Yeah hopefully this provides a little more flexibility (I think 
it can
already replace 3 individual vm_ops callbacks!). And I'd like to see 
what other
things it can be used for... :)

However, what we don't want is a bloating of struct fault_data IMO. So 
I'd like
to try to nail down the fields that it needs quite quickly then really 
keep a
lid on it.

--

Send instant messages to your online friends http://au.messenger.yahoo.com 
