Return-Path: <linux-kernel-owner+willy=40w.ods.org-S283665AbUKBFjg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S283665AbUKBFjg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 00:39:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S376520AbUKAWZX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 17:25:23 -0500
Received: from zero.voxel.net ([209.123.232.253]:28879 "EHLO zero.voxel.net")
	by vger.kernel.org with ESMTP id S278332AbUKATwn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 14:52:43 -0500
Date: Mon, 1 Nov 2004 13:52:00 -0600
From: "W. Michael Petullo" <mike@flyn.org>
To: linux-kernel@vger.kernel.org
Subject: Dm-crypt, device-mapper and sysfs
Message-ID: <20041101195200.GA11321@imp.flyn.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
X-Operating-System: Linux imp.flyn.org 2.6.9 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am interested in allowing the Hardware Abstraction Layer (HAL) to
interface with dm-crypt devices.  I would like to see hald have the
ability to automatically mount removable encrypted drives when they are
plugged in.

I have a working prototype of this idea except for one issue.
Currently, dm-crypt registers its managed devices in the kernel's
sysfs.  This is good.  However, unlike most of the devices in
/sys, dm-crypt devices don't have a link named device.  For most
devices, this link specifies the bus the device is connected to.
On my iBook, for example, /sys/block/hda/device points to
/sys/devices/pci0002:02/0002:02:0d.0/ide0/0.0.  This is my IDE bus.

Hald expects to find a link like this when it is building its device tree.

I've discussed this issue on the dm-crypt mailing list and Christophe
thinks this is a more general device-mapper issue.  So I don't put words
in his mouth, here is what he said:

> dm-crypt is a device-mapper target, it doesn't do any sysfs interaction.
> There were some plans, even patches, to export more device-mapper
> functionality into sysfs. Besides, a mapped device can consist of
> several other devices and different targets. cryptsetup has the ability
> to query an existing device, it will tell you if it is a "valid
> cryptsetup'ed device". Also there a are plans to put some metadata into
> the first blocks of the device so that it can be automatically
> recognized as encrypted device.

So my question is this:

Should the device-mapper driver be modified to provide a device link?
If so, what should it point to?

-- 
Mike

:wq
