Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282845AbSAZNLP>; Sat, 26 Jan 2002 08:11:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284300AbSAZNLG>; Sat, 26 Jan 2002 08:11:06 -0500
Received: from moutvdom01.kundenserver.de ([195.20.224.200]:11529 "EHLO
	moutvdom01.kundenserver.de") by vger.kernel.org with ESMTP
	id <S282845AbSAZNKx>; Sat, 26 Jan 2002 08:10:53 -0500
Content-Type: text/plain; charset=US-ASCII
From: Hans-Peter Jansen <hpj@urpla.net>
Organization: LISA GmbH
To: Nicholas Lee <nj.lee@plumtree.co.nz>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.18-pre3-ac2 still having problems (was Disk corruption - Abit KT7, 2.2.19+ide patches)
Date: Sat, 26 Jan 2002 14:10:37 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Jani Forssell <jani.forssell@viasys.com>,
        Ville Herva <vherva@niksula.hut.fi>
In-Reply-To: <20020115202302.GA598@inktiger.kiwa.co.nz> <20020124224017.GF555@inktiger.kiwa.co.nz>
In-Reply-To: <20020124224017.GF555@inktiger.kiwa.co.nz>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020126131037.AA8BE13E3@shrek.lisa.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, 24. January 2002 23:40, Nicholas Lee wrote:
> Just a follow up on the previous report.
>
> Replace the kernel with 2.4.18-pre3-ac2 which includes the recent ATA
> driver from Andre Hedric.  NIC was moved from slot 3.
>
>
> nic@hoppa:~$ cat /proc/ide/drivers
> ide-cdrom version 4.59
> ide-disk version 1.12
>
>
> Everything seemed to be running smoothly.
>
> I performed the stress test mentioned here:
> http://marc.theaimsgroup.com/?l=linux-kernel&m=101059003125783&w
> with the added complication of ping flooding and being ping flooded.
>
>
> nic@hoppa:~$ sudo cat /dev/hda > /dev/null & sudo ping -f -s 64000 inktiger
> [1] 445
> PING inktiger.kpac.co.nz (192.168.9.108): 64000 data bytes
> ...........................................................................
>............................................................................
>............................................................................
>............................................................................
>............................................................................
>.......... --- inktiger.kpac.co.nz ping statistics ---
> 406 packets transmitted, 16 packets received, 96% packet loss
> round-trip min/avg/max = 258.3/695.8/1783.5 ms
> nic@hoppa:~$ uname -a
> Linux hoppa 2.4.18-pre3-ac2 #3 Wed Jan 23 10:48:41 NZDT 2002 i686 unknown
>
>
>
> I was going to say "Stable as a rock again", but I thought to soon.
>
> Five mintues later, down it goes:
>
> hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
> hda: dma_intr: error=0x40 { UncorrectableError }, LBAsect=28086092,
> sector=2960368 end_request: I/O error, dev 03:07 (hda), sector 2960368
> hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
> hda: dma_intr: error=0x40 { UncorrectableError }, LBAsect=28086108,
> sector=2960376 end_request: I/O error, dev 03:07 (hda), sector 2960376
> hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
> hda: dma_intr: error=0x40 { UncorrectableError }, LBAsect=28086108,
> sector=2960384 end_request: I/O error, dev 03:07 (hda), sector 2960384
>
> Start filling up the console.
>
> Lucky I've got ext3 I think. Nope, as soon as the reboot gets to that
> partition the above messages start filling up the console again.
>
> fsck -c /dev/hda7 only makes things worse. Looks like I'll just have to
> deep six that whole part of the drive.
>
> Power reset - to reset the HD IDE bus - doesn't seem to help matters
> either. Looks like the low-level format part of the drive might be
> corrupted.
>
>
> Note: /dev/hda7 is the /var mount point. I've noted before that often
> problems with the drive and related to CUPS spool events. Network and
> disk IO at the same time.
>
>
> Looks like that part of the drive is completely toasted. I wonder where
> I sould send the bill too. I'm definitely thinking that I should not
> even consider AMD/VIA solutions near core servers.
>
>
> Default settings on boot:
> [nic@inktiger:~] cat hdparm.log
>
> /dev/hda:
>  multcount    = 16 (on)
>  I/O support  =  1 (32-bit)
>  unmaskirq    =  1 (on)
>  using_dma    =  1 (on)
>  keepsettings =  0 (off)
>  nowerr       =  0 (off)
>  readonly     =  0 (off)
>  readahead    =  8 (on)
>  geometry     = 3737/255/63, sectors = 60046560, start = 0
>  busstate     =  1 (on)

While you not mentioning your drive manufacturer, I bet for
IBM (you know, what this acronym stands for: idiots build...)
Actually not all of them, but definitely those, who try to engender
ide harddisks. 

If my bet is right, search for discussions on ibm hd corruption here.

Basically, if you powercycle your system during a write operation,
affected blocks will return hard read errors on future access.

The likelyhood for affecting /var is high. Here it happened
during a procmail delivery of lkml messages.

Try to return those drives to your dealer.

Hans-Peter
