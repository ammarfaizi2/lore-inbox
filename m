Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265288AbSJRRy3>; Fri, 18 Oct 2002 13:54:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265334AbSJRRy3>; Fri, 18 Oct 2002 13:54:29 -0400
Received: from viefep12-int.chello.at ([213.46.255.25]:37904 "EHLO
	viefep12-int.chello.at") by vger.kernel.org with ESMTP
	id <S265288AbSJRRyQ>; Fri, 18 Oct 2002 13:54:16 -0400
From: Simon Roscic <simon.roscic@chello.at>
To: GrandMasterLee <masterlee@digitalroadkill.net>
Subject: Re: [Kernel 2.5] Qlogic 2x00 driver
Date: Fri, 18 Oct 2002 17:11:05 +0200
User-Agent: KMail/1.4.7
References: <200210152120.13666.simon.roscic@chello.at> <200210171947.04255.simon.roscic@chello.at> <1034923374.10332.23.camel@localhost>
In-Reply-To: <1034923374.10332.23.camel@localhost>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Message-Id: <200210181711.05221.simon.roscic@chello.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 18 October 2002 08:42, GrandMasterLee <masterlee@digitalroadkill.net> wrote:
> One question about your config, are you using, on ANY machines,
> QLA2300's or PCI-X, and 5.38.x or 6.xx qlogic drivers? If so, then
> you've experienced no lockups with those machines too?

no, the 3 machines i use, are basically the same (ibm xseries 342), 
and have the same qlogic cards (qla2200), all 3 machines use the
same kernel (2.4.17+xfs+ext3-0.9.17+e100+e1000+qla2x00-5.36.3).

a few details, possibly something help's you:

---------------- lspci ----------------
00:00.0 Host bridge: ServerWorks CNB20HE (rev 23)
00:00.1 Host bridge: ServerWorks CNB20HE (rev 01)
00:00.2 Host bridge: ServerWorks: Unknown device 0006 (rev 01)
00:00.3 Host bridge: ServerWorks: Unknown device 0006 (rev 01)
00:06.0 VGA compatible controller: S3 Inc. Savage 4 (rev 06)
00:0f.0 ISA bridge: ServerWorks OSB4 (rev 51)
00:0f.1 IDE interface: ServerWorks: Unknown device 0211
00:0f.2 USB Controller: ServerWorks: Unknown device 0220 (rev 04)
01:02.0 RAID bus controller: IBM Netfinity ServeRAID controller
01:03.0 Ethernet controller: Intel Corporation 82543GC Gigabit Ethernet Controller (rev 02)
01:07.0 Ethernet controller: Intel Corporation 82557 [Ethernet Pro 100] (rev 0c)
02:05.0 SCSI storage controller: QLogic Corp. QLA2200 (rev 05)
---------------------------------------

--------- dmesg (qla stuff)--------
qla2x00: Found  VID=1077 DID=2200 SSVID=1077 SSDID=2
scsi1: Found a QLA2200  @ bus 2, device 0x5, irq 24, iobase 0x2100
scsi(1): Configure NVRAM parameters...
scsi(1): Verifying loaded RISC code...
scsi(1): Verifying chip...
scsi(1): Waiting for LIP to complete...
scsi(1): LIP reset occurred
scsi(1): LIP occurred.
scsi(1): LOOP UP detected
scsi1: Topology - (Loop), Host Loop address  0x7d
scsi-qla0-adapter-port=210000e08b064002\;
scsi-qla0-tgt-0-di-0-node=200600a0b80c3d8c\;
scsi-qla0-tgt-0-di-0-port=200600a0b80c3d8d\;
scsi-qla0-tgt-0-di-0-control=00\;
scsi-qla0-tgt-0-di-0-preferred=ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff\;
scsi1 : QLogic QLA2200 PCI to Fibre Channel Host Adapter: bus 2 device 5 irq 24
        Firmware version:  2.01.37, Driver version 5.36.3
  Vendor: IBM       Model: 3552              Rev: 0401
  Type:   Direct-Access                      ANSI SCSI revision: 03
  Vendor: IBM       Model: 3552              Rev: 0401
  Type:   Direct-Access                      ANSI SCSI revision: 03
  Vendor: IBM       Model: 3552              Rev: 0401
  Type:   Direct-Access                      ANSI SCSI revision: 03
  Vendor: IBM       Model: 3552              Rev: 0401
  Type:   Direct-Access                      ANSI SCSI revision: 03
scsi(1:0:0:0): Enabled tagged queuing, queue depth 16.
scsi(1:0:0:1): Enabled tagged queuing, queue depth 16.
scsi(1:0:0:2): Enabled tagged queuing, queue depth 16.
scsi(1:0:0:3): Enabled tagged queuing, queue depth 16.
Attached scsi disk sdb at scsi1, channel 0, id 0, lun 0
Attached scsi disk sdc at scsi1, channel 0, id 0, lun 1
Attached scsi disk sdd at scsi1, channel 0, id 0, lun 2
Attached scsi disk sde at scsi1, channel 0, id 0, lun 3
SCSI device sdb: 125829120 512-byte hdwr sectors (64425 MB)
 sdb: sdb1
SCSI device sdc: 125829120 512-byte hdwr sectors (64425 MB)
 sdc: sdc1
SCSI device sdd: 125829120 512-byte hdwr sectors (64425 MB)
 sdd: sdd1
SCSI device sde: 48599040 512-byte hdwr sectors (24883 MB)
 sde: sde1
---------------------------------------

alle 3 machines have the same filesystem concept:

internal storage -> ext3  (linux and programs)
storage on fastt500 -> xfs  (data only)

except the mount options, because the fileserver also need's
quotas, he has: 

rw,noatime,quota,usrquota,grpquota,logbufs=8,logbsize=32768


i consider the primary lotus domino server to be the machine wich
has to handle the highest load of the 3, because he currently has
to handle almost everything that has to do with lotus notes in your
company, it's friday afternoon here, so the load isn't realy high,
but it's possibly nice for you to know how much load the machine
has to handle:

---------------------------------------
  4:59pm  up 16 days, 23:17,  3 users,  load average: 0.43, 0.18, 0.11
445 processes: 441 sleeping, 4 running, 0 zombie, 0 stopped
CPU0 states:  6.13% user,  1.57% system,  0.0% nice, 91.57% idle
CPU1 states: 26.19% user,  5.27% system,  0.0% nice, 68.17% idle
Mem:  2061272K av, 2049636K used,   11636K free,       0K shrd,    1604K buff
Swap: 1056124K av,  262532K used,  793592K free                 1856420K cached
---------------------------------------
(/local/notesdata is on the fastt500)
adam:/ # lsof |grep /local/notesdata/ |wc -l
  33076
---------------------------------------
adam:/ # lsof |wc -l
   84604
---------------------------------------

simon.
(please CC me, i'm not subscribed to lkml)

