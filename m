Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263442AbTJLJ01 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Oct 2003 05:26:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263447AbTJLJ01
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Oct 2003 05:26:27 -0400
Received: from smtp2.att.ne.jp ([165.76.15.138]:52955 "EHLO smtp2.att.ne.jp")
	by vger.kernel.org with ESMTP id S263442AbTJLJ0Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Oct 2003 05:26:25 -0400
Message-ID: <2c8a01c390a2$cee80640$5cee4ca5@DIAMONDLX60>
From: "Norman Diamond" <ndiamond@wta.att.ne.jp>
To: "Mikael Pettersson" <mikpe@csd.uu.se>, <pavel@ucw.cz>,
       <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0-test6 APM/IDE double-suspend weirdness
Date: Sun, 12 Oct 2003 18:23:51 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mikael Pettersson and Pavel Machek wrote:

> > > In test6 (and test5 and possibly earlier), when suspending
> > > my aging Latitude with APM, the machine turns off, only to
> > > turn itself on again one second later with the disk spinning
> > > up. Then it turns itself off again a second later.

In test7 and earlier, when suspending (using command "apm -s" since
2.6.0-test[1-7] disable the keyboard's hotkeys), my Let's Note turns off the
hard disk, only to turn on the hard disk one second later, and then finally
put the entire machine in suspend-to-RAM.

>  > Try removing pm_send_all from apm.c
>
> Ok I tried removing all pm_send_all from apm.c.
> I made no difference at all.

I am not surprised.  2.4.20 has the same pm_send_all but does not have
double-suspend weirdness.  I removed the call device_suspend(3) instead,
since 2.4.20 didn't call device_suspend(3).  This solved it for me in
2.6.0-test7.

Hmm.  I've been running with apm=debug for a while, ever since checking
whether the keyboard's hotkeys really were completely disabled (they were,
the BIOS doesn't even find out that I pressed the suspend key or hibernate
key).  I wonder if hda powered up again just to write a syslog entry?  But
still, it doesn't happen any more after I removed the call
device_suspend(3).

What is the intended effect of device_suspend(3)?  Am I asking for trouble
by removing it?

