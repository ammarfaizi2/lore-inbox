Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262373AbSKRSx0>; Mon, 18 Nov 2002 13:53:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264610AbSKRSx0>; Mon, 18 Nov 2002 13:53:26 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:270 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S262373AbSKRSxY>; Mon, 18 Nov 2002 13:53:24 -0500
Date: Mon, 18 Nov 2002 10:59:23 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Manfred Spraul <manfred@colorfullife.com>
cc: William Lee Irwin III <wli@holomorphy.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>, <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.5.48
In-Reply-To: <Pine.LNX.4.44.0211181920540.11872-100000@dbl.q-ag.de>
Message-ID: <Pine.LNX.4.44.0211181056170.1018-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 18 Nov 2002, Manfred Spraul wrote:
> 
> I think this patch should keep the interrupts disabled until after
> smp_commenced is set. It's partially tested: bochs boots until all cpus
> are up and then crashes.

This patch certainly cannot work: calibrate_delay() needs interrupts.

However, I think it's a mistake to even _try_ to calibrate the delay this 
early, so the real fix probably looks something like this together with 
moving the calibration to after the CPU is fully initialized.

		Linus

