Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261243AbULHP77@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261243AbULHP77 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Dec 2004 10:59:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261244AbULHP77
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Dec 2004 10:59:59 -0500
Received: from stat16.steeleye.com ([209.192.50.48]:10453 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S261241AbULHP7x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Dec 2004 10:59:53 -0500
Subject: RE: How to add/drop SCSI drives from within the driver?
From: James Bottomley <James.Bottomley@SteelEye.com>
To: "Bagalkote, Sreenivas" <sreenib@lsil.com>
Cc: Matt Domsch <Matt_Domsch@Dell.com>,
       "'brking@us.ibm.com'" <brking@us.ibm.com>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "'linux-scsi@vger.kernel.org'" <linux-scsi@vger.kernel.org>,
       "'bunk@fs.tum.de'" <bunk@fs.tum.de>, "'Andrew Morton'" <akpm@osdl.org>,
       "Ju, Seokmann" <sju@lsil.com>, "Doelfel, Hardy" <hdoelfel@lsil.com>,
       "Mukker, Atul" <Atulm@lsil.com>
In-Reply-To: <0E3FA95632D6D047BA649F95DAB60E570230CA8C@exa-atlanta>
References: <0E3FA95632D6D047BA649F95DAB60E570230CA8C@exa-atlanta>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 08 Dec 2004 09:59:35 -0600
Message-Id: <1102521582.2659.2.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-12-08 at 01:16, Bagalkote, Sreenivas wrote:
> Adding a drive:- For application to use sysfs to scan newly added drive,
> it needs to know the HCTL (SCSI address - Host, Channel, Target & Lun)
> of the drive. Driver is the only one that knows the mapping between a 
> drive and the corresponding HCTL.

The real way I'd like to handle this is via hotplug.  The hotplug event
would transmit the HCTL in the environment.  Whether the drive actually
gets incorporated into the system and where is user policy, so it's
appropriate that it should be in userland.

This same infrastructure could be used by fibre channel login, scsi
enclosure events etc.

We have some of the hotplug infrastructure in SCSI, but not quite enough
for this ... you'll need an additional API.

> Removing a drive:- There is no sane way for the application to map out
> drives to /dev/sd<x>. If application has a way of knowing the HCTL of a
> deleted drive, then using that HCTL, it can match the corresponding SCSI
> device name (/dev/sd<x>) and use sysfs to remove that drive.

Since The sysfs device name contains H:C:T:L surely you can just do a
find on /sys?

James


