Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263354AbTJZRfl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Oct 2003 12:35:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263355AbTJZRfk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Oct 2003 12:35:40 -0500
Received: from griffin-can-au.getin2net.com ([203.43.225.34]:33287 "EHLO
	griffin-can-au.getin2net.com") by vger.kernel.org with ESMTP
	id S263354AbTJZRfg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Oct 2003 12:35:36 -0500
Subject: Re: 2.6.0-test8 backlight and sound problems (PMU) on PPC
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Reply-To: benh@kernel.crashing.org
To: C S Rosenmund <gnuman@comcast.net>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <3F970199.2050404@comcast.net>
References: <3F970199.2050404@comcast.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1067189725.4055.17.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sun, 26 Oct 2003 18:35:26 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-10-23 at 00:15, C S Rosenmund wrote:
> Hardware is an early iBook (first gen - Clamshell)

First, please CC me or linuxppc-dev at least on PowerMac related
reports.

> with 2.6.0-test8, sound does not recover from sleep when an application 
> is using it when the notebook is slept (can be reproduced: using pysol, 
> with sound enabled, close the lid to sleep the laptop, then anytime 
> after the sound stops (indicating that the laptop is sleeping) open the 
> lid. Sound does not return, and the application does not close) The 
> symptoms (indicated above) seem to point to the sound module (also when 
> compiled into the kernel) hanging up on sleep. Sound hardware is 
> pmac-dmasound.

Looks like the dbdma channel is stuck. I'll investigate. (Note,
Christoph Hellwig is now maintaining this driver in 2.6, also note
that Linus tree misses some sound bits, you may want to use my
bk tree from bk://ppc.bkbits.net/linuxppc-2.5-benh for now, I hope
to have everything merged upstream by 2.6.1)

> two problems on the backlight (probably related):
> the backlight control buttons do not work (the brightness of the 
> backlight does not change) and when the laptop goes to sleep, the 
> backlight does not turn off (it does turn off for console blanking as in 
> when the unit is left idle for some time, and the screen goes blank).

You aren't using the proper video driver it seems.

