Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161057AbWI1K1E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161057AbWI1K1E (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 06:27:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161058AbWI1K1E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 06:27:04 -0400
Received: from gw.goop.org ([64.81.55.164]:29661 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S1161057AbWI1K1B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 06:27:01 -0400
Message-ID: <451BA380.7030502@goop.org>
Date: Thu, 28 Sep 2006 03:27:12 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Andi Kleen <ak@muc.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Put the BUG __FILE__ and __LINE__ info out of line
References: <451B64E3.9020900@goop.org>	<20060927233509.f675c02d.akpm@osdl.org>	<451B708D.20505@goop.org> <20060928000019.3fb4b317.akpm@osdl.org>
In-Reply-To: <20060928000019.3fb4b317.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Plan #17 is to just put the BUG inline and then put the EIP+file*+line into
> a separate section, then search that section at BUG time to find the record
> whose EIP points back at this ud2a.
>   

Sure, but it seems a bit complex for this; I think simpler is better 
when the kernel has got itself into an iffy state.

> It's a bit messy for modules, but it minimises the .text impact and keeps
> disassembly happy, no?
>   
I'm not quite sure I understand your concern.  You're worried about the 
size increase to vmlinux in the case where you specify 
CONFIG_DEBUG_BUGVERBOSE?  Seems to me that if you specify it, you're 
willing to give up some kernel space for it, and adding 5 bytes/BUG 
isn't a huge deal (that's about 10k extra on my kernel).

Especially since the file+line info is mostly redundant anyway (since 
the kernel can tell you what a function an EIP is in), and completely 
redunant if you have debug info.  I guess its mostly useful so you can 
interpret the the bug message without access to kernel image.

> And if done right it can probably be used by other architectures.
>   

DWARF seems like the better answer to me.


    J
