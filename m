Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262627AbSI0WX4>; Fri, 27 Sep 2002 18:23:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262633AbSI0WX4>; Fri, 27 Sep 2002 18:23:56 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.103]:20977 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S262627AbSI0WXu>;
	Fri, 27 Sep 2002 18:23:50 -0400
Date: Fri, 27 Sep 2002 15:28:42 -0700
From: Patrick Mansfield <patmans@us.ibm.com>
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
Cc: James Bottomley <James.Bottomley@steeleye.com>, Jens Axboe <axboe@suse.de>,
       Matthew Jacob <mjacob@feral.com>,
       "Pedro M. Rodrigues" <pmanuel@myrealbox.com>,
       Mathieu Chouquet-Stringer <mathieu@newview.com>,
       linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Warning - running *really* short on DMA buffers while doing file  transfers
Message-ID: <20020927152842.A18038@eng2.beaverton.ibm.com>
Mail-Followup-To: "Justin T. Gibbs" <gibbs@scsiguy.com>,
	James Bottomley <James.Bottomley@steeleye.com>,
	Jens Axboe <axboe@suse.de>, Matthew Jacob <mjacob@feral.com>,
	"Pedro M. Rodrigues" <pmanuel@myrealbox.com>,
	Mathieu Chouquet-Stringer <mathieu@newview.com>,
	linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <200209271721.g8RHLTn05231@localhost.localdomain> <2628736224.1033160295@aslan.btc.adaptec.com> <20020927143841.A17108@eng2.beaverton.ibm.com> <2668366224.1033164502@aslan.btc.adaptec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <2668366224.1033164502@aslan.btc.adaptec.com>; from gibbs@scsiguy.com on Fri, Sep 27, 2002 at 04:08:22PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 27, 2002 at 04:08:22PM -0600, Justin T. Gibbs wrote:
> >> http://people.FreeBSD.org/~gibbs/linux/linux-2.5-aic79xxx.tar.gz
> >> 
> >> --
> >> Justin
> > 
> > Any 2.5 patch for the above? Or aic7xxx/Config.in and
> > aic7xxx/Makefile for 2.5?
> 
> Try it now.
> 

Great! It boots up fine on my IBM netfinity system with 2.5.37.

I see:

[ boot up stuff deleted ] 

scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.10
        <Adaptec aic7896/97 Ultra2 SCSI adapter>
        aic7896/97: Ultra2 Wide Channel A, SCSI Id=7, 32/253 SCBs

scsi1 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.10
        <Adaptec aic7896/97 Ultra2 SCSI adapter>
        aic7896/97: Ultra2 Wide Channel B, SCSI Id=7, 32/253 SCBs

I turned on the debug flags, there were a bunch of odd messages
in there, but otherwise it seems to be working fine. My .config
has the following AIC config options:

CONFIG_SCSI_AIC7XXX=y
CONFIG_AIC7XXX_CMDS_PER_DEVICE=253
CONFIG_AIC7XXX_RESET_DELAY_MS=15000
CONFIG_AIC7XXX_ALLOW_MEMIO=y
# CONFIG_AIC7XXX_PROBE_EISA_VL is not set
# CONFIG_AIC7XXX_BUILD_FIRMWARE is not set
CONFIG_AIC7XXX_DEBUG_ENABLE=y
CONFIG_AIC7XXX_DEBUG_MASK=0
CONFIG_AIC7XXX_REG_PRETTY_PRINT=y
# CONFIG_SCSI_AIC79XX is not set

Weird boot time messages:

INITIATOR_MSG_OUTINITIATOR_MSG_OUTINITIATOR_MSG_OUTINITIATOR_MSG_OUTINITIATOR_MSG_OUTINITIATOR_MSG_OUTINITIATOR_MSG_OUTINITIATOR_MSG_OUTINITIATOR_MSG_OUTINITIATOR_MSG_OUTINITIATOR_MSG_OUT<5>  Vendor: IBM-PSG   Model: ST318203LC    !#  Rev: B222
  Type:   Direct-Access                      ANSI SCSI revision: 02
