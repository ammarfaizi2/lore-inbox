Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319276AbSHVAxi>; Wed, 21 Aug 2002 20:53:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319277AbSHVAxi>; Wed, 21 Aug 2002 20:53:38 -0400
Received: from 205-158-62-94.outblaze.com ([205.158.62.94]:64439 "HELO
	ws3-4.us4.outblaze.com") by vger.kernel.org with SMTP
	id <S319276AbSHVAxi>; Wed, 21 Aug 2002 20:53:38 -0400
Message-ID: <20020822005730.9319.qmail@email.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "James Hayhurst" <herrdoktor@email.com>
To: linux-kernel@vger.kernel.org
Date: Wed, 21 Aug 2002 19:57:30 -0500
Subject: Cannot unmount initrd
X-Originating-Ip: 198.4.83.52
X-Originating-Server: ws3-4.us4.outblaze.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm making a boot CD and having problems unmounting and freeing the initrd after pivoting to a different root.  First off, for some reaosn it seems that /linuxrc is not being executed.  Just to test this, I have it as a simple script (with execute permissions) printing something to the screen and it never printed....at boot it just seems to go to /sbin/init on the initrd image.  After pivoting to a cramfs root, I cannot unmount /initrd as it says that the device or resource is busy.  Checking out /proc, it looks like [keventd], [ksoftirqd_CPU0], [kswapd] and [kupdated] are holding onto open fd from /initrd, namely /initrd/dev/console.  Strangely though, some of the fd's they're holding are the  "normal" /dev/console.

My /sbin/init on the initrd script looks something like:

#I have the new root mount on /new_root/root.cfs and all directories are set up to pivot
cd /new_root
pivot_root . initrd
export PATH=/bin:/usr/bin:/sbin
echo Done pivoting

umount /initrd/proc
umount /initrd/devfs
umount /initrd

exec chroot . sbin/startup < dev/console > dev/console 2> dev/console

Should i unmount /proc and /devfs before I pivot?  Any suggestions would be wonderful!

Cheers,
James

Please CC to me directly if you can, i'm not suscribed to the mailing list, bad me!
-- 
__________________________________________________________
Sign-up for your own FREE Personalized E-mail at Mail.com
http://www.mail.com/?sr=signup

