Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282357AbRKXDgJ>; Fri, 23 Nov 2001 22:36:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282358AbRKXDgA>; Fri, 23 Nov 2001 22:36:00 -0500
Received: from maynard.mail.mindspring.net ([207.69.200.243]:31260 "EHLO
	maynard.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S282357AbRKXDfy>; Fri, 23 Nov 2001 22:35:54 -0500
Message-ID: <3BFF16F0.C331F0E4@mindspring.com>
Date: Fri, 23 Nov 2001 19:41:36 -0800
From: Joe <joeja@mindspring.com>
Reply-To: joeja@mindspring.com
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.14 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Zwane Mwaikambo <zwane@linux.realnet.co.sz>, linux-kernel@vger.kernel.org
Subject: 2.4.14/2.4.15 cpia driver IS broke.. no its parport && other problems 
 with 2.4.15 
In-Reply-To: <Pine.LNX.4.33.0111230950580.24427-100000@netfinity.realnet.co.sz>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have been doing some testing and debugging and found out that something in
the 2.4.14 parport driver is breaking my webcam II.  I have a patch that
reverts out all the changes in 2.4.14 parport driver back to 2.4.13 and the
driver now works.  I am going to do some more testing and see if I can narrow
the code down.  Right now the patch is  about 700+ lines, but reverts out
ALL the parport changes.

My hardward is a VIA chipset (686). It is the ABiT KT7A MB.

What's happening is that the cpia is being recgonized, but the video device
is not accessable. This is in both 2.4.15 and 2.4.14, with the creative
WebCam II.

In the /proc/cpia/video0 file it shows the CPIA version as 0.00 instead of
1.20.

On another note it seems that with 2.4.15 umount is not working on my
machine.  It mounts the drives okay, but requires umount -n to be used which
seems to be forcing the unmount of the drive.  I am using mount 2.11g do
I need to upgrade this? I'm NOT using ext3 fs, just ext2.  Do I need to
upgrade something??

Oh and because umount fails all my services leave files in /var/lock and
/tmp.X11** and when the system restarts many of these services are to dumb to
realize that the PID for these processes is not running and don't start
(xdm/gdm).   The other thing that happens is that when I restart the machine
it comes up and runs fsck on most of the drives and then it has other
problems.

The only workaournd seems to be to bring the machine to runlevel 1 (init
1) from runlevel 5 or 3 before I shutdown.    This kills ALL the services.
Then I can umount -n the drives, run e2fsck (if need), remount them and
remove the lock files and tmp files (if they are there still). remount the
drives and then halt the machine.  It shouldnt be that hard though.

Joe

