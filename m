Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269509AbTHLKOl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Aug 2003 06:14:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269578AbTHLKOl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Aug 2003 06:14:41 -0400
Received: from vicar.dcs.qmul.ac.uk ([138.37.88.163]:27360 "EHLO
	mail.dcs.qmul.ac.uk") by vger.kernel.org with ESMTP id S269509AbTHLKOj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Aug 2003 06:14:39 -0400
Date: Tue, 12 Aug 2003 11:14:29 +0100 (BST)
From: mb <mb/lkml@dcs.qmul.ac.uk>
To: linux-kernel@vger.kernel.org
Subject: 2.6.0-test2-mm1, ext3 (external journal): nasty filesystem corruption
 under high load
Message-ID: <Pine.LNX.4.56.0308121058230.2147@r2-pc.dcs.qmul.ac.uk>
X-URL: http://www.theBachChoir.org.uk/
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-uvscan-result: clean (19mWAi-0005xY-ST)
X-Auth-User: jonquil.thebachchoir.org.uk
X-uvscan-result: clean (19mWAo-0003Ki-Ep)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Admittedly I was being pathological, but I've got a new toy to play with!
Our new server is a dual-Athlon, 1.5G RAM (the other .5 failed memtest) +
about 6GB swap, with 15x70GB drives running under gdth.o with 12 as the
RAID-5 set, and the journal on 2 as a RAID-1 pair. System on IDE for now.

It's currently running Red Hat "severn" + 2.6.0-test2-mm1 (with PREEMPT
for now), and this particular stress test was attempting to build 
2.6.0-test3-mm1 with the scary invocation "make -j". More info on request.

I saw thousands of messages like:
	cc1: page allocation failure. order:0, mode:0x20
(where only the process names might change). I don't know how Bad this is.

Amazingly I could still ssh in to the box and discover that its load had
more than likely broken 1000. However, the compile started to complain
bitterly about non-ASCII characters in source files, and indeed corruption
did occur (random overwriting, it would appear).

I have a couple more weeks I can play with this box before it has to go
into production (running much older brains), and can do more tests if
anyone thinks it might be useful.

I would like to suggest the "make -j" test for those developers with
enough memory (and fast enough swap).

Matt
