Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262719AbTDIEh3 (for <rfc822;willy@w.ods.org>); Wed, 9 Apr 2003 00:37:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262721AbTDIEh3 (for <rfc822;linux-kernel-outgoing>); Wed, 9 Apr 2003 00:37:29 -0400
Received: from granite.he.net ([216.218.226.66]:49931 "EHLO granite.he.net")
	by vger.kernel.org with ESMTP id S262719AbTDIEh1 convert rfc822-to-8bit (for <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Apr 2003 00:37:27 -0400
Date: Tue, 8 Apr 2003 21:50:57 -0700
From: Greg KH <greg@kroah.com>
To: "Tomasz Torcz, BG" <zdzichu@irc.pl>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [2.5.67] buffer layer error at fs/buffer.c:127; problems with via686a sensor
Message-ID: <20030409045057.GA8855@kroah.com>
References: <20030408162118.GA10209@irc.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20030408162118.GA10209@irc.pl>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 08, 2003 at 06:21:18PM +0200, Tomasz Torcz, BG wrote:
> 
> Also, I had problem compiling via686a sensors into the kernel.
> First, it complained about missing i2c_detect(); I've
> replaced it by i2c_probe(); kernel has built and booted.

That was a Kconfig bug of mine in drivers/i2c/chips.  A patch for this
has been posted to lkml in the past.  And replacing i2c_detect() with
i2c_probe() _should_ work for you, it might not, I'm still trying to
work out the real differences...

> Only sysfs directory of sensor is empty :(
> It works with 2.4.x lm_sensors (via /proc of course).

What i2c bus driver are you using?

> /sys/bus/i2c/drivers:
> total 0
> drwxr-xr-x    4 root     root            0 kwi  8 14:21 .
> drwxr-xr-x    4 root     root            0 kwi  8 14:21 ..
> drwxr-xr-x    2 root     root            0 kwi  8 14:21 VIA686A
> drwxr-xr-x    2 root     root            0 kwi  8 14:21 i2c-dev dummy dr

Ah, need to go fix up that driver's name, thanks for pointing it out.

greg k-h
