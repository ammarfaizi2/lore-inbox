Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030357AbWGMUWR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030357AbWGMUWR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 16:22:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030358AbWGMUWR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 16:22:17 -0400
Received: from smtp105.mail.mud.yahoo.com ([209.191.85.215]:35184 "HELO
	smtp105.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1030357AbWGMUWQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 16:22:16 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=wwTAECo5GOcleHr+qQToGGsIZ1l48uChSNjz0IYJaM8hBnaUguZIweHcVcG7IGE6Ag+M5W/w26SF84kyV31k3APatFXbtsW7ZKsAnRo232iWAsFcb8EFMVuBPJr5LfpiQlR5MUbnSR7BKWtguY/i+lk7JYMAqL29clvy2jka9YE=  ;
Message-ID: <44B64CC9.7070307@yahoo.com.au>
Date: Thu, 13 Jul 2006 23:38:17 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Takashi Iwai <tiwai@suse.de>
CC: Russell King <rmk+lkml@arm.linux.org.uk>, Marc Singer <elf@buici.com>,
       Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: DMA memory, split_page, BUG_ON(PageCompound()), sound
References: <20060709000703.GA9806@cerise.buici.com>	<44B0774E.5010103@yahoo.com.au>	<20060710025103.GC28166@cerise.buici.com>	<44B1FAE4.9070903@yahoo.com.au>	<20060710162600.GB18728@flint.arm.linux.org.uk>	<44B28F93.9020304@yahoo.com.au>	<20060712103241.GA7908@flint.arm.linux.org.uk> <s5hu05lvdgw.wl%tiwai@suse.de>
In-Reply-To: <s5hu05lvdgw.wl%tiwai@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Takashi Iwai wrote:
> At Wed, 12 Jul 2006 11:32:41 +0100,

>>In which case should ALSA be passing __GFP_COMP to the dma allocator ?

Yes, sorry I didn't answer your question: ALSA basically wants to be
able to have that memory mmapable by userspace programs, and it doesn't
care whether this is via compound pages or split pages.

> I would be willing to remove __GFP_COMP if it's not needed :)
> Passing this flag is really confusing.  The driver doesn't use the
> compound pages at all but it was added just to enable mmap support.
> So, Nick's proposal appears reasonable to me.

I don't think it would be hard. Just need a bit of thinking about how
to go about composing some sort of GFP_USERMAP that can easily be
handled by all allocators, without costing performance or being too
intrusive.

I suspect I won't have time to wade into such an exercise until after
OLS. But I could give a quick review for anyone who does ;)

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
