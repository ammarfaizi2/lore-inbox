Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267556AbSKQTNF>; Sun, 17 Nov 2002 14:13:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267558AbSKQTNE>; Sun, 17 Nov 2002 14:13:04 -0500
Received: from keetweej.xs4all.nl ([213.84.46.114]:384 "EHLO
	muur.intranet.vanheusden.com") by vger.kernel.org with ESMTP
	id <S267556AbSKQTND>; Sun, 17 Nov 2002 14:13:03 -0500
From: "Folkert van Heusden" <folkert@vanheusden.com>
To: "'Marc-Christian Petersen'" <m.c.p@wolk-project.de>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: 2.[45] fixes for design locking bug in wait_on_page/wait_on_buffer/get_request_wait
Date: Sun, 17 Nov 2002 20:19:53 +0100
Message-ID: <007f01c28e6e$4f1072e0$3640a8c0@boemboem>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.2416 (9.0.2910.0)
In-Reply-To: <200211171832.12855.m.c.p@wolk-project.de>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Andrea, this makes a difference! The pausings are much less than before,
> but still occur. Situation below.
MP> So, after some time in trying to exchange 2.4.20-rc2 files with the
following
MP> files from 2.4.18 (and compile successfully)
MP> drivers/block/ll_rw_blk.c
MP> drivers/block/elevator.c
MP> include/linux/elevator.h
MP> those "pauses/stopps" are _GONE_!

What is really strange, is that while I run the following in the
boodscripts:

echo "90 500 0 0 600000 600000 95 20 0" > /proc/sys/vm/bdflush
elvtune /dev/hda1 -r 2048 -w 131072

I never experience those stalls at all!
And that was surely I was expecting (clean buffers at 90% and do that
synchronouse at 95% gives little room for the first to complete before new
buffers get dirty. also that elevator-fiddling should force large bursts
(why am I doing this anyway? I wanted to configure the kernel et al so that
as minimal as possible disk-reads/writes occur))

