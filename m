Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261601AbUCPV50 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 16:57:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261726AbUCPV5Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 16:57:25 -0500
Received: from krusty.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:46276 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S261601AbUCPV5I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 16:57:08 -0500
Date: Tue, 16 Mar 2004 22:56:59 +0100
From: Matthias Andree <ma+lscsi@dt.e-technik.uni-dortmund.de>
To: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: 2.6.5-rc1 SCSI + st regressions (was: Linux 2.6.5-rc1)
Message-ID: <20040316215659.GA3861@merlin.emma.line.org>
Mail-Followup-To: linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.58.0403152154070.19853@ppc970.osdl.org> <20040316211203.GA3679@merlin.emma.line.org> <20040316211700.GA25059@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040316211700.GA25059@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Mar 2004, Matthew Wilcox wrote:

> On Tue, Mar 16, 2004 at 10:12:03PM +0100, Matthias Andree wrote:
> > I have some SCSI troubles with 2.6.5-rc1 (from BK) that 2.6.4 didn't
> > have.
> > 
> > Modprobe, loading the st driver, tries a NULL pointer dereference in
> > kernel space and my 2nd tape drive isn't found: st1 is not shown. cat
> > /proc/scsi/scsi (typed after the attempted zero page dereference) hangs
> > in rwsem_down_read_failed with process state D.
> 
> I notice you're using the sym2 driver.  Could you try backing out the
> changes made to it in 2.6.5-rc1, just to be sure we're looking at an st
> problem, not a sym2 problem?

I've backed out the 2004-03-12 ChangeSet,
willy@debian.org|ChangeSet|20040312212827|57687

and rebooted, result (does that make sense? Was that a complete
back-out?):

...
sym0: <875> rev 0x26 at pci 0000:00:0d.0 irq 16
sym0: Tekram NVRAM, ID 7, Fast-20, SE, parity checking
sym0: SCSI BUS has been reset.
scsi0 : sym-2.1.18f
  Vendor: FUJITSU   Model: MAH3182MP         Rev: 0114
  Type:   Direct-Access                      ANSI SCSI revision: 04
sym0:1:0: tagged command queuing enabled, command queue depth 32.
  Vendor: PLEXTOR   Model: CD-ROM PX-32TS    Rev: 1.02
  Type:   CD-ROM                             ANSI SCSI revision: 02
  Vendor: TANDBERG  Model:  TDC 4222         Rev: =07:
  Type:   Sequential-Access                  ANSI SCSI revision: 02
  Vendor: TANDBERG  Model: SLR6              Rev: 0404
  Type:   Sequential-Access                  ANSI SCSI revision: 02
DC390: 0 adapters found
libata version 1.01 loaded.
sym0:1: FAST-20 WIDE SCSI 40.0 MB/s ST (50.0 ns, offset 16)
SCSI device sda: 35701260 512-byte hdwr sectors (18279 MB)
SCSI device sda: drive cache: write through
 sda: sda1 sda2 sda3 < sda5 >
Attached scsi disk sda at scsi0, channel 0, id 1, lun 0
...
Attached scsi generic sg0 at scsi0, channel 0, id 1, lun 0,  type 0
Attached scsi generic sg1 at scsi0, channel 0, id 2, lun 0,  type 5
Attached scsi generic sg2 at scsi0, channel 0, id 6, lun 0,  type 1
Attached scsi generic sg3 at scsi0, channel 0, id 8, lun 0,  type 1
sym0:2: FAST-20 SCSI 20.0 MB/s ST (50.0 ns, offset 15)
sr0: scsi-1 drive
Attached scsi CD-ROM sr0 at scsi0, channel 0, id 2, lun 0
st: Version 20040226, fixed bufsize 32768, s/g segs 256
Unable to handle kernel NULL pointer dereference at virtual address 0000002e
 printing eip:
d1ba00fc
*pde = 00000000
Oops: 0002 [#1]
CPU:    0
EIP:    0060:[<d1ba00fc>]    Not tainted
EFLAGS: 00010282   (2.6.5-rc1) 
EIP is at st_probe+0x7dc/0x99f [st]
eax: cd4d824c   ebx: ffffffea   ecx: 00000000   edx: 0000000a
esi: 00000004   edi: 00000000   ebp: c135fdbc   esp: c135fd34
ds: 007b   es: 007b   ss: 0068
Process modprobe (pid: 1304, threadinfo=c135e000 task=c1384620)
Stack: ccab5cc0 00900000 cfa3597c d1ba0628 ccbaf6c4 00000000 c135fd68 c135fd68 
       00000000 cd4d824c 00000000 cd4d824c cc6d0c80 c135fd84 00000000 cd4d8200 
       cd979980 00000008 cdb39000 00000000 d1ba2bf0 00000000 00000000 cd4d824c 
Call Trace:
 [<c027eaeb>] bus_match+0x3b/0x70
 [<c027ed00>] driver_attach+0x50/0x90
 [<c027eddb>] bus_add_driver+0x9b/0xc0
 [<c027f3c1>] driver_register+0x31/0x40
 [<d19e50b6>] init_st+0xb6/0x155 [st]
 [<c0131200>] sys_init_module+0x130/0x1670
 [<c01bd5c1>] journal_stop+0x171/0x210
 [<c01af4b7>] ext3_mark_inode_dirty+0x47/0x60
 [<c0157110>] cdev_alloc+0x0/0x60
 [<c0144c55>] do_mmap_pgoff+0x365/0x6c0
 [<c014cda7>] filp_close+0x57/0x90
 [<c014ce2f>] sys_close+0x4f/0x60
 [<c01070ff>] syscall_call+0x7/0xb

Code: 89 43 44 89 1c 24 c7 44 24 04 5c 2a ba d1 e8 f1 fb 6d ee c7 
 <6>sym0:6: FAST-5 SCSI 4.8 MB/s ST (208.0 ns, offset 8)
st0: Block limits 1 - 16777215 bytes.

-- 
Matthias Andree

Encrypt your mail: my GnuPG key ID is 0x052E7D95