INITIATOR_MSG_OUTINITIATOR_MSG_OUTINITIATOR_MSG_OUTINITIATOR_MSG_OUTINITIATOR_MSG_OUTINITIATOR_MSG_OUTINITIATOR_MSG_OUTINITIATOR_MSG_OUTINITIATOR_MSG_OUTINITIATOR_MSG_OUTINITIATOR_MSG_OUTINITIATOR_MSG_OUT(scsi0:A:0): 80.000MB/s transfers (40.000MHz, offset 15, 16bit)
INITIATOR_MSG_OUTINITIATOR_MSG_OUTINITIATOR_MSG_OUTINITIATOR_MSG_OUTINITIATOR_MSG_OUTINITIATOR_MSG_OUTINITIATOR_MSG_OUTINITIATOR_MSG_OUTINITIATOR_MSG_OUTINITIATOR_MSG_OUTINITIATOR_MSG_OUT<5>  Vendor: IBM-PSG   Model: ST318203LC    !#  Rev: B222
  Type:   Direct-Access                      ANSI SCSI revision: 02
INITIATOR_MSG_OUTINITIATOR_MSG_OUTINITIATOR_MSG_OUTINITIATOR_MSG_OUTINITIATOR_MSG_OUTINITIATOR_MSG_OUTINITIATOR_MSG_OUTINITIATOR_MSG_OUTINITIATOR_MSG_OUTINITIATOR_MSG_OUTINITIATOR_MSG_OUTINITIATOR_MSG_OUT(scsi0:A:1): 80.000MB/s transfers (40.000MHz, offset 15, 16bit)
  Vendor: IBM       Model: LN V1.2Rack       Rev: B004
  Type:   Processor                          ANSI SCSI revision: 02
scsi0:A:0:0: Tagged Queuing enabled.  Depth 253
scsi0:A:1:0: Tagged Queuing enabled.  Depth 253
st: Version 20020822, fixed bufsize 32768, wrt 30720, s/g segs 256
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
Attached scsi disk sdb at scsi0, channel 0, id 1, lun 0
INITIATOR_MSG_OUTINITIATOR_MSG_OUTINITIATOR_MSG_OUTINITIATOR_MSG_OUTINITIATOR_MSG_OUTINITIATOR_MSG_OUTINITIATOR_MSG_OUTINITIATOR_MSG_OUTINITIATOR_MSG_OUTINITIATOR_MSG_OUTINITIATOR_MSG_OUTINITIATOR_MSG_OUT<5>SCSI device sda: 35548320 512-byte hdwr sectors (18201 MB)
 sda: sda1 sda2
INITIATOR_MSG_OUTINITIATOR_MSG_OUTINITIATOR_MSG_OUTINITIATOR_MSG_OUTINITIATOR_MSG_OUTINITIATOR_MSG_OUTINITIATOR_MSG_OUTINITIATOR_MSG_OUTINITIATOR_MSG_OUTINITIATOR_MSG_OUTINITIATOR_MSG_OUTINITIATOR_MSG_OUTINITIATOR_MSG_OUTINITIATOR_MSG_OUTINITIATOR_MSG_OUTINITIATOR_MSG_OUTINITIATOR_MSG_OUTINITIATOR_MSG_OUTINITIATOR_MSG_OUTINITIATOR_MSG_OUTINITIATOR_MSG_OUTINITIATOR_MSG_OUTINITIATOR_MSG_OUTINITIATOR_MSG_OUTINITIATOR_MSG_OUTINITIATOR_MSG_OUT<5>SCSI device sdb: 35548320 512-byte hdwr sectors (18201 MB)
 sdb: sdb1 sdb2
Attached scsi generic sg2 at scsi0, channel 0, id 15, lun 0,  type 3
mice: PS/2 mouse device common for all mice
input: PS/2 Generic Mouse on isa0060/serio1
serio: i8042 AUX port at 0x60,0x64 irq 12
input: AT Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 2048 buckets, 32Kbytes
TCP: Hash tables configured (established 16384 bind 21845)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 96k freed
INIT: version 2.78 booting

[ more boot up stuff ]

-- Patrick Mansfield
