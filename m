Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264788AbTCEIaw>; Wed, 5 Mar 2003 03:30:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264797AbTCEIaw>; Wed, 5 Mar 2003 03:30:52 -0500
Received: from natsmtp01.webmailer.de ([192.67.198.81]:35068 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S264788AbTCEIav>; Wed, 5 Mar 2003 03:30:51 -0500
Date: Wed, 5 Mar 2003 09:39:33 +0100
From: Dominik Brodowski <linux@brodo.de>
To: mochel@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: sys/fs and sys/block
Message-ID: <20030305083932.GA792@brodo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pat,

I'm a bit surprised to find yet another top-level directory in sysfs --
"fs". Wouldn't it be a bit more driver-model-conforming if there'd be a
"bus_type block_bus_type" with devices like "hda", "fd0", "loop0", and each
such block device registers a device like "hda1" for partitions of "bus_type
filesystem_bus_type" (or "partition_bus_type"). And the device drivers for 
these devices are then the filesystems. 

A few example on how this could look like in sysfs:

sys/devices/pci0/00:07.1/ide0/hda/hda1
sys/devices/platform/fd0/fd0

? sys/devices/virtual/loop0  (a new "virtual" bus would allow us to register
				"virtual" and "dummy" devices)

sys/bus/filesystem/devices/hda1
sys/bus/filesystem/devices/fd0

sys/bus/filesystem/drivers/xfs

sys/bus/block/devices/hda

Oh, and is the kobj in super_block (which was added in the same sys/fs
patch) used anywhere?

	Dominik
