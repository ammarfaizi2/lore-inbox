Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750724AbWDTBy3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750724AbWDTBy3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 21:54:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750726AbWDTBy3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 21:54:29 -0400
Received: from 220-130-178-142.HINET-IP.hinet.net ([220.130.178.142]:61357
	"EHLO areca.com.tw") by vger.kernel.org with ESMTP id S1750724AbWDTBy2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 21:54:28 -0400
Message-ID: <001401c6641d$586bd950$b100a8c0@erich2003>
From: "erich" <erich@areca.com.tw>
To: "Jens Axboe" <axboe@suse.de>
Cc: <dax@gurulabs.com>, <billion.wu@areca.com.tw>,
       "Al Viro" <viro@ftp.linux.org.uk>, "Andrew Morton" <akpm@osdl.org>,
       "Randy.Dunlap" <rdunlap@xenotime.net>,
       "Matti Aarnio" <matti.aarnio@zmailer.org>,
       <linux-kernel@vger.kernel.org>,
       "James Bottomley" <James.Bottomley@steeleye.com>,
       "Chris Caputo" <ccaputo@alt.net>
References: <Pine.LNX.4.64.0603212310070.20655@nacho.alt.net> <007701c653d7$8b8ee670$b100a8c0@erich2003> <Pine.LNX.4.64.0603301542590.19680@nacho.alt.net> <004a01c65470$412daaa0$b100a8c0@erich2003> <20060330192057.4bd8c568.akpm@osdl.org> <20060331074237.GH14022@suse.de> <002901c65e33$ceac9e00$b100a8c0@erich2003> <20060419104009.GB614@suse.de> <003301c663b3$6bfcc020$b100a8c0@erich2003> <20060419131916.GH614@suse.de>
Subject: Re: new Areca driver in 2.6.16-rc6-mm2 appears to be broken
Date: Thu, 20 Apr 2006 09:54:20 +0800
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0011_01C66460.65143920"
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.3790.2663
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3790.2663
X-OriginalArrivalTime: 20 Apr 2006 01:49:11.0546 (UTC) FILETIME=[9EF695A0:01C6641C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_0011_01C66460.65143920
Content-Type: text/plain;
	format=flowed;
	charset="utf-8";
	reply-type=original
Content-Transfer-Encoding: 7bit

Dear Jens Axboe,

I  do "fsck -fy /dev/sda1" on driver MAX_XFER_SECTORS 512.
The file system was not clean.
I attach mesg.txt for you refer to.

=====================================
== boot with driver MAX_XFER_SECTORS 4096
=====================================
#mkfs.ext2 /dev/sda1
#reboot
=====================================
== boot with driver MAX_XFER_SECTORS 512
=====================================
#fsck -fy /dev/sda1
/dev/sda1:clean,.............
#reboot
=====================================
== boot with driver MAX_XFER_SECTORS 4096
=====================================
#mount /dev/sda1 /mnt/sda1
#cp /root/aa /mnt/sda1
#reboot
=====================================
== boot with driver MAX_XFER_SECTORS 512
=====================================
#fsck -fy /dev/sda1
/dev/sda1: no clean,........and dump message such as the attach file 
mesg.txt.

Best Regards
Erich Chen
----- Original Message ----- 
From: "Jens Axboe" <axboe@suse.de>
To: "erich" <erich@areca.com.tw>
Cc: <dax@gurulabs.com>; <billion.wu@areca.com.tw>; "Al Viro" 
<viro@ftp.linux.org.uk>; "Andrew Morton" <akpm@osdl.org>; "Randy.Dunlap" 
<rdunlap@xenotime.net>; "Matti Aarnio" <matti.aarnio@zmailer.org>; 
<linux-kernel@vger.kernel.org>; "James Bottomley" 
<James.Bottomley@steeleye.com>; "Chris Caputo" <ccaputo@alt.net>
Sent: Wednesday, April 19, 2006 9:19 PM
Subject: Re: new Areca driver in 2.6.16-rc6-mm2 appears to be broken


> On Wed, Apr 19 2006, erich wrote:
>> Dear Jens Axboe,
>>
>> About your request :
>>
>> ******************************************
>> ** boot with driver MAX_XFER_SECTORS 4096
>> ******************************************
>> #mkfs.ext2 /dev/sda1
>> #mount /dev/sda1 /mnt/sda1
>> #cp /root/aa /mnt/sda1/
>> #reboot
>> ******************************************
>> ** boot with driver MAX_XFER_SECTORS 512
>> ******************************************
>> #fsck /dev/sda1
>> /dev/sda1:clean,.............
>
> fsck -fy /dev/sda1
>
> You need to force a full check, the partition should be clean when you
> do this so fsck wont do anything.
>
>
> -- 
> Jens Axboe
> 

------=_NextPart_000_0011_01C66460.65143920
Content-Type: text/plain;
	format=flowed;
	name="mesg.txt";
	reply-type=original
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="mesg.txt"

fsck 1.38 (30-Jun-2005)=0A=
e2fsck 1.38 (30-Jun-2005)=0A=
Pass 1: Checking inodes, blocks, and sizes=0A=
Inode 12 has illegal block(s).  Clear? yes=0A=
=0A=
Illegal block #2060 (4294967295) in inode 12.  CLEARED.=0A=
Illegal block #2062 (4294967295) in inode 12.  CLEARED.=0A=
Illegal block #2064 (4294967295) in inode 12.  CLEARED.=0A=
Illegal block #2066 (4294967295) in inode 12.  CLEARED.=0A=
Illegal block #2068 (4294967295) in inode 12.  CLEARED.=0A=
Illegal block #2070 (4294967295) in inode 12.  CLEARED.=0A=
Illegal block #2072 (4294967295) in inode 12.  CLEARED.=0A=
Illegal block #2074 (4294967295) in inode 12.  CLEARED.=0A=
Illegal block #2076 (4294967295) in inode 12.  CLEARED.=0A=
Illegal block #2078 (4294967295) in inode 12.  CLEARED.=0A=
Illegal block #2080 (4294967295) in inode 12.  CLEARED.=0A=
Too many illegal blocks in inode 12.=0A=
Clear inode? yes=0A=
=0A=
Restarting e2fsck from the beginning...=0A=
Pass 1: Checking inodes, blocks, and sizes=0A=
Pass 2: Checking directory structure=0A=
Entry 'aa' in / (2) has deleted/unused inode 12.  Clear? yes=0A=
=0A=
Pass 3: Checking directory connectivity=0A=
Pass 4: Checking reference counts=0A=
Pass 5: Checking group summary information=0A=
Block bitmap differences:  -(14336--32767) -(33288--65535) =
-(66050--98303) -(98824--131071) -(131586--163839) -(164360--196607) =
-(197=0A=
122--229375) -(229896--248594)=0A=
Fix? yes=0A=
=0A=
Free blocks count wrong for group #0 (13811, counted=3D32243).=0A=
Fix? yes=0A=
=0A=
Free blocks count wrong for group #1 (0, counted=3D32248).=0A=
Fix? yes=0A=
=0A=
Free blocks count wrong for group #2 (0, counted=3D32254).=0A=
Fix? yes=0A=
=0A=
Free blocks count wrong for group #3 (0, counted=3D32248).=0A=
Fix? yes=0A=
=0A=
Free blocks count wrong for group #4 (0, counted=3D32254).=0A=
Fix? yes=0A=
=0A=
Free blocks count wrong for group #5 (0, counted=3D32248).=0A=
Fix? yes=0A=
=0A=
Free blocks count wrong for group #6 (0, counted=3D32254).=0A=
Fix? yes=0A=
=0A=
Free blocks count wrong for group #7 (13549, counted=3D32248).=0A=
Fix? yes=0A=
=0A=
Free blocks count wrong (18993611, counted=3D19224248).=0A=
Fix? yes=0A=
=0A=
Inode bitmap differences:  -12=0A=
Fix? yes=0A=
=0A=
Free inodes count wrong for group #0 (16372, counted=3D16373).=0A=
Fix? yes=0A=
=0A=
Free inodes count wrong (9781236, counted=3D9781237).=0A=
Fix? yes=0A=
=0A=
=0A=
/dev/sda1: ***** FILE SYSTEM WAS MODIFIED *****=0A=
/dev/sda1: 11/9781248 files (0.0% non-contiguous), 306941/19531189 blocks=0A=
linux:~ #=0A=

------=_NextPart_000_0011_01C66460.65143920--

