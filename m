Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262091AbULQReR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262091AbULQReR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Dec 2004 12:34:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262089AbULQReQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Dec 2004 12:34:16 -0500
Received: from main.gmane.org ([80.91.229.2]:36032 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S262096AbULQRdt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Dec 2004 12:33:49 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Dan Stromberg <strombrg@dcs.nac.uci.edu>
Subject: Re: recovering data from a corrupt ext3?
Date: Fri, 17 Dec 2004 09:33:26 -0800
Message-ID: <pan.2004.12.17.17.33.23.632154@dcs.nac.uci.edu>
References: <pan.2004.12.16.18.20.43.438752@dcs.nac.uci.edu> <1103226657.21806.28.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: tesuji.nac.uci.edu
User-Agent: Pan/0.14.2 (This is not a psychotic episode. It's a cleansing moment of clarity.)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Dec 2004 19:50:59 +0000, Alan Cox wrote:

This is what worked for me:

On FC3's rescue disk:

1) Do startup network interfaces
2) Don't try to automatically mount the filesystems - not even readonly
3) lvm vgchange --ignorelockingfailure -P -a y
4) fdisk -l, and guess which partition is which based on size: the small one was /boot, and the large one was /
5) mkdir /mnt/boot
6) mount /dev/hda1 /mnt/boot
7) Look up the device node for the root filesystem in /mnt/boot/grub/grub.conf
8) A first tentative step, to see if things are working: fsck -n /dev/VolGroup00/LogVol00
9) Dive in: fsck -f -y /dev/VolGroup00/LogVol00
10) Wait a while...  Be patient.  Don't interrupt it
11) Reboot


