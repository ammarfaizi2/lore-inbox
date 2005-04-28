Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262161AbVD1PtU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262161AbVD1PtU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Apr 2005 11:49:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262159AbVD1PtT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Apr 2005 11:49:19 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:59855 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S262158AbVD1PtN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Apr 2005 11:49:13 -0400
Subject: Multiple functionality breakages in 2.6.12rc3 IDE layer
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1114703284.18809.208.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 28 Apr 2005 16:48:05 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ages ago we added an ide_default driver to clean up all the corner cases
like spurious IRQs for a device with no matching driver (eg ide-cd and
no CD driver) as well as ioctls and file access. 

2.6.12rc removes it. Unfortunately it also means that if your only IDE
interface is one you hand configure you can no longer run Linux. It also
changes other aspects of behaviour although they don't look problematic
for most users. You can no longer
	- Control the bus state of an interface
	- Reset an interface
	- Add an interface if none exist
	- Issue raw commands
	- Get an objects bios geometry
	- Read the identify data by ioctl (its still in proc but may be stale)

without having a device specific driver loaded matching the media - and
that only works if its already detected the device correctly.

I don't have the tools at the moment to generate spurious IRQ's for
devices with no driver loaded but it does look like the code may well
then crash. From the way the changes were done it appears the current
IDE maintainers never appreciated that ide_default existed for far more
than just cleaning up ide-proc but also to handle IRQ's, opening of
empty slots, ioctls and power
management ?

The ability to specify the IDE ports on the command line as needed for
some Sony laptop installs have also become "obsolete" over time. They
still appear to work but spew a warning that the user will soon be
screwed.

Alan

