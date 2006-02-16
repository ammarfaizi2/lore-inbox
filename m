Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932330AbWBPSOO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932330AbWBPSOO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Feb 2006 13:14:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932548AbWBPSON
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Feb 2006 13:14:13 -0500
Received: from ausc60pc101.us.dell.com ([143.166.85.206]:34482 "EHLO
	ausc60pc101.us.dell.com") by vger.kernel.org with ESMTP
	id S932330AbWBPSON (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Feb 2006 13:14:13 -0500
X-IronPort-AV: i="4.02,120,1139205600"; 
   d="scan'208"; a="381983444:sNHT163956372"
Date: Thu, 16 Feb 2006 12:14:14 -0600
From: Matt Domsch <Matt_Domsch@dell.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Phillip Susi <psusi@cfl.rr.com>, Seewer Philippe <philippe.seewer@bfh.ch>,
       Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: RFC: disk geometry via sysfs
Message-ID: <20060216181414.GB28554@lists.us.dell.com>
References: <43F0B484.3060603@cfl.rr.com> <43F0D7AD.8050909@bfh.ch> <43F0DF32.8060709@cfl.rr.com> <43F206E7.70601@bfh.ch> <43F21F21.1010509@cfl.rr.com> <43F2E8BA.90001@bfh.ch> <58cb370e0602150051w2f276banb7662394bef2c369@mail.gmail.com> <1140012392.14831.13.camel@localhost.localdomain> <43F346DA.4020404@cfl.rr.com> <1140019615.14831.22.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1140019615.14831.22.camel@localhost.localdomain>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 15, 2006 at 04:06:55PM +0000, Alan Cox wrote:
> On Mer, 2006-02-15 at 10:20 -0500, Phillip Susi wrote:
> > I thought that C/H/S addressing was purely a function of int 13, not the 
> > hardware interface?  If it is a function of some older hardware 
> > interfaces, then we are still talking about two different, and likely 
> > incompatible geometries:  the one the disk reports, and the one the bios 
> > reports.  The values in the MBR must be the values the bios reports. 
> 
> We have at least three
> 
> Disk reported C/H/S
> BIOS reported C/H/S (hda/hdb only)
> Actual C/H/S (if it exists)
> Partition table C/H/S
> 
> A partitioning tool needs to know
> 	Disk reported C/H/S
> 	Partition table C/H/S
> 	Preferably BIOS reported C/H/S if there is one
> 
> The partition table C/H/S is on disk so trivial
> The disk reported ones are in the identify block so could be pulled via
> 	/proc and sysfs
> The BIOS one is PC specific low memory poking around

On i386 and x86_64, the edd module reports the 2 types of C/H/S values
as BIOS knows them, in /sys/firmware/edd/int13_dev*/

legacy_max_cylinder, legacy_max_head, and legacy_max_sectors_per_track
are int13 AH=08h values.

default_cylinders, default_heads, and default_sectors_per_track are
int13 AH=48h values.

Files not in that directory mean the value reported by BIOS was zero.

-- 
Matt Domsch
Software Architect
Dell Linux Solutions linux.dell.com & www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com
