Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932247AbWJTKGp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932247AbWJTKGp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 06:06:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932248AbWJTKGo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 06:06:44 -0400
Received: from mta.songnetworks.no ([62.73.241.55]:42480 "EHLO
	vebeella.fastcom.no") by vger.kernel.org with ESMTP id S932247AbWJTKGn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 06:06:43 -0400
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <C5C787DB-6791-462E-9907-F3A0438E6B9C@karlsbakk.net>
Cc: =?ISO-8859-1?Q?Lars_Christian_Nyg=E5rd?= <lars@snart.com>
Content-Transfer-Encoding: 7bit
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
Subject: Debugging I/O errors?
Date: Fri, 20 Oct 2006 12:06:36 +0200
To: linux-kernel@vger.kernel.org
X-Mailer: Apple Mail (2.752.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all

Stresstesting a SATA drive+controller, I get the error below after a  
while. How can I find if this error is due to a controller failure, a  
bad driver, or a drive failure?

thanks for all help

system info below

roy
-----
Running an unpatched 2.6.18.1

This is a SIS controller:
01:03.0 RAID bus controller: Silicon Image, Inc. SiI 3114 [SATALink/ 
SATARaid] Serial ATA Controller (rev 02)
         Subsystem: Silicon Image, Inc. SiI 3114 SATARaid Controller
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-  
ParErr- Stepping- SERR+ FastB2B-
         Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium  
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 32, Cache Line Size: 32 bytes
         Interrupt: pin A routed to IRQ 10
         Region 0: I/O ports at dc00 [size=8]
         Region 1: I/O ports at d480 [size=4]
         Region 2: I/O ports at d400 [size=8]
         Region 3: I/O ports at d080 [size=4]
         Region 4: I/O ports at d000 [size=16]
         Region 5: Memory at ff8efc00 (32-bit, non-prefetchable)  
[size=1K]
         Expansion ROM at c6a00000 [disabled] [size=512K]
         Capabilities: [60] Power Management version 2
                 Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME 
(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=2 PME-

The drive is a seagate 400gig thing (dunno how I can find what),  
libata is alone at IRQ10.

/var/log/kern.log output
Oct 19 18:32:04 ganske kernel: EXT3-fs error (device sda1):  
ext3_free_blocks_sb: bit already cleared for block 35140273
Oct 19 18:32:04 ganske kernel: Aborting journal on device sda1.
Oct 19 18:32:04 ganske kernel: EXT3-fs error (device sda1) in  
ext3_ordered_writepage: IO failure
Oct 19 18:32:04 ganske kernel: EXT3-fs error (device sda1) in  
ext3_ordered_writepage: IO failure
Oct 19 18:32:04 ganske kernel: ext3_abort called.
Oct 19 18:32:04 ganske kernel: EXT3-fs error (device sda1):  
ext3_journal_start_sb: Detected aborted journal
Oct 19 18:32:04 ganske kernel: Remounting filesystem read-only
Oct 19 18:32:04 ganske kernel: EXT3-fs error (device sda1) in  
ext3_ordered_writepage: IO failure
Oct 19 18:32:04 ganske last message repeated 2 times
Oct 19 18:32:08 ganske kernel: 0843
Oct 19 18:32:08 ganske kernel: EXT3-fs error (device sda1):  
ext3_free_blocks_sb: bit already cleared for block 35140844
Oct 19 18:32:08 ganske kernel: EXT3-fs error (device sda1):  
ext3_free_blocks_sb: bit already cleared for block 35140845
Oct 19 18:32:08 ganske kernel: EXT3-fs error (device sda1):  
ext3_free_blocks_sb: bit already cleared for block 35140847
Oct 19 18:32:08 ganske kernel: EXT3-fs error (device sda1):  
ext3_free_blocks_sb: bit already cleared for block 35140848
Oct 19 18:32:08 ganske kernel: EXT3-fs error (device sda1):  
ext3_free_blocks_sb: bit already cleared for block 35140851
Oct 19 18:32:08 ganske kernel: EXT3-fs error (device sda1):  
ext3_free_blocks_sb: bit already cleared for block 35140855
Oct 19 18:32:08 ganske kernel: EXT3-fs error (device sda1):  
ext3_free_blocks_sb: bit already cleared for block 35140857
Oct 19 18:32:08 ganske kernel: EXT3-fs error (device sda1):  
ext3_free_blocks_sb: bit already cleared for block 35140860
Oct 19 18:32:08 ganske kernel: EXT3-fs error (device sda1):  
ext3_free_blocks_sb: bit already cleared for block 35140863
Oct 19 18:32:08 ganske kernel: EXT3-fs error (device sda1):  
ext3_free_blocks_sb: bit already cleared for block 35140864
Oct 19 18:32:08 ganske kernel: EXT3-fs error (device sda1):  
ext3_free_blocks_sb: bit already cleared for block 35140867
Oct 19 18:32:08 ganske kernel: EXT3-fs error (device sda1):  
ext3_free_blocks_sb: bit already cleared for block 35140868
Oct 19 18:32:08 ganske kernel: EXT3-fs error (device sda1):  
ext3_free_blocks_sb: bit already cleared for block 35140870
Oct 19 18:32:08 ganske kernel: EXT3-fs error (device sda1):  
ext3_free_blocks_sb: bit already cleared for block 35140871
Oct 19 18:32:08 ganske kernel: EXT3-fs error (device sda1):  
ext3_free_blocks_sb: bit already cleared for block 35140873
Oct 19 18:32:08 ganske kernel: EXT3-fs error (device sda1):  
ext3_free_blocks_sb: bit already cleared for block 35140875
Oct 19 18:32:08 ganske kernel: EXT3-fs error (device sda1):  
ext3_free_blocks_sb: bit already cleared for block 35140879
Oct 19 18:32:08 ganske kernel: EXT3-fs error (device sda1):  
ext3_free_blocks_sb: bit already cleared for block 35140883
Oct 19 18:32:08 ganske kernel: EXT3-fs error (device sda1):  
ext3_free_blocks_sb: bit already cleared for block 35140884
Oct 19 18:32:08 ganske kernel: EXT3-fs error (device sda1):  
ext3_free_blocks_sb: bit already cleared for block 35140886
Oct 19 18:32:08 ganske kernel: EXT3-fs error (device sda1):  
ext3_free_blocks_sb: bit already cleared for block 35140887
Oct 19 18:32:08 ganske kernel: EXT3-fs error (device sda1):  
ext3_free_blocks_sb: bit already cleared for block 35140889
Oct 19 18:32:08 ganske kernel: EXT3-fs error (device sda1):  
ext3_free_blocks_sb: bit already cleared for block 35140891
Oct 19 18:32:08 ganske kernel: EXT3-fs error (device sda1):  
ext3_free_blocks_sb: bit already cleared for block 35140892
Oct 19 18:32:08 ganske kernel: EXT3-fs error (device sda1):  
ext3_free_blocks_sb: bit already cleared for block 35140893
Oct 19 18:32:08 ganske kernel: EXT3-fs error (device sda1):  
ext3_free_blocks_sb: bit already cleared for block 35140895
Oct 19 18:32:08 ganske kernel: EXT3-fs error (device sda1):  
ext3_free_blocks_sb: bit already cleared for block 35140896
Oct 19 18:32:08 ganske kernel: EXT3-fs error (device sda1):  
ext3_free_blocks_sb: bit already cleared for block 35140898
Oct 19 18:32:08 ganske kernel: EXT3-fs error (device sda1):  
ext3_free_blocks_sb: bit already cleared for block 35140899
Oct 19 18:32:08 ganske kernel: EXT3-fs error (device sda1):  
ext3_free_blocks_sb: bit already cleared for block 35140902
Oct 19 18:32:08 ganske kernel: EXT3-fs error (device sda1):  
ext3_free_blocks_sb: bit already cleared for block 35140903
Oct 19 18:32:08 ganske kernel: EXT3-fs error (device sda1):  
ext3_free_blocks_sb: bit already cleared for block 35140904
Oct 19 18:32:08 ganske kernel: EXT3-fs error (device sda1) in  
ext3_free_blocks_sb: Journal has aborted
Oct 19 18:32:08 ganske kernel: EXT3-fs error (device sda1) in  
ext3_reserve_inode_write: Journal has aborted
Oct 19 18:32:08 ganske kernel: EXT3-fs error (device sda1) in  
ext3_truncate: Journal has aborted
Oct 19 18:32:08 ganske kernel: EXT3-fs error (device sda1) in  
ext3_reserve_inode_write: Journal has aborted
Oct 19 18:32:08 ganske kernel: EXT3-fs error (device sda1) in  
ext3_orphan_del: Journal has aborted
Oct 19 18:32:08 ganske kernel: EXT3-fs error (device sda1) in  
ext3_reserve_inode_write: Journal has aborted
Oct 19 18:32:08 ganske kernel: __journal_remove_journal_head: freeing  
b_committed_data
Oct 19 18:32:08 ganske last message repeated 219 times
ganske:~#

--
Roy Sigurd Karlsbakk
roy@karlsbakk.net
-------------------------------
MICROSOFT: Acronym for "Most Intelligent Customers Realise Our  
Software Only Fools Teenagers"

