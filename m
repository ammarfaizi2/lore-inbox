Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318703AbSG0Fyw>; Sat, 27 Jul 2002 01:54:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318702AbSG0Fyw>; Sat, 27 Jul 2002 01:54:52 -0400
Received: from adsl-66-136-196-103.dsl.austtx.swbell.net ([66.136.196.103]:19328
	"HELO digitalroadkill.net") by vger.kernel.org with SMTP
	id <S318703AbSG0Fyt>; Sat, 27 Jul 2002 01:54:49 -0400
Subject: RE: 2.5.28 and partitions
From: Austin Gonyou <austin@digitalroadkill.net>
To: Alexander Viro <viro@math.psu.edu>
Cc: Anton Altaparmakov <aia21@cantab.net>,
       Linus Torvalds <torvalds@transmeta.com>, Matt_Domsch@Dell.com,
       Andries.Brouwer@cwi.nl, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.GSO.4.21.0207251245530.17621-100000@weyl.math.psu.edu>
References: <Pine.GSO.4.21.0207251245530.17621-100000@weyl.math.psu.edu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1027749383.2590.22.camel@UberGeek.digitalroadkill.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.1.0.99 (Preview Release)
Date: 27 Jul 2002 00:56:24 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-07-25 at 11:50, Alexander Viro wrote:
> On Thu, 25 Jul 2002, Anton Altaparmakov wrote:
> 
> > At 12:44 25/07/02, Alexander Viro wrote:
> > >Al, still thinking that anybody who does mkfs.<whatever> on a multi-Tb
> > >device should seek professional help of the kind they don't give on l-k...
> > 
> > Why? What is wrong with large devices/file systems? Why do we have to break 
> > up everything into multiple devices? Just because the kernel is "too lazy" 
> > to implement support for large devices? Nobody cares if 64bit code is 
> 
> Large filesystem => troubles with backups, even more troubles with restoring
> after disk failure, yadda, yadda.

Right, but that doesn't stop people anyway. Whether you have one or a
hundred file systems, you still back it up and restore it, and the
bottleneck is still, usually, the TBU bus(i.e. tbu speed + SCSI||FC
speed + network speed + disk speed == latency of some kinds for
restores)

> > database server and we can live with that. At least our applications deal 
> > with GiBs of data for each experiment, which is shifted over Gigabit 
> > ethernet to/from a SQL database backend stored on a huge RAID array, so we 
> > are completely i/o bound.
> > 
> > It's one database, and it's huge. And it's going to get bigger as people do 
> > more experiments. We need mkfs.<whatever> on a huge device... We are just 
> > lucky that our current RAID array is under 2TiB se we haven't hit the 
> > "magic" barrier quite yet. But at 1.4TiB we are not far off...
> 
> ... and backups of your database are done on...?

Tape usually, which in itself is a problem. But, more and more people
are implementing "third mirrors" of types, whether they are snapshot
types or full copies of the data, people are using FC or fast shared
SCSI subsystems, or Gigabit NFS to a NAS filer or to a centralized
system with one large file-systems with many directories for backups. 

My shop has several TB+ DBs...and no we don't have TB sized filesystems,
yet, but it will happen, our largest single FS is 400GB+, and will only
get bigger in the future. I'm intimately aware though, that regardless
of having FS under 2TBs, we still backup to tape, but we do it with a
copy of the data by making a mirror of our already mirrored FS's. 

We then mount those FS on a host capable of mounting them, and then
backup from that storage, to the TBU directly attached to it. 

Bottleneck on all of this is in fact the TBU and associated bus. 

> "RAID" doesn't mean that data is safe.  It means that some class of
> failures will not be immediately catastrophic, but that's it - both
> hardware and software arrays _do_ go tits up.  Just ask hpa for story
> of the troubles on kernel.org.

Sure RAID doesn't mean it's "totally safe", but it does mean it's
"safer" than it would have been otherwise. What this is often referred
to as crisis management. The idea is that you do *not* run in a degraded
mode for very long, and take care of the problematic hardware/software
ASAP, but to *not* lose your data. 

I say this regardless of the fact that it *can and does* happen
occasionally, because there are plenty of corner cases where RAID and
data protection are concerned. 

Support for *large filesystems* TB size + is imperative in the future.
Things will only get bigger and bigger as far as they are able, and with
people like Hitatchi and Sony coming out with optical disks the size of
a 1.44MB floppy holding Terabytes and up, this is just the beginning. 

Mind you the scenario I just described is not nearline or offline
storage, it is fully re-writeable, faster than a typical hdd, optical
media and will be available to consumers, if vapor isn't implied,
withing 12 months. (consumers being corporations first, then general
consumption.)



> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
-- 
Austin Gonyou <austin@digitalroadkill.net>
