Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262186AbTKYJli (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Nov 2003 04:41:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262188AbTKYJli
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Nov 2003 04:41:38 -0500
Received: from mail.x-plor.com ([196.37.99.211]:26852 "EHLO
	x-plor-mail.jhb-xplor") by vger.kernel.org with ESMTP
	id S262186AbTKYJlf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Nov 2003 04:41:35 -0500
content-class: urn:content-classes:message
Subject: RE: New model of SanDisk compact flash not working
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Date: Tue, 25 Nov 2003 11:46:11 +0200
X-MimeOLE: Produced By Microsoft Exchange V6.0.4417.0
Message-ID: <0887314A0D67E14C8C255BEF09FC3D99501159@x-plor-mail.jhb-xplor>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: New model of SanDisk compact flash not working
Thread-Index: AcOy2vHq3SAbotkKTbOvdSp+Lt2cagAXYKyg
From: "gmlinux" <gmlinux@x-plor.com>
To: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 25 Nov 2003 09:46:12.0609 (UTC) FILETIME=[F62B7710:01C3B338]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I seem to have sorted out the problem.

It was definately a dma problem causing the hang, confirmed by Peter
Missel, thanks Peter. See the quote below:
"DMA not being part of the CF standard yet, SanDisk and IBM are a bit
ahead
of the game. The problem you're running into is that the vast majority
of
CF-IDE adapters do not connect the DMA request and grant signals. Hence,
the
system BIOS and OS drivers see a DMA capable drive on a DMA capable IDE
channel, and set things up to use DMA. Instant hang - you know that
already."

It seems the adaptor is missing a few hardware lines, confirmed on my
side.
I can get the drive up with an "ide=nodma".

The drive is still unusable, unable to read or write from it. However,
if I "dd" an image from the previous version of drive, in otherwords
creating the partition and filesystem etc, the drive seems to work okay.
Maybe the default filesystem that comes on the drive was causing some
issues.

Other than that I think we will just have to wait for the hardware
adaptor to catch up with the flash technology.

Garth
