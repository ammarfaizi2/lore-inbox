Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285461AbRLNTMO>; Fri, 14 Dec 2001 14:12:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285466AbRLNTME>; Fri, 14 Dec 2001 14:12:04 -0500
Received: from gw.uk.sistina.com ([62.172.100.98]:8711 "EHLO gw.uk.sistina.com")
	by vger.kernel.org with ESMTP id <S285461AbRLNTLv>;
	Fri, 14 Dec 2001 14:11:51 -0500
Date: Fri, 14 Dec 2001 19:11:50 +0000
From: Alasdair G Kergon <agk@uk.sistina.com>
To: linux-kernel@vger.kernel.org
Subject: Re: A possible direction for the next LVM driver
Message-ID: <20011214191150.C22147@uk.sistina.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <20010830164547.A807@btconnect.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010830164547.A807@btconnect.com>; from thornber@btconnect.com on Thu, Aug 30, 2001 at 04:45:47PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 30, 2001 at 04:45:47PM +0100, Joe Thornber wrote:
> I'm working on the next iteration of the LVM driver
...which is now known as the "device-mapper" because it lets you define 
new block devices that map I/O onto sections of other block devices.

> The main goal of this driver is to support volume management in
> general, not just for LVM.  The kernel should provide general
> services, not support specific applications.  eg, The driver has no
> concept of volume groups.
 
The latest version being tested is at:
  ftp://ftp.sistina.com/pub/LVM2/device-mapper/device-mapper-0.90.02.tgz
 
The tgz file contains a CVS snapshot which includes patches against 2.4.16
and some documentation (and details for the CVS repository).

Currently there's a choice between an ioctl interface and a filesystem 
interface (dmfs).
 
Example
=======
To create a "logical volume" that concatenates /dev/sdc1 with /dev/sdd2:
[units used below are 512-byte sectors]

# cat > /tmp/lv1_table
0 1028160 linear /dev/sdc1 0
1028160 3903762 linear /dev/sdd2 0
^D
# dmsetup lv1 /tmp/lv1_table

With the filesystem interface and devfs, you could also create 
/devfs/device-mapper/lv1 by hand as follows:

# mkdir /tmp/dmfs; mount -t dmfs dmfs /tmp/dmfs
# mkdir /tmp/dmfs/lv1
# cp /tmp/lv1_table /tmp/dmfs/lv1/table

Striping is also already supported (see documentation).

Alasdair
-- 
agk@uk.sistina.com
