Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265443AbUAAUmK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jan 2004 15:42:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264566AbUAAUjN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jan 2004 15:39:13 -0500
Received: from hueytecuilhuitl.mtu.ru ([195.34.32.123]:60170 "EHLO
	hueymiccailhuitl.mtu.ru") by vger.kernel.org with ESMTP
	id S265410AbUAAUds (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jan 2004 15:33:48 -0500
From: Andrey Borzenkov <arvidjaar@mail.ru>
To: linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: removable media revalidation - udev vs. devfs or static /dev
Date: Thu, 1 Jan 2004 23:33:04 +0300
User-Agent: KMail/1.5.3
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200401012333.04930.arvidjaar@mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

udev names are created when kernel detects corr. device. Unfortunately for 
removable media kernel rescans for partitions only when I try to access 
device. Meaning - because kernel does not know partition table it did not 
send hotplug event so udev did not create device nodes. But without device 
nodes I have no way to access device in Unix :(

specifically I have now my Jaz and I have no (reasonable) way to access 
partition 4 assuming device nodes are managed by udev.

devfs solved this problem by

- always exporting at least handle to the whole disk (sda as example)
- using something simple like dd if=/dev/sda count=1 on lookup for 
non-existing partition (/dev/sda4) that would rescan partitions and create 
device nodes for them.

static /dev simply has all nodes available and does not suffer from this 
problem at all.

unfortunately there are no lookup events in case if udev ... meaning at this 
moment user must manually rescan partitions after inserting new media. I do 
not see any way to solve this problem at all given current implementation. 
The closest is to blindly create nodes for all partitions as soon as block 
device is available. 

-andrey

