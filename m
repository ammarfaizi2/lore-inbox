Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261575AbTISNtb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Sep 2003 09:49:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261580AbTISNtb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Sep 2003 09:49:31 -0400
Received: from kweetal.tue.nl ([131.155.3.6]:59149 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id S261575AbTISNt3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Sep 2003 09:49:29 -0400
Date: Fri, 19 Sep 2003 15:49:25 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: "Dan Van Derveer" <dan@cyberkni.net>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: PROBLEM: Logitech Wireless Elite Keyboard
Message-ID: <20030919134925.GA19445@win.tue.nl>
References: <001a01c37eae$da29d610$0203a8c0@dandesktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <001a01c37eae$da29d610$0203a8c0@dandesktop>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 19, 2003 at 09:06:33AM -0400, Dan Van Derveer wrote:

> The keyboard produces unknown scancodes and escape sequences at
> (seemingly)random intervals. I receive this message when I am at the
> console:
> keyboard: unknown e1 escape sequence
> keyboard: unknown e1 escape sequence
> keyboard: unrecognized scancode (65) - ignored
> 
> This issue also manifests itself in Xfree86 as a q character.
> 
> Where should I start to begin to fix this?

First: always give the kernel version.

Second: if the keyboard produces some garbage every now and then
but otherwise functions well, just ignore. It the printk is
annoying, then look at the C code that produces the message
and comment it out. (For example, that code might live in
drivers/char/keyboard.c in the routine handle_scancode() -
details depend on your kernel version, grep for "keyboard: unknown e1".
In many kernel versions the printout is conditional on
#ifdef KBD_REPORT_UNKN, so you may silence the kernel by changing
#define KBD_REPORT_UNKN into #undef KBD_REPORT_UNKN.)

Third: if it is not garbage but some key or button that produces
a meaningful code that the kernel does not understand, report
what key or button you use and what code it produces.
You may check using the command "showkey -s".
If you do not know how to reproduce the problem you might add
a little bit more detail to the kernel message, for example
	printk(KERN_INFO "keyboard: unknown e1 escape sequence 0x%02x 0x%02x\n",
		prev_scancode, scancode);

Fourth: if a known key produces a scancode to which no keycode is attached,
use the setkeycodes utility to assign a keycode. Then use loadkeys to attach
some function to that keycode.

Andries


