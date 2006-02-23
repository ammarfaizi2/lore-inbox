Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750999AbWBWI4S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750999AbWBWI4S (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 03:56:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750993AbWBWI4S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 03:56:18 -0500
Received: from rwcrmhc13.comcast.net ([204.127.192.83]:56482 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S1750753AbWBWI4R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 03:56:17 -0500
Subject: Re: SATA timeouts with Seagate disk on VIA VT6420 controller
From: Nicholas Miell <nmiell@comcast.net>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1140068654.3274.12.camel@entropy>
References: <1140068654.3274.12.camel@entropy>
Content-Type: text/plain
Date: Thu, 23 Feb 2006 00:56:15 -0800
Message-Id: <1140684975.9471.3.camel@entropy>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4.njm.1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-02-15 at 21:44 -0800, Nicholas Miell wrote:
> >From time to time, I've been experiencing timeouts with my SATA disk (a
> Seagate ST3300831AS) attached to a VIA VT6420 controller on a VIA
> K8T800-based MSI motherboard. This has happened somewhat rarely on a
> variety of Fedora kernel versions.
> 
> Basically, sometimes IO will get really slow and I'll start getting
> "ata1: command 0x35 timeout, stat 0x50 host_stat 0x4" in my logs, with
> the occasional "ata1: command 0x25 timeout, stat 0x50 host_stat 0x4" and
> "ata1: command 0xb0 timeout, stat 0x50 host_stat 0x0" thrown in for good
> measure.
> 
> The disk (and/or controller) isn't unresponsive -- I can do a smartctl
> -a -d ata /dev/sda and it'll complete (eventually), and IO to the disk
> continues (very slowly), but it's generally unusable until the next
> reboot.

I actually managed to successfully unmount the filesystem and deactivate
the LVM volume group for once, which allowed me to remove and reload
sata_via, libata, sd_mod and scsi_mod.

After the drivers were reloaded, IO to the disk worked fine, which leads
me to think that sata_via and/or libata needs the ability to reset the
hardware when errors occur.

-- 
Nicholas Miell <nmiell@comcast.net>

