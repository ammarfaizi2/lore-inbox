Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264689AbTGBEwq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jul 2003 00:52:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264695AbTGBEwq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jul 2003 00:52:46 -0400
Received: from air-2.osdl.org ([65.172.181.6]:3281 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264689AbTGBEwp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jul 2003 00:52:45 -0400
Date: Tue, 1 Jul 2003 22:06:41 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Bernardo Innocenti <bernie@develer.com>
cc: Andrew Morton <akpm@digeo.com>, <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH] Kill div64.h dupes, parenthesize do_div() macro params
In-Reply-To: <200307020424.47629.bernie@develer.com>
Message-ID: <Pine.LNX.4.44.0307012203001.2047-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 2 Jul 2003, Bernardo Innocenti wrote:
> 
>  By the way, what do you think about getting rid of the do_div() macro
> altogether? I've noticed that gcc 3.3 is quite capable of guessing the
> optimal instruction pattern to use even for the generic do_div()
> written in C:

No thank you. 3.x is still broken enough that I don't want to force people 
to use it.

> This code makes gcc select the "udivmodsi4" pattern on the m68k
> backend

Who cares about m68k? Does it do the right thing on x86? gcc 3.2.2 does
not, it does a "call __udivdi3" + "call __umoddi3", which is a 64/64->64
thing, which is totally inappropriate, and about a million times slower 
than a single "udiv".

gcc is crap when it comes to long long. Always has been.

		Linus

