Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964952AbWGJVxF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964952AbWGJVxF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 17:53:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964954AbWGJVxF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 17:53:05 -0400
Received: from smtp106.mail.mud.yahoo.com ([209.191.85.216]:44398 "HELO
	smtp106.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S964952AbWGJVxE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 17:53:04 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=1B16Nvy3zkZlMNGMcHHzz+QDTwjZtPvcFIZmrjyCKErmwJQGadUM7tv13yHjivceL7E7mcGsW92neJA8qBI5sEQg4wquEyzZvXYPS+kUTHan8IE5onfx7iCuimtrUfKRW4GeQtShV7o3cpbJuWfsE/V8SKJnSMEoiy1OKqsleGc=  ;
Message-ID: <44B28F93.9020304@yahoo.com.au>
Date: Tue, 11 Jul 2006 03:34:11 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Russell King <rmk+lkml@arm.linux.org.uk>
CC: Marc Singer <elf@buici.com>, Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: DMA memory, split_page, BUG_ON(PageCompound()), sound
References: <20060709000703.GA9806@cerise.buici.com> <44B0774E.5010103@yahoo.com.au> <20060710025103.GC28166@cerise.buici.com> <44B1FAE4.9070903@yahoo.com.au> <20060710162600.GB18728@flint.arm.linux.org.uk>
In-Reply-To: <20060710162600.GB18728@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:
> On Mon, Jul 10, 2006 at 04:59:48PM +1000, Nick Piggin wrote:
> 
>>I guess you could do it a number of ways. Maybe having GFP_USERMAP
>>set __GFP_USERMAP|__GFP_COMP, and the arm dma memory allocator can
>>strip the __GFP_COMP.
>>
>>If you get an explicit __GFP_COMP passed down, the allocator doesn't
>>know whether that was because they want a user mappable area, or
>>really want a compound page (in which case, stripping __GFP_COMP is
>>the wrong thing to do).
> 
> 
> So I'll mask off __GFP_COMP for the time being in the ARM dma allocator
> with a note to this effect?

I believe that should do the trick, yes (AFAIK, nobody yet is
explicitly relying on a compound page from the dma allocator).

Marc can hopefully confim the fix.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
