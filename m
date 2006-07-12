Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751385AbWGLOsu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751385AbWGLOsu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 10:48:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751387AbWGLOsu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 10:48:50 -0400
Received: from dtp.xs4all.nl ([80.126.206.180]:13967 "HELO abra2.bitwizard.nl")
	by vger.kernel.org with SMTP id S1751385AbWGLOsu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 10:48:50 -0400
Date: Wed, 12 Jul 2006 16:48:48 +0200
From: Erik Mouw <erik@harddisk-recovery.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] SCSI disk won't spinup, so boot hangs
Message-ID: <20060712144848.GD7328@harddisk-recovery.com>
References: <20060712141441.GA16473@wurtel.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060712141441.GA16473@wurtel.net>
Organization: Harddisk-recovery.com
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 12, 2006 at 04:14:41PM +0200, Paul Slootman wrote:
> I was recently confronted by a SCSI disk that had crashed somehow
> ("mechanical positioning error" during the first signs of trouble). The
> kernel hung after that, despite the fact that everything was on RAID-1
> and the first disk still was working...

Sounds like a worn bearing or a head crash.

> I rebooted the system (remote powerboot, as I was 150km away). Now the
> SCSI BIOS hung on scanning the SCSI bus. "No problem", I thought, and
> disabled the BIOS scan for ID 1. Now grub appeared, and the kernel got
> loaded. However, now the "Spinning up disk..." message failed after 100s
> with the message "not responding...". The scan proceeded to try to read
> the capacity, and that hung indefinitely. Only by driving to the
> location and physically pulling the disk could I get the machine up and
> running again.
> 
> I reasoned that if the spinup fails, it doesn't make much sense to try
> and read the capacity, the partition tables, etc..  Hence I came up with
> the patch below that sets media_present to 0 when the spinup doesn't
> respond. It works for me (TM); there may be a better way, however the
> current behaviour sucks big time.

I've seen disks where the 100s timeout is not enough and which only
came into a useful state after 10 minutes or even longer. Your patch
would make those disks useless, even though they can be used. Also I'm
not sure your patch is the right approach: a disk doesn't have
removable media and yet it reports that there's no media present.


Erik

-- 
+-- Erik Mouw -- www.harddisk-recovery.com -- +31 70 370 12 90 --
| Lab address: Delftechpark 26, 2628 XH, Delft, The Netherlands
