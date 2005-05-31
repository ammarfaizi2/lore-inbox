Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261409AbVEaUEK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261409AbVEaUEK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 May 2005 16:04:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261408AbVEaUCD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 May 2005 16:02:03 -0400
Received: from hirsch.in-berlin.de ([192.109.42.6]:50058 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S261208AbVEaUB1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 May 2005 16:01:27 -0400
X-Envelope-From: kraxel@bytesex.org
Date: Tue, 31 May 2005 21:56:03 +0200
From: Gerd Knorr <kraxel@suse.de>
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
Cc: Joerg Schilling <schilling@fokus.fraunhofer.de>, mrmacman_g4@mac.com,
       toon@hout.vanvergehaald.nl, ltd@cisco.com, linux-kernel@vger.kernel.org,
       dtor_core@ameritech.net, 7eggert@gmx.de
Subject: Re: OT] Joerg Schilling flames Linux on his Blog
Message-ID: <20050531195603.GB28168@bytesex>
References: <26A66BC731DAB741837AF6B2E29C10171E60DE@xmb-hkg-413.apac.cisco.com> <20050530093420.GB15347@hout.vanvergehaald.nl> <429B0683.nail5764GYTVC@burner> <46BE0C64-1246-4259-914B-379071712F01@mac.com> <429C4483.nail5X0215WJQ@burner> <87acmbxrfu.fsf@bytesex.org> <20050531190556.GK23621@csclub.uwaterloo.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050531190556.GK23621@csclub.uwaterloo.ca>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

> Well I remember the first time I saw devfs running, I thought "Wow
> finally I have a way to find the disc that is scsi id 3 on controller 0
> even if I add a device at id 2 after setting up the system", something

> I think sysfs can do it too, although I haven't looked to much at sysfs
> yet.

Yep, it can.

> I don't know if the ide or scsi method is currently more sane, but it
> sure would be nice to have a consistent behaviour between the two.

On my suse 9.3, out-of-the-box, I find this (implemented via
udev rules):

   # find /dev/cd /dev/disk -type l -print | sort
   /dev/cd/by-id/HL-DT-ST_DVDRAM_GSA-4040B_K213BDG5213
   /dev/cd/by-id/LG_CD-RW_CED-8080B_2000_07_27e
   /dev/cd/by-path/pci-0000:00:04.1-ide-1:0
   /dev/cd/by-path/pci-0000:00:04.1-ide-1:1
   /dev/disk/by-id/IBM-DTLA-305040_YJEYJM36751
   /dev/disk/by-id/IBM-DTLA-305040_YJEYJM36751p1
   [ ... ]
   /dev/disk/by-id/SIBM_DCAS-34330_B3GX3681
   /dev/disk/by-id/SIBM_DCAS-34330_B3GX3681p1
   /dev/disk/by-id/SIBM_DCAS-34330_B3GX3681p2
   /dev/disk/by-label/WIN98
   /dev/disk/by-label/unknown
   /dev/disk/by-path/pci-0000:00:04.1-ide-0:0
   /dev/disk/by-path/pci-0000:00:04.1-ide-0:0p1
   [ ... ]
   /dev/disk/by-path/pci-0000:00:0e.0-scsi-0:0:0:0
   /dev/disk/by-path/pci-0000:00:0e.0-scsi-0:0:0:0-generic
   /dev/disk/by-path/pci-0000:00:0e.0-scsi-0:0:0:0p1
   /dev/disk/by-path/pci-0000:00:0e.0-scsi-0:0:0:0p2
   /dev/disk/by-uuid/3140-1206
   /dev/disk/by-uuid/5fbce796-2a1a-4ea3-bd5f-be35b28b2fb1
   /dev/disk/by-uuid/b6a45df7-63bb-4890-b5d2-7bdcbe6c70a5
   /dev/disk/by-uuid/cb367983-ac59-42cd-839d-b5cf0735fae5
   /dev/disk/by-uuid/unknown
 
You'll have stable names both by connection path (great for the
raid case) and by device name (useful for the usb burner which
you plug into a different port each time).  Guess you'll find
there what you are looking for ;)

  Gerd

-- 
export CDR_DEVICE=/dev/cd/by-id/LG_CD-RW_CED-8080B_2000_07_27e
