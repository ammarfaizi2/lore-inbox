Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263561AbTKQQch (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Nov 2003 11:32:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263570AbTKQQch
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Nov 2003 11:32:37 -0500
Received: from fw.osdl.org ([65.172.181.6]:38119 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263561AbTKQQcg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Nov 2003 11:32:36 -0500
Date: Mon, 17 Nov 2003 08:32:14 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Dan Creswell <dan@dcrdev.demon.co.uk>
cc: linux-kernel@vger.kernel.org
Subject: Re: Hard lock on 2.6-test9 (More Info)
In-Reply-To: <3FB8CE08.6070001@dcrdev.demon.co.uk>
Message-ID: <Pine.LNX.4.44.0311170829000.8840-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 17 Nov 2003, Dan Creswell wrote:
> 
>  17:       5267       3420   IO-APIC-level  ohci1394, Intel ICH4, nvidia
> 
> When I boot X under kernel 2.6, I see the additional nvidia interrupt 
> path as per the 2.4 output (which was taken whilst I was running X).
> 
> But, within seconds of this additional interrupt assignment appearing, 
> 2.6 dies a horrible death whilst 2.4 just keeps on rolling.

Two potential reasons:
 - the nvidia driver is just broken under 2.6.x
 - or a driver bug in ohci1394 _or_ the Intel ICH4 driver, which could 
   become unhappy if they see a lot of interrupts that aren't for them 
   (maybe it uncovers a race).

You can test for the latter by just disabling those drivers, and seeing 
what happens. If it still breaks, it's nvidia. If the crashes stop, it 
might _still_ be nvidia, but at that point somebody else might start being 
interested in it.

		Linus


