Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932167AbVHWN2I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932167AbVHWN2I (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 09:28:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932169AbVHWN2I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 09:28:08 -0400
Received: from ausc60ps301.us.dell.com ([143.166.148.206]:46937 "EHLO
	ausc60ps301.us.dell.com") by vger.kernel.org with ESMTP
	id S932167AbVHWN2G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 09:28:06 -0400
X-IronPort-AV: i="3.96,134,1122872400"; 
   d="scan'208"; a="283469542:sNHT24806172"
Date: Tue, 23 Aug 2005 08:28:06 -0500
From: Matt Domsch <Matt_Domsch@dell.com>
To: Jess Balint <jbalint@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Ext3 Errors on Dell RAID
Message-ID: <20050823132805.GA27336@lists.us.dell.com>
References: <68cb949d05082306051b39e317@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <68cb949d05082306051b39e317@mail.gmail.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 23, 2005 at 09:05:27AM -0400, Jess Balint wrote:
> Problem:
> I get massive ext3 errors once every few days. See "errors on console"
> section below. Almost all commands return I/O error. I have to power
> cycle the machine to get it running again. Upon reboot, there are
> usually 3 orphan inodes deleted and everything is fine. See "messages
> on reboot" below.
> 
> Configuration:
> System: Dell PowerEdge 6300/500, 4 CPU SMP w/2GB memory
> Discs: 3 SCSI discs in a controller-managed striped configuration
> Controller: Dell PERC-2
> kernel messages in "kernel boot messages" below

This looks very familiar, and given the firmware versions you mention,
is probably a known issue.  The controller firmware goes to do a cache
flush, but that doesn't complete in a sane amount of time, and
eventually the SCSI midlayer starts aborting commands and taking the
file system offline.

I don't believe a firmware update was released for your add-in PERC2
quad-channel card.  Firmware 6091 was released for the PERC3/Di ROMBs
which addresses this exact case, though other failures have been
reported on linux-poweredge@dell.com (subscribe and read archives at
http://lists.us.dell.com) even with newer firmware.

The workarounds include:
1) disable the read and write cache using afacli.
2) mount file systems using 'noatime'.
3) backup your data, replace the controller with something newer
(disks on the onboard aic7xxx controller combined with Linux Software
RAID works quite well), recreate your RAID array on the new
controller, and restore your data from backups.

Thanks,
Matt

-- 
Matt Domsch
Software Architect
Dell Linux Solutions linux.dell.com & www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com
