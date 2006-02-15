Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946003AbWBOQDn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946003AbWBOQDn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 11:03:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946002AbWBOQDn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 11:03:43 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:12506 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1946003AbWBOQDm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 11:03:42 -0500
Subject: Re: RFC: disk geometry via sysfs
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Phillip Susi <psusi@cfl.rr.com>
Cc: Seewer Philippe <philippe.seewer@bfh.ch>,
       Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <43F346DA.4020404@cfl.rr.com>
References: <43EC8FBA.1080307@bfh.ch> <43F0B484.3060603@cfl.rr.com>
	 <43F0D7AD.8050909@bfh.ch> <43F0DF32.8060709@cfl.rr.com>
	 <43F206E7.70601@bfh.ch> <43F21F21.1010509@cfl.rr.com>
	 <43F2E8BA.90001@bfh.ch>
	 <58cb370e0602150051w2f276banb7662394bef2c369@mail.gmail.com>
	 <1140012392.14831.13.camel@localhost.localdomain>
	 <43F346DA.4020404@cfl.rr.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 15 Feb 2006 16:06:55 +0000
Message-Id: <1140019615.14831.22.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2006-02-15 at 10:20 -0500, Phillip Susi wrote:
> I thought that C/H/S addressing was purely a function of int 13, not the 
> hardware interface?  If it is a function of some older hardware 
> interfaces, then we are still talking about two different, and likely 
> incompatible geometries:  the one the disk reports, and the one the bios 
> reports.  The values in the MBR must be the values the bios reports. 

We have at least three

Disk reported C/H/S
BIOS reported C/H/S (hda/hdb only)
Actual C/H/S (if it exists)
Partition table C/H/S

A partitioning tool needs to know
	Disk reported C/H/S
	Partition table C/H/S
	Preferably BIOS reported C/H/S if there is one

The partition table C/H/S is on disk so trivial
The disk reported ones are in the identify block so could be pulled via
	/proc and sysfs
The BIOS one is PC specific low memory poking around

I agree entirely that HD_GETGEO itself shouldn't matter.

