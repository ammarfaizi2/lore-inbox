Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130214AbQL0SIa>; Wed, 27 Dec 2000 13:08:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130485AbQL0SIV>; Wed, 27 Dec 2000 13:08:21 -0500
Received: from unthought.net ([212.97.129.24]:15509 "HELO mail.unthought.net")
	by vger.kernel.org with SMTP id <S130214AbQL0SIQ>;
	Wed, 27 Dec 2000 13:08:16 -0500
Date: Wed, 27 Dec 2000 18:37:48 +0100
From: Jakob Østergaard <jakob@unthought.net>
To: Paul Jakma <paulj@itg.ie>
Cc: Ian Stirling <root@mauve.demon.co.uk>,
        Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org
Subject: RAID - IDE - here we go again...
Message-ID: <20001227183748.A9491@unthought.net>
Mail-Followup-To: Jakob Østergaard <jakob@unthought.net>,
	Paul Jakma <paulj@itg.ie>, Ian Stirling <root@mauve.demon.co.uk>,
	Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org
In-Reply-To: <200012261952.TAA11390@mauve.demon.co.uk> <Pine.LNX.4.30.0012271620530.24075-100000@rossi.itg.ie>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2i
In-Reply-To: <Pine.LNX.4.30.0012271620530.24075-100000@rossi.itg.ie>; from paulj@itg.ie on Wed, Dec 27, 2000 at 04:23:43PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 27, 2000 at 04:23:43PM +0000, Paul Jakma wrote:
> On Tue, 26 Dec 2000, Ian Stirling wrote:
> 
> > The PCI bus can move around 130MB/sec,
> 
> in bursts yes, but sustained data bandwidth of PCI is a lot lower,
> maybe 30 to 50MB/s. And you won't get sustained RAID performance >
> sustained PCI performance.

Much higher than 30-50 - but yes, the total bandwidth won't exceed
the slowest channel.

> 
> > Anyway, in clarification, Rik mentioned that two reads from different
> > disk (arrays?) on the same controller at the same time get more or less
> > the same speed.
> 
> try scsi.

SCSI won't get you a faster PCI bus.  Guys, *PLEASE*, - everyone on this list
knows what the respective virtues and horrors of SCSI and IDE are.   Configured
properly, both can perform well, configured wrongly, both will suck.

The timings below are from a dual PII-350, Asus P2B-DS, it has a six disk SCSI
RAID and a five disk IDE RAID.  The IDE raid is configured properly with one
channel per disk - which would have solved the performance problem in the array
that spawned this thread. 

(By the way: the SCSI RAID is configured with three controllers for the six
disks, because of the low SCSI bus bandwidth, reality rules in the SCSI world
as well)

Kernel is 2.2, RAID is 0.90, IDE is Andre's

---------------------------------------
Dual PII-350, 256 MB RAM, test on 1 GB file

Filesystem:  75 GB ext2fs
RAID:        Linux Softare RAID-5
Disks:       5 pcs. IBM Deskstar 75 GXP (30GB)
Controller:  3 pcs. Promise PDC-2067

              -------Sequential Output-------- ---Sequential Input-- --Random--
              -Per Char- --Block--- -Rewrite-- -Per Char- --Block--- --Seeks---
Machine    MB K/sec %CPU K/sec %CPU K/sec %CPU K/sec %CPU K/sec %CPU  /sec %CPU
         1024  4998 98.0 28660 45.9 14586 50.4  5386 98.5 71468 79.1 338.6  5.2                               

28 MB/sec write, 71MB/sec read on RAID-5.

---------------------------------------
Same box, test on 1 GB file

Filesystem:  18 GB ext2fs
RAID:        Linux Softare RAID-0

This array is built on other partitions on the same disks as above.

              -------Sequential Output-------- ---Sequential Input-- --Random--
              -Per Char- --Block--- -Rewrite-- -Per Char- --Block--- --Seeks---
Machine    MB K/sec %CPU K/sec %CPU K/sec %CPU K/sec %CPU K/sec %CPU  /sec %CPU
         1024  5381 99.7 44267 50.1 22613 62.1  5469 99.4 98075 91.4 311.0  5.0                               
44 MB/sec write, 98 MB/sec read on RAID-0.  That's thru *one* PCI bus folks.

Please, for further comments or another IDE-hotplug-can!-cannot!-can-so!, let's
take this to linux-raid or #offtopic   ;)

Enough said.

-- 
................................................................
:   jakob@unthought.net   : And I see the elder races,         :
:.........................: putrid forms of man                :
:   Jakob Østergaard      : See him rise and claim the earth,  :
:        OZ9ABN           : his downfall is at hand.           :
:.........................:............{Konkhra}...............:
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
