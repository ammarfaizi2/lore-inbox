Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293357AbSCFIdJ>; Wed, 6 Mar 2002 03:33:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293352AbSCFIdA>; Wed, 6 Mar 2002 03:33:00 -0500
Received: from ssemail007.crayfish.net ([202.83.148.3]:63955 "EHLO
	ssemail007.crayfish.net") by vger.kernel.org with ESMTP
	id <S293348AbSCFIcv>; Wed, 6 Mar 2002 03:32:51 -0500
Date: Wed, 06 Mar 2002 17:33:45 +0900
From: Michael Cheung <vividy@justware.co.jp>
To: Andreas Dilger <adilger@clusterfs.com>
Subject: Re[2]: mount -o remount,ro cause error "device is busy"
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020306011519.C963@lynx.adilger.int>
In-Reply-To: <20020306074908.GA342@matchmail.com> <20020306011519.C963@lynx.adilger.int>
Message-Id: <20020306172418.C8A3.VIVIDY@justware.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.00.08
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

maybe i am wrong, but I really can't find any other process runing.

my step is:
1) "/" and "/usr" are busy
2) shut down to single user mode
3) "/" still busy
4) "/usr" can be unmounted, but can't mount -o ro,remount /usr, show busy error.
5) umount -a, after this, only /proc and / exist.
6) mount -o ro,remount /, show busy error.

I have mentioned I have used "ps aux" to check the process list,
there are no user process left. except the following: (repost)
root         1  0.1  0.7  1056  484 ?        S    15:46   0:04 init [S] 
root         2  0.0  0.0     0    0 ?        SW   15:46   0:00 [keventd]
root         3  0.0  0.0     0    0 ?        SWN  15:46   0:00 [ksoftirqd_CPU0]
root         4  0.0  0.0     0    0 ?        SW   15:46   0:00 [kswapd]
root         5  0.0  0.0     0    0 ?        SW   15:46   0:00 [bdflush]
root         6  0.0  0.0     0    0 ?        SW   15:46   0:00 [kupdated]
root      1042  0.0  0.7  1056  484 tty1     S    16:33   0:00 init [S] 
root      1043  0.6  1.5  1840 1004 tty1     S    16:33   0:00 /bin/sh
root      1045  0.0  1.0  2260  680 tty1     R    16:33   0:00 ps aux

and I also checked by fuser -v /usr,
only used by kernel.
and fuser -c /, show many process list above.

If i have a mistake, would you like to tell me where is the mistake?

thanks.

Regards;
Michael


On Wed, 6 Mar 2002 01:15:19 -0700
Andreas Dilger <adilger@clusterfs.com> wrote:

> On Mar 05, 2002  23:49 -0800, Mike Fedyk wrote:
> > On Wed, Mar 06, 2002 at 04:40:10PM +0900, Michael Cheung wrote:
> > > 	I have upgraded my kernel to version 2.4.
> > > And i have tested 2.4.16 and 2.4.18. Both of these
> > > two version have the same problem when system reboot.
> > > "/: device is busy";
> > > in shutdown script:
> > > umount -a
> > > mount -n -o ro,remount /
> > > these two line result error: device is busy.
> > > 
> > 
> > We need more info about your config.  Do you have any patches in this
> > kernel?  What modules have been loaded?  Highmem?  x86?  drive controller?
> > drive? ram size? lspci output, etc...
> 
> Please don't send that.  It clearly appears to be a user problem.
> Order of operations, as I read in the original email:
> 1) "/" and "/usr" are busy
> 2) shut down to single user mode
> 3) "/" still busy
> 4) "/usr" can be unmounted
> 5) didn't check that root can be remounted after umounting "/usr"
> 
> Clearly, some program is keeping "/usr" busy (which is keeping "/" busy)
> before the change to single user mode.  Just a bit of "lsof" needed to
> find such things.
> 
> Cheers, Andreas
> --
> Andreas Dilger
> http://sourceforge.net/projects/ext2resize/
> http://www-mddsp.enel.ucalgary.ca/People/adilger/
> 
> 


