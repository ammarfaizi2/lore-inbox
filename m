Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264957AbTGCQeY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jul 2003 12:34:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264893AbTGCQdz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jul 2003 12:33:55 -0400
Received: from catv-d5dea48a.bp11catv.broadband.hu ([213.222.164.138]:58895
	"EHLO domesticus.fery-local.hu") by vger.kernel.org with ESMTP
	id S264930AbTGCQLB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jul 2003 12:11:01 -0400
Date: Thu, 3 Jul 2003 18:24:31 +0200 (CEST)
From: Ferenc Engard <ferenc@engard.hu>
To: linux-kernel@vger.kernel.org
Subject: Geode GX1, video acceleration -> crash
Message-ID: <Pine.LNX.4.40.0307031759060.10456-100000@domesticus.fery-local.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello there,

First of all, I am new to the framebuffer business, and looks like
that the linux-fbdev.org site is down. Where can I find a mailing list
or other information resource about framebuffers in general, and about
Geode hardware specifically? It is a nightmare to find any information
for Geode on linux... :((

I am developing a graphical app for an Advantech PCM-5820 (I think :),
i.e. a Geode GX1 / CS5530 board, 64MB RAM, which I want to run a linux
/ framebuffer application on.

Now, about my problem:

I have installed the 2.4.17 kernel, patched with NSC's original Geode
fb driver (nsc-kfb-driver-2.7.7.tar.gz), and compiled it successfully.
Also, as I couldn't find in other places, I have downloaded the
nsc_xfree_2.7.6.tgz package just to compile the GAL library
(nsc_galfns.c) in it, as this was what I needed.

First surprise: I cannot switch into 32bpp modes! Did I miss
something? fbset refuses it, setting at boot time do not work either.

Next, I have written a small application to test the processor's
bitblt capability. The program calls Gal_screen_to_screen_blt() to
scroll a rectangle on the screen, then usleeps a bit. It does work,
although the scheduler do not give back the run to the task until
approx. 20ms elapses (no problem at now), and in 16bpp, it do not
scroll the region but inverses it(?!).  I suppose that it is not good
that the console writes out things while the bitblt engine works.
Question: should I disable writing to the console while my app runs?
How?

But the real problem is, that I wanted to benchmark the system while
the scrolling continues, and issued a
dd if=/dev/mem of=/dev/null bs=1024 count=32768
command. For the second go, the system freezed like a good
refrigerator. No kernel panic, nothing, just freezed. It can be
repeated, if I copy just the 1st MB of RAM, then it freezes for the
5-6th go. :((

What can I do? How to debug?

Please cc your answers to ferenc@engard.hu, too!

Thank you:
Circum

