Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264701AbUHGXLY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264701AbUHGXLY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Aug 2004 19:11:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264723AbUHGXLY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Aug 2004 19:11:24 -0400
Received: from the-village.bc.nu ([81.2.110.252]:36292 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S264701AbUHGXLT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Aug 2004 19:11:19 -0400
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Cc: mj@ucw.cz, James Bottomley <James.Bottomley@SteelEye.com>, axboe@suse.de,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200408070001.i7701PSa006663@burner.fokus.fraunhofer.de>
References: <200408070001.i7701PSa006663@burner.fokus.fraunhofer.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1091916508.19077.24.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sat, 07 Aug 2004 23:08:29 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sad, 2004-08-07 at 01:01, Joerg Schilling wrote:
> >There is one: hotplug. The physical topology of buses where all the SCSI-like
> >devices (being it ATAPI devices, iSCSI, USB disks or other such beasts)
> >are connected is too complex, so every attempt to map them to the
> >(bus, target, lun) triplets in any sane way is destined to fail.
> 
> I see always the same answers from Linux people who don't know anyrthing than
> their belly button :-(
> 
> Chek Solaris to see that your statements are wrong.

Solaris also can't handle the problematic cases. One of the big problems
being that bus, target, lun (or controller, bus, target, lun) are not
actually constants in all cases.

On some Dell storage arrays for example the disks are
bus 0, target 0..4  bus 1, target 0..4 - until that is the cleaner
trips over one of the SCSI cables at which point it becomes bus 0, 
lun 0...9, live, while running.

An even more fun one is SCAM, although its a mostly dead nonstandard
thankfully. With SCAM you can get your devices changing target across
a suspend/resume.

BTW while I remember cdrecord has a bug with hardcoded iso8859-1
copyright symbols in it which mean your copyright banner is invalid
unicode on a UTF-8 locale.


