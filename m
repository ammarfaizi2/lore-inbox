Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266463AbUANXuw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 18:50:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266462AbUANXuw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 18:50:52 -0500
Received: from fw.osdl.org ([65.172.181.6]:8120 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266463AbUANXu1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 18:50:27 -0500
Date: Wed, 14 Jan 2004 15:23:35 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Andi Kleen <ak@muc.de>
cc: akpm@osdl.org, jh@suse.cz, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Add noinline attribute
In-Reply-To: <20040114083114.GA1784@averell>
Message-ID: <Pine.LNX.4.58.0401141519260.4500@evo.osdl.org>
References: <20040114083114.GA1784@averell>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 14 Jan 2004, Andi Kleen wrote:
> 
> do_test_wp_bit cannot be inlined, otherwise the kernel doesn't boot
> because the exception tables get reordered. 

This patch seems to just hide the _real_ bug, which is that the exception 
table gets confused.

If the exception table is confused, you'll get oopses on bad user system 
call pointers, but since that is uncommon, you'll never see it under 
normal circumstances. This is the only exception that you'll always see.

So it sounds like you have a compiler combination that breaks the 
exception table totally for _any_ function called from any non-regular 
segment, and this just happens to be the only one you actually saw.

How about just fixing the exception table instead? A bogo-sort at boot 
time?

			Linus
