Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268039AbTB1Rxf>; Fri, 28 Feb 2003 12:53:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268042AbTB1Rxe>; Fri, 28 Feb 2003 12:53:34 -0500
Received: from [216.234.192.169] ([216.234.192.169]:32261 "HELO
	miranda.zianet.com") by vger.kernel.org with SMTP
	id <S268039AbTB1Rxc>; Fri, 28 Feb 2003 12:53:32 -0500
Message-ID: <3E5FA488.2080208@zianet.com>
Date: Fri, 28 Feb 2003 11:03:52 -0700
From: kwijibo@zianet.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3b) Gecko/20030210
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Robert L. Harris" <Robert.L.Harris@rdlg.net>
CC: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Slowing down disk access?
References: <20030228143528.GA2432@rdlg.net>
In-Reply-To: <20030228143528.GA2432@rdlg.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have nearly an identical system as yours. Dual 1.6 Athlons,
two 3ware 7850's, 8 disks on each but with 160 gig drives.
I have kernel 2.4.19 on it with ext3.  My RAID is arranged
slightly different however.  I have each controller do a RAID 5
and then I software mirror the two.  This box gets hammered
pretty hard at times over NFS and other services but I have
never seen this type of behaviour come out of it.  Are you
sure one of your drives isn't going bad, it looks the error
is always coming from unit #7.  Do all of them do this?

Steve

Robert L. Harris wrote:

>  I've got a system I need to slow down disk access on it would seem.  The
>syerver, a dual 1.5Ghz Athalon has two 3ware IDE controllers, 8 disks
>each for a total of sixteen 180 Gig disks.  This system is laid out in
>four RAID5 arrays that it shares out via NFS.  kernel 2.4.19-ac4, ext3
>file systems.  I've got 7 of these.
>
>  This works great and provides a LOT of cheap disk that we use for
>staging backups before cloning off to tape.
>
>  The problem is that when the array's get pounded HARD, such as when
>legato is cleaning it's file devices (nsrstage -C) the machine will lock
>up and spew errors to my console:
>
>3w-xxxx: scsi1: Command failed: status = 0xc7, flags = 0x1b, unit #7.
>3w-xxxx: scsi1: Command failed: status = 0xc7, flags = 0x1b, unit #7.
>3w-xxxx: scsi1: Command failed: status = 0xc7, flags = 0x1b, unit #7.
>3w-xxxx: scsi1: Command failed: status = 0xc7, flags = 0x1b, unit #7.
>3w-xxxx: scsi1: Command failed: status = 0xc7, flags = 0x1b, unit #7.
>3w-xxxx: scsi1: Command failed: status = 0xc7, flags = 0x1b, unit #7.
>3w-xxxx: scsi1: Command failed: status = 0xc7, flags = 0x1b, unit #7.
>3w-xxxx: scsi1: Command failed: status = 0xc7, flags = 0x1b, unit #7.
>3w-xxxx: scsi1: Command failed: status = 0xc7, flags = 0x1b, unit #7.
>3w-xxxx: scsi1: AEN: WARNING: ATA port timeout: Port #7.             
>3w-xxxx: scsi1: AEN: WARNING: ATA port timeout: Port #7.
>3w-xxxx: scsi1: AEN: WARNING: ATA port timeout: Port #7.
>3w-xxxx: scsi1: AEN: WARNING: ATA port timeout: Port #7.
>3w-xxxx: scsi1: AEN: WARNING: ATA port timeout: Port #7.
>3w-xxxx: scsi1: AEN: WARNING: ATA port timeout: Port #7.
>3w-xxxx: scsi1: AEN: WARNING: ATA port timeout: Port #7.
>3w-xxxx: scsi1: AEN: WARNING: ATA port timeout: Port #7.
>
>  This requires a hard reboot.  If I use the magic keys and reset it then
>it goes down but doesn't come back up properly, usually dieing around
>the LILO area, I believe the array or disks are left in an odd state.
>
>  Is there a way to actually slow down the disk access/read/write other
>than re-making the filesystems?  On the other systems the chunk size is
>at either 32K or 128K.  On this one in particular the chunk size is
>1024K which was determined by running a number of tests (bonnie, nfs
>reads/writes) and was found to be about the fastest for our money's
>worth.  The disk hangups didn't appear until just recently.  If there's
>no other choise I can leave the disks as read only until the data rolls
>off then remake them in 32 or 64K.
>
>Any other thoughts?
>  Robert
>
>  
>
>:wq!
>---------------------------------------------------------------------------
>Robert L. Harris                     | PGP Key ID: E344DA3B
>                                         @ x-hkp://pgp.mit.edu 
>DISCLAIMER:
>      These are MY OPINIONS ALONE.  I speak for no-one else.
>
>Diagnosis: witzelsucht  	
>
>IPv6 = robert@ipv6.rdlg.net	http://ipv6.rdlg.net
>IPv4 = robert@mail.rdlg.net	http://www.rdlg.net
>  
>


