Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315575AbSESXxS>; Sun, 19 May 2002 19:53:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315599AbSESXxR>; Sun, 19 May 2002 19:53:17 -0400
Received: from louise.pinerecords.com ([212.71.160.16]:54802 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S315575AbSESXxQ>; Sun, 19 May 2002 19:53:16 -0400
Date: Mon, 20 May 2002 01:53:14 +0200
From: Tomas Szepe <szepe@pinerecords.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4/2.5 SCSI considerably slower than FreeBSD
Message-ID: <20020519235314.GC26417@louise.pinerecords.com>
In-Reply-To: <3CE5D4FC.DB2CC47E@torque.net> <20020519205015.GC3008@merlin.emma.line.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.99i
X-OS: Linux/sparc 2.2.21-rc4-ext3-0.0.7a SMP (up 3 days, 17:15)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > $ time sg_dd if=/dev/sg1 of=/dev/null bs=512 count=2m time=1
> > time to transfer data was 18.786448 secs, 57.16 MB/sec
> > 2097152+0 records in
> > 2097152+0 records out
> > real 0m18.799s  user 0m0.030s  sys 0m3.010s
> 
> In a live system (actually, it's idle, but every 5 s, there is a short
> burst of disk activity -- reiserfs and ext3fs in use here, something is
> going on there), sg_dd is not really better than plain dd:
> 
> > time sg_dd if=/dev/sg0 of=/dev/null count=1310720
> > Assume default 'bs' (block size) of 512 bytes
> > 1310720+0 records in
> > 1310720+0 records out
> >
> > real    0m24.348s
> 
> gives: 27,56 MB/s. A little better than dd, but still much less than FreeBSD's.

hmmm.

# sync; sync; time dd if=/dev/sda of=/dev/null bs=64k count=10000
10000+0 records in
10000+0 records out

real    0m12.809s
user    0m0.020s
sys     0m2.560s

(first read, the data shouldn't have been cached)
-> 48.79 MB/s

I wouldn't suspect there's a problem, the numbers look reasonable.

$ uname -r
2.4.19-pre2

Disk:
Host: scsi0 Channel: 00 Id: 02 Lun: 00
  Vendor: SEAGATE  Model: ST336706LW       Rev: 0109
  Type:   Direct-Access                    ANSI SCSI revision: 03
(i.e., 36GiB 160MB/s Seagate Cheetah)

Controller - HP netserver onboard sym53c896.


T.
