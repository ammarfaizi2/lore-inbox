Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270928AbTHAUQy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Aug 2003 16:16:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272431AbTHAUQy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Aug 2003 16:16:54 -0400
Received: from kweetal.tue.nl ([131.155.3.6]:34832 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id S270928AbTHAUQw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Aug 2003 16:16:52 -0400
Date: Fri, 1 Aug 2003 22:16:50 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Jurgen Kramer <gtm.kramer@inter.nl.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test1/2: keyboard funnies in textmode
Message-ID: <20030801201650.GA3380@win.tue.nl>
References: <1059747945.2809.2.camel@paragon.slim> <20030801145223.GA3308@win.tue.nl> <1059752011.2691.13.camel@paragon.slim> <20030801163759.GA3343@win.tue.nl> <1059760564.3404.9.camel@paragon.slim>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1059760564.3404.9.camel@paragon.slim>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 01, 2003 at 07:56:04PM +0200, Jurgen Kramer wrote:

> Laptop 2.4 showkey:
> keycode 124
> 
> Laptop 2.6 showkey:
> keycode 0 press
> keycode 1 release
> keycode 55 release
> keycode 0 release
> keycode 1 release
> keycode 55 release
> 
> Laptop 2.6 showkey -s:
> 0x7d
> 0xfd
> 0x7d
> 0xfd
> 0x7d
> 0xfd

Aha - this is a problem we have seen a few more times recently.
Scancode 0x7d, well-known from Japanese keyboards, has keycode 124
under 2.4 and keycode 183 under 2.6.

There are many solutions, and searching for "keycode 183" will
show you a few. A quick-n-dirty solution for you is to replace
the 183 in the array atkbd_set2_keycode[] in atkbd.c by 124.

Will look at your USB problem later.

Andries


[PS - Your strange 1,55 release is because 1*128+55 = 183.
The new kernel breaks old keyboard utilities. Bad.]

