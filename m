Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263909AbTL2R65 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Dec 2003 12:58:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263927AbTL2R65
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Dec 2003 12:58:57 -0500
Received: from fw.osdl.org ([65.172.181.6]:27087 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263909AbTL2R64 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Dec 2003 12:58:56 -0500
Date: Mon, 29 Dec 2003 09:58:52 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: dju` <dju.ml@elegiac.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0 + logitech wheel mouse optical usb
In-Reply-To: <3FF04FF3.70006@elegiac.net>
Message-ID: <Pine.LNX.4.58.0312290956110.11299@home.osdl.org>
References: <3FF04FF3.70006@elegiac.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 29 Dec 2003, dju` wrote:
> 
> I've tested 2.6.0 and I found something weird with my mouse (which used 
> to work well with 2.4).
> 
> Clicking on the mouse buttons does nothing for about 15% of the clicks 
> (using the wheel has this behaviour too) for the first hour of uptime.

Magical.

If it was the first five minutes, I'd not be horribly surprised, because 
we have a jiffies wrap at five minutes to try to find misuses of the time 
counter. But an hour? 

Just for fun, try changing include/linux/time.h, to make the

	#define INITIAL_JIFFIES ((unsigned long)(unsigned int) (-300*HZ))

just be a simple

	#define INITIAL_JIFFIES 0UL

and see if that makes any difference... 

		Linus
