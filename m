Return-Path: <linux-kernel-owner+w=401wt.eu-S932602AbWLPUev@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932602AbWLPUev (ORCPT <rfc822;w@1wt.eu>);
	Sat, 16 Dec 2006 15:34:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932607AbWLPUev
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Dec 2006 15:34:51 -0500
Received: from smtp20.orange.fr ([80.12.242.27]:13384 "EHLO smtp20.orange.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932602AbWLPUeu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Dec 2006 15:34:50 -0500
X-ME-UUID: 20061216203448565.8A1CD1C00099@mwinf2012.orange.fr
Message-ID: <45845867.4040409@free.fr>
Date: Sat, 16 Dec 2006 21:34:47 +0100
From: Laurent Riffard <laurent.riffard@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.8.0.7) Gecko/20060405 SeaMonkey/1.0.5
MIME-Version: 1.0
To: "A. Kalten" <akalten@comcast.net>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: DVD-RAM cannot be mounted RW with 2.6.18/2.6.19
References: <20061216145516.13bdeb68.akalten@comcast.net>
In-Reply-To: <20061216145516.13bdeb68.akalten@comcast.net>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le 16.12.2006 20:55, A. Kalten a écrit :
> Hello,
> 
> DVD-RAM disks previously made with a Linux system can
> no longer be mounted in RW mode.  For some reason, as
> indicated by the error message from the mount command,
> the disks are detected as being write-protected (which
> is not the case).  To be able to write to these disks,
> the mount command must be issued again with the "-o remount"
> option.
> 
> The commands given are as follows.  Although the file
> type in this example is ext2, the same behavior is seen
> also with the udf file type.
> 
> # modprobe ide-cd
> # hdparm -d1 -X udma4 -k1 /dev/hde
> 
> # mount -t ext2 -o rw,noatime /dev/hde /cdrom
> mount: block device /dev/hde is write-protected, mounting read-only
> 
> # mount -t ext2 -o remount,rw,noatime /dev/hde /cdrom
> 
> Now the DVD-RAM disk can be written normally, but there should
> be no need for the second mount command.
> 
> The kernel log for this command sequence seems to show nothing abnormal:
> 
> kernel: hde: ATAPI 39X DVD-ROM DVD-R-RAM CD-R/RW drive, 2048kB Cache, UDMA(66)
> kernel: Uniform CD-ROM driver Revision: 3.20
> kernel: hde: CHECK for good STATUS
> kernel: cdrom: hde: mrw address space DMA selected
> kernel: cdrom open: mrw_status 'not mrw'
> 
> Furthermore, if I attempt to check the unmounted DVD-RAM disk with
> e2fsck, the drive is still reported as read-only:
> 
> # e2fsck -p /dev/hde
> e2fsck: Read-only file system while trying to open /dev/hde
> Disk write-protected; use the -n option to do a read-only
> check of the device.
> 
> However, as I indicated above, the disk is not write-protected.
> 
> I am reporting this problem on the lkml because of a hint
> that I discovered at this link:
> 
> http://lists.opensuse.org/packet-writing/2006-10/msg00000.html
> 
> Although this problem does not involve packet-writing, it may
> be related to the cdrom code.

The problem I reported in the above link was related to UDF filesystem.

AFAIR, my DVD-RW have been formatted with "mkduffs --media-type=dvd",
which toggled a read-only flag at the FS level. I reformatted this DVD-RW 
with "mkudffs --media-type=dvdram" and the problem was gone.

I'm afraid this won't help you...
~~
laurent
