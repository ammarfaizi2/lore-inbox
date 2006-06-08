Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964908AbWFHSee@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964908AbWFHSee (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 14:34:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964929AbWFHSee
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 14:34:34 -0400
Received: from news.cistron.nl ([62.216.30.38]:29406 "EHLO ncc1701.cistron.net")
	by vger.kernel.org with ESMTP id S964908AbWFHSee (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jun 2006 14:34:34 -0400
From: "Miquel van Smoorenburg" <miquels@cistron.nl>
Subject: Re: Interrupts disabled for too long in printk
Date: Thu, 8 Jun 2006 18:34:32 +0000 (UTC)
Organization: Cistron
Message-ID: <e69qjo$ekd$1@news.cistron.nl>
References: <20060603111934.GA14581@Krystal> <9e4733910606080738xd44aab3o5ac0d4bda920575d@mail.gmail.com> <Pine.LNX.4.61.0606081107110.31343@chaos.analogic.com> <9e4733910606080845y48dabed1o333b82eeb1a57381@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: ncc1701.cistron.net 1149791672 14989 194.109.0.112 (8 Jun 2006 18:34:32 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: mikevs@n2o.xs4all.nl (Miquel van Smoorenburg)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <9e4733910606080845y48dabed1o333b82eeb1a57381@mail.gmail.com>,
Jon Smirl <jonsmirl@gmail.com> wrote:
>This just seems to be an issue with the serial console implementation
>which is much slower.   So the answer looks to be that if the serial
>console buffer is full, and it is being called with interrupts off, it
>should just toss the printk.

Read the serial console code. It is a standalone implementation
completely seperate from the standard drivers, which deliberately
turns off the interrupts and reverts to polling. This because
there is no guarantee the whole irq handling stuff still works
at the moment you're printk'ing a panic.

Also the current standard serial drivers only work if the
tty has been opened by a userspace process.

If you want to change this, first fix the latter problem, then
change the serial console output driver so that it uses the
standard serial driver for lower priority messages and only
uses the polling code for panics.

Mike.

