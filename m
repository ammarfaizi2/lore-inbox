Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131419AbRCUJ4D>; Wed, 21 Mar 2001 04:56:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131413AbRCUJzp>; Wed, 21 Mar 2001 04:55:45 -0500
Received: from smtp010.mail.yahoo.com ([216.136.173.30]:8456 "HELO
	smtp010.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S131410AbRCUJz1>; Wed, 21 Mar 2001 04:55:27 -0500
X-Apparently-From: <quintaq@yahoo.co.uk>
Date: Wed, 21 Mar 2001 09:56:56 +0000
From: quintaq@yahoo.co.uk
To: <linux-kernel@vger.kernel.org>
Subject: Re: UDMA 100 / PIIX4 question
In-Reply-To: <Pine.LNX.4.10.10103201628390.8689-100000@coffee.psychology.mcmaster.ca>
In-Reply-To: <20010320202020Z130768-406+2207@vger.kernel.org>
	<Pine.LNX.4.10.10103201628390.8689-100000@coffee.psychology.mcmaster.ca>
Reply-To: <linux-kernel@vger.kernel.org>
X-Mailer: Sylpheed version 0.4.62 (GTK+ 1.2.8; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20010321095533Z131410-407+1932@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Mar 2001 16:32:48 -0500 (EST)
Mark Hahn <hahn@coffee.psychology.mcmaster.ca> wrote:

> 
> .... hdparm -t cannot be effected by the filesystem
> that lives in the partition, since hdparm is doing reads that don't
> go through the filesystem.  hmm, I wonder if that's it: if you mount
> the FS that's in hda1, it might change the block driver configuration
> (changing the blocksize, for instance).  that would effect hdparm,
> even though its reads don't go through the FS.
> 
> prediction: if you comment out the hda1 line in fstab, and reboot,
> so that vfat never gets mounted on that partition, I predict that 
> hdparm will show >30.19 MB/s on it.
> 

Hi Mark,

I commented out the line.  Mtab now reported:

/dev/hda7 / ext2 rw 0 0
proc /proc proc rw 0 0
/dev/hda5 /boot ext2 rw 0 0
devpts /dev/pts devpts rw 0 0

The result of hdparm -tT /dev/hda was, however, exactly the same as before (ie circa 15 MB/sec.  The results for /dev/hda7 remain at about 30 MB/sec.

Further, even though the relevant line was commented out of fstab, I could still perform hdparm -tT /dev/hda1 (giving the usual 15 MB/sec).  I suppose that this is because fdisk still showed :

Disk /dev/hda: 255 heads, 63 sectors, 3737 cylinders
Units = cylinders of 16065 * 512 bytes

   Device Boot    Start       End    Blocks   Id  System
/dev/hda1   *         1       932   7486258+   b  Win95 FAT32
/dev/hda2           933      3737  22531162+   5  Extended
/dev/hda5           933       935     24066   83  Linux
/dev/hda6           936       952    136521   82  Linux swap
/dev/hda7           953      3737  22370481   83  Linux

On the other hand, am I correct in interpreting the bonnie output for the block read (included in my earlier post), of 20937 KB/sec as reasonably healthy for my DTLA (ie consistent with hdparm's 30 MB/sec), when performing more realistic tasks on the linux filesystem ?

Regards,

Geoff

_________________________________________________________
Do You Yahoo!?
Get your free @yahoo.com address at http://mail.yahoo.com

