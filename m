Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319598AbSIHLxY>; Sun, 8 Sep 2002 07:53:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319599AbSIHLxY>; Sun, 8 Sep 2002 07:53:24 -0400
Received: from zero.aec.at ([193.170.194.10]:7443 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id <S319598AbSIHLxY>;
	Sun, 8 Sep 2002 07:53:24 -0400
To: James Morris <jmorris@intercode.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Performance issue in 2.5.32+
References: <Mutt.LNX.4.44.0209082131140.20784-100000@blackbird.intercode.com.au>
From: Andi Kleen <ak@muc.de>
Date: 08 Sep 2002 13:57:47 +0200
In-Reply-To: James Morris's message of "Sun, 08 Sep 2002 13:50:06 +0200"
Message-ID: <m38z2cy9qc.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.070095 (Pterodactyl Gnus v0.95) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Morris <jmorris@intercode.com.au> writes:

> I've noticed a significant performance hit on my system since 2.5.32.  
> lmbench shows major changes in context switching latencies for 2.5.32 and
> 2.5.33 (see below, and profiling results for lat_ctx after that). This is
> on a dual celeron system with a Gigabyte GA6BXD motherboard.  I can
> provide more hardware and configuration details if required.

2.5.32 added the TLS changes, which do rewrite the GDT in context switch.
Does it go away when you comment out the call to load_TLS in 
arch/i386/kernel/process.c:__switch_to() ? (change should be harmless
unless you use a development glibc which uses TLS) 

-Andi
