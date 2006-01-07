Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932681AbWAGA00@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932681AbWAGA00 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 19:26:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932296AbWAGA0V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 19:26:21 -0500
Received: from pne-smtpout1-sn1.fre.skanova.net ([81.228.11.98]:37110 "EHLO
	pne-smtpout1-sn1.fre.skanova.net") by vger.kernel.org with ESMTP
	id S965375AbWAGAZ6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 19:25:58 -0500
Date: Sat, 7 Jan 2006 01:25:42 +0100 (CET)
From: Peter Osterlund <petero2@telia.com>
X-X-Sender: petero@r3000.localdomain
To: Luca Bigliardi <shammash@artha.org>
cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Dmitry Torokhov <dmitry.torokhov@gmail.com>,
       Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org
Subject: Re: request for opinion on synaptics, adb and powerpc
In-Reply-To: <20060106231301.GG4732@kamaji.shammash.lan>
Message-ID: <Pine.LNX.4.58.0601070053470.2702@telia.com>
References: <20060106231301.GG4732@kamaji.shammash.lan>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 7 Jan 2006, Luca Bigliardi wrote:

> Hi Peter,
> i'd like to have your opinion on this mail[1] (and the thread).
> Benjamin Herrenschmidt is the maintainer of linux on powerpc;
> he has rejected my patch for synaptics support on adb based trackpad
> (found on ibook and powerbook) because in his opinion the absolute mode
> should be configurable at runtime when synaptics X driver is loaded.
> IMHO his idea could be good, but i'm not aware so i'm going to ask your
> opinion.
>
> [1] http://lists.debian.org/debian-powerpc/2006/01/msg00090.html

I once suggested this a long time ago when the synaptics driver was first
included in the kernel. However, the input subsystem maintainer (Vojtech)
didn't like the idea. (The case with multiple readers reading from the
same event device would be weird if one application could switch mode and
cause another application to receive different events.)

The plan was to have the kernel report raw data to user space using the
event devices and make the X server understand it. The imps/2 emulation
done by mousedev.c (ie /dev/input/mice) would then become obsolete.

The X synaptics driver is a step in that direction, but because of
licensing conflicts the driver has not been included in Xorg. Therefore
the synaptics driver is not always present, in which case the kernel
mousedev emulation is used, which is almost always worse than the built in
emulation in the touchpad hardware that would have been used if the
touchpad was in relative mode.

Fedora handles this situation by always installing the synaptics package
and setting up the X config file automatically if the computer has a
synaptics touchpad. I guess this approach could work for other
distributions too.

-- 
Peter Osterlund - petero2@telia.com
http://web.telia.com/~u89404340
