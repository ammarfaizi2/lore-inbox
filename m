Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270617AbTHJSk1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Aug 2003 14:40:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270618AbTHJSk1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Aug 2003 14:40:27 -0400
Received: from as7-4-3.ehn.lk.bonet.se ([217.215.90.41]:11524 "EHLO
	mulder.hem.za.org") by vger.kernel.org with ESMTP id S270617AbTHJSk0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Aug 2003 14:40:26 -0400
Date: Sun, 10 Aug 2003 20:40:23 +0200
From: Mikael Magnusson <mikaelmagnusson@tjohoo.se>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test1/2: keyboard funnies in textmode
Message-ID: <20030810184023.GA10709@skinner.hem.za.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <1059747945.2809.2.camel@paragon.slim> <20030801145223.GA3308@win.tue.nl> <1059752011.2691.13.camel@paragon.slim> <20030801163759.GA3343@win.tue.nl> <1059760564.3404.9.camel@paragon.slim> <20030801221627.GA3397@win.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030801221627.GA3397@win.tue.nl>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 02, 2003 at 12:16:27AM +0200, Andries Brouwer wrote:
> On Fri, Aug 01, 2003 at 07:56:04PM +0200, Jurgen Kramer wrote:
> 
> > PC 2.4 showkey:
> > keycode  43 release
> > keycode  43 press
> > 
> > PC 2.6 showkey:
> > keycode  84 press
> > keycode  84 release
> 

I have got the same problem in 2.6.0-test3 with a swedish USB keyboard. 
It's a Microsoft Natural Keyboard pro. The "'/*" key generates keycode 
43 in 2.4.21 and keycode 84 in 2.6.0-test3. But my swedish AT keyboard 
still generates the same keycode (43) in both releases.

I have tried to find what caused the change. In 2.4 keycode 84 is 
translated to 43 by x86_keycodes table in drivers/input/keybdev.c. But 
in 2.6 I think the table is used only in raw mode, otherwise the keymap 
is used directly (in drivers/char/keyboard.c). 

My workaround is to define keycode 84 in the keymap file/s. I have added 
the following to my US keymap:

keycode  84 = backslash        bar
        control keycode  84 = Control_backslash

Regards,
Mikael Magnusson
