Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265334AbTL0G4n (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Dec 2003 01:56:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265335AbTL0G4n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Dec 2003 01:56:43 -0500
Received: from simmts12.bellnexxia.net ([206.47.199.141]:24201 "EHLO
	simmts12-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S265334AbTL0G4m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Dec 2003 01:56:42 -0500
Message-ID: <3FED2D41.5020604@sympatico.ca>
Date: Sat, 27 Dec 2003 06:57:05 +0000
From: Tyler Hall <tyler_hall@sympatico.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030313
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: sysfs classes
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Can someone please explain the philosophy of the /sys heirarchy? I've searched through the mailing list archives but find very little about it.

I was expecting a directory layout according to different topologies: bus, hardware class, and generic "block" & "char". Bus/ would contain a sub-dir for each supported bus (kindof exists now, but they're sitting at /sys level, not in separate bus/ dir). Class/ would contain a sub-dir for each of the popular hardware _functionality_ classes, very similar to PCI/USB/PCMCIA classes (audio, harddisk, floppy, cdrom, printer, video, network, etc.) and subclasses. Each of those would contain instance subdirectories of that class (two sound cards look like audio/0 and audio/1). Class/ would actually look a bit like M$ Windows hardware class topology. Graphical linux tools already implement this locally, but I think since class/ already exists in sysfs and the kernel is the master of all hardware it should also provide the means of organizing the hardware in various ways, including functional classification (instead of, say, leaving this up to udev). Has this already been discussed b
efore?

For example, if I was writing a cd burner app and I wanted to have the user select a burner from a list, I could simply pull from something like /sys/class/cdrom/* rather than implement my own scanning algorithm like 'cdrecord' had to do (-scanbus switch). Or if for some reason I have a parallel port zip drive and an IDE zip drive I can refer to /sys/class/disk/zip/0/device and /sys/class/disk/zip/1/device. Or another example, I plug in my USB flash key, and assuming it's the only USB flash key in my system I could refer to it as /sys/class/disk/flash/0/device. I guess techinically you usually refer to partitions so it might really be /sys/class/disk/xxx/0/part/0 or something.

I think a frontend for udev could benefit from this also. Say you plug in a USB laser printer for the first time. Once the device has been registered under the proper bus topology directory, it can fetch the class info from the device and set up another instance (or symlink) under something like /sys/class/printer/laser/0. Then it calls hotplug which could use dbus to alert the frontend app. The frontend app could spawn some printer configuration app, then modify the udev config file to permanently bind that class instance to a user-defined device name like /dev/printer.

A window manager could quickly fetch class info from /sys/class to determine what kind of icons to show for various devices.

Was this the original intent of the class sub-dir? I don't think bus topologies should go under class/, especially since some of the bus topologies are already pulled out from class/.

Tyler

