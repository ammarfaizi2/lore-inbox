Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265742AbUBGA6Y (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Feb 2004 19:58:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265686AbUBGA6Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Feb 2004 19:58:24 -0500
Received: from kweetal.tue.nl ([131.155.3.6]:9476 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id S265742AbUBGA56 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Feb 2004 19:57:58 -0500
Date: Sat, 7 Feb 2004 01:57:57 +0100
From: Andries Brouwer <aebr@win.tue.nl>
To: Marco Gulino <rockman81@tin.it>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Multimedia Keyboard (no scancodes?)
Message-ID: <20040207015757.A3059@pclin040.win.tue.nl>
References: <3FE986970091192E@vsmtp14.tin.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3FE986970091192E@vsmtp14.tin.it>; from rockman81@tin.it on Sat, Feb 07, 2004 at 12:34:16AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 07, 2004 at 12:34:16AM +0100, Marco Gulino wrote:

>  Where i was using the 2.4.x kernel my multimedia keyboard was sending the
>  special keys to usermode apps, allowing to control them and assign some
>  functions.
>  Now i'm on 2.6.2 and some of these keys are not working... no scancode,
>  nothing, either looking with dmesg or xev.
>  It's like the kernel is "filtering" the unknown scancodes and delete them.

Yes, unfortunately we lost raw scancode mode.
The kernel first tries to translate scancodes to keycodes,
and then, if you ask for scancodes, tries to translate back.
The first translation will fail when the table entry is undefined.
Now you'll see "atkbd.c: Unknown key ..." in the syslog.
The second translation may fail because the correspondence is not 1-1.

You can try to use setkeycodes (say, from kbd-1.12) to solve
the problem of undefined entries.

Andries
