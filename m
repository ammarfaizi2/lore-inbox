Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751265AbVIRBx5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751265AbVIRBx5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Sep 2005 21:53:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751267AbVIRBx5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Sep 2005 21:53:57 -0400
Received: from mx2.palmsource.com ([12.7.175.14]:15070 "EHLO
	mx2.palmsource.com") by vger.kernel.org with ESMTP id S1751265AbVIRBx5 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Sep 2005 21:53:57 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: Why don't we separate menuconfig from the kernel?
Date: Sat, 17 Sep 2005 18:53:55 -0700
Message-ID: <DE88BDF02F4319469812588C7950A97E93121E@ussunex1.palmsource.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Why don't we separate menuconfig from the kernel?
Thread-Index: AcW77yBlK+nMCNELSla5oOwrL0djIAAAvE2w
From: "Martin Fouts" <Martin.Fouts@palmsource.com>
To: <jesper.juhl@gmail.com>, "Krzysztof Halasa" <khc@pm.waw.pl>
Cc: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I don't have a patch yet, but I've just spent a bit of time looking at
how kbuild works, and I believe there is a fairly straightforward way to
keep kbuild in the kernel tree but make it easy to split it out so that
someone could use it as a separate tool.

If this idea, appropriately modified, makes sense, I'll spend a bit of
time to do a patch and set it up.

The basic idea is that kbuild stays in the kernel source tree, but a
simple script is used to grab a copy of it out of the tree.  That copy
is maintained as a separate "build/configuration" package, and the
maintainer (yes, I'm volunteering) would keep the two versions in (near)
sync.

After a quick glance, it looks like one would want to copy

Documentation/kbuild/*
Scripts/kconfig/*
Makefile

To this new copy.  The only real work to get started, it appears, and
the reason why I'd rather have a discussion before I start, would be to
split the toplevel Makefile up a bit, so that the 'pure kbuild' bits
were moved into an include file. It's really that include file, not the
toplevel Makefile that would need to be copied.

I suggest doing this because most of the make-related knowledge about
kbuild itself is in that Makefile, but non-kernel users would not want
the kernel specific targets.

I know of two other packages (busybox and ptxdist) that use kconfig now,
and have been contemplating it for some of my projects, as well, so I'm
interested enough to take the project on.

Marty
