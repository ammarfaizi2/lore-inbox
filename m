Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263696AbTIBKud (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Sep 2003 06:50:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263718AbTIBKud
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Sep 2003 06:50:33 -0400
Received: from kweetal.tue.nl ([131.155.3.6]:17420 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id S263696AbTIBKuX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Sep 2003 06:50:23 -0400
Date: Tue, 2 Sep 2003 12:47:17 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: linux-kernel@vger.kernel.org
Subject: keyboard - was: Re: Linux 2.6.0-test4
Message-ID: <20030902124717.B1221@pclin040.win.tue.nl>
References: <20030831120605.08D6.CHRIS@heathens.co.nz> <20030902080733.GA14380@charite.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030902080733.GA14380@charite.de>; from Ralf.Hildebrandt@charite.de on Tue, Sep 02, 2003 at 10:07:33AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 02, 2003 at 10:07:33AM +0200, Ralf Hildebrandt wrote:

> I got some more events, and today I even was able to reproduc the
> "CTRL-is-stuck" problem.
> 
> I was able to get the key unstuck by switching back and forth between
> dirrerent FB consoles and by pushing and releaseing CTRL in them...

Yesterday's data sufficed, and I suppose the patch I gave solves
this problem. Now that you send this, we can verify that each time
there is a problem we have had a double release just before, and
that release was an e0 xx combination.

> atkbd.c: Unknown key (set 2, scancode 0x9c, on isa0060/serio0) pressed.
> i8042 history: e0 d0 1c 9c 2e ae 10 90 e0 50 e0 d0 e0 d0 1c 9c
> 
> atkbd.c: Unknown key (set 2, scancode 0xa0, on isa0060/serio0) pressed.
> i8042 history: 1c 9c 1c 9c e0 50 e0 d0 e0 50 e0 d0 e0 d0 20 a0
> 
> atkbd.c: Unknown key (set 2, scancode 0x9d, on isa0060/serio0) pressed.
> i8042 history: e0 50 e0 d0 e0 50 e0 d0 e0 d0 1d 2d ad 1f 9f 9d
> 
> atkbd.c: Unknown key (set 2, scancode 0xb9, on isa0060/serio0) pressed.
> i8042 history: e0 48 e0 c8 39 b9 e0 38 56 d6 e0 b8 e0 b8 39 b9
> 
> atkbd.c: Unknown key (set 2, scancode 0xb9, on isa0060/serio0) pressed.
> i8042 history: a0 20 a0 9d e0 4d e0 cd e0 4d e0 cd e0 cd 39 b9

And indeed, we see e0 d0 e0 d0, e0 b8 e0 b8, e0 cd e0 cd.

This bug is understood.

