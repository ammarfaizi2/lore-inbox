Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267982AbUHPWaa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267982AbUHPWaa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 18:30:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267986AbUHPWa2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 18:30:28 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:42911 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S267982AbUHPWaJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 18:30:09 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Alan Cox <alan@redhat.com>
Subject: Re: PATCH: straighten out the IDE layer locking and add hotplug
Date: Mon, 16 Aug 2004 23:43:35 +0200
User-Agent: KMail/1.6.2
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, torvalds@osdl.org
References: <20040815151346.GA13761@devserv.devel.redhat.com>
In-Reply-To: <20040815151346.GA13761@devserv.devel.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200408162343.35588.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> +/**
> + *	ide_hwif_restore	-	restore hwif to template
> + *	@hwif: hwif to update
> + *	@tmp_hwif: template
> + *
> + *	Restore hwif to a default state by copying most settngs

it restores hwif to previous state not the default one

> +/**
> + *	ide_add_generic_settings	-	generic /proc settings
> + *	@drive: drive being configured
> + *
> + *	Add the generic parts of the system settings to the /proc files
> + *	for this IDE device. The caller must not be holding the settings_sem
> + *	.lock
> + */

ide settings are not limited to /proc, remember about ioctls

> +/**
> + *	system_bus_clock	-	clock guess
> + *
> + *	External version of the bus clock guess used by old old IDE drivers

old old?

> +/**
> + *	ata_attach		-	attach an ATA/ATAPI device
> + *	@drive: drive to attach
> + *
> + *	Takes a drive that is as yet not assigned to any midlayer IDE
> + *	module and figures out which driver would like to own it. If

drive maybe assinged to midlayer ide-default driver

> + *	nobody claims the driver then it is automatically attached

the drive

> +/**
> + *	ide_unregister_subdriver	-	disconnect drive from driver
> + *	@drive: drive to unplug
> + *
> + *	Disconnect a drive from the driver it was attached to and then
> + *	clean up the various proc files and other objects attached to it.
> + *	Takes ide_sem, ide_lock, and drive_lock. Caller must hold none of
> + *	the locks.
> + *
> + *	No locking versus subdriver unload because we are moving to the
> + *	default driver anyway. Wants double checking.

yep, locking needs checking  (removing hwif vs removing driver)

> +/**
> + *	ide_register_driver	-	new driver loaded
> + *	@driver: the IDE driver module

driver doesn't have to be a module

IDE device driver

> +/**
> + *	ide_unregister_driver	-	IDE module unload
> + *	@driver: IDE driver module
> + *
> + *	Unload a driver module and reattach any devices to whatever

it doesn't unload given IDE device driver
