Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263318AbVGAMfg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263318AbVGAMfg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Jul 2005 08:35:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263319AbVGAMff
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Jul 2005 08:35:35 -0400
Received: from web52611.mail.yahoo.com ([68.142.228.58]:46955 "HELO
	web52611.mail.yahoo.com") by vger.kernel.org with SMTP
	id S263318AbVGAMfF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Jul 2005 08:35:05 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=6CmHkozkp+rnK6DZ8yp/n0oudHc0Jz6ohvOAhH5K8dfIgFo2ZDeIUWeX1sRVO/Aqk0TcbEybfeeA6XqyuaQPAORhQuKsqbzPr2toL7fapuwX4tHkzwnmkAXnmGCp7vF7oeartcLSKGZ5Ywy4wjv9KbqPfWrwgupFvkpTTPAw7qg=  ;
Message-ID: <20050701123505.12677.qmail@web52611.mail.yahoo.com>
Date: Fri, 1 Jul 2005 22:35:05 +1000 (EST)
From: Srihari Vijayaraghavan <sriharivijayaraghavan@yahoo.com.au>
Subject: Re: [PROBLEM] kernel BUG at include/linux/blkdev.h:601
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050701080243.GX2243@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- Jens Axboe <axboe@suse.de> wrote:
> On Fri, Jul 01 2005, Srihari Vijayaraghavan wrote:
> > [...]
> > I haven't tested whether earlier releases of 2.6
> > suffer from this (such as 2.6.10, 2.6.11 ..) or
> other
> > hardware combinations exhibit the same problem
> etc.

Actually, I've tested it on another computer (AMD64):
VP_IDE: VIA vt8237 (rev 00) IDE UDMA133 controller on
pci0000:00:0f.1
    ide0: BM-DMA at 0xcc00-0xcc07, BIOS settings:
hda:DMA, hdb:pio
    ide1: BM-DMA at 0xcc08-0xcc0f, BIOS settings:
hdc:DMA, hdd:DMA
hda: ST3120026A, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: HL-DT-ST DVDRAM GSA-4163B, ATAPI CD/DVD-ROM drive
hdd: RICOH CD-R/RW MP7083A, ATAPI CD/DVD-ROM drive

> There are some minor ide updates outside of ide-cd,
> they must be
> accounting for your success in 2.6.13-rc1 then.
> Could you test 2.6.12
> with this patch applied?
> 
> diff --git a/drivers/ide/ide-iops.c
> b/drivers/ide/ide-iops.c

Unfortunately, there's still problem with that patch
with Ricoh drive:

Kernel BUG at "include/linux/blkdev.h":607
invalid operand: 0000 [1] 
CPU 0 
Modules linked in: radeon autofs4 sunrpc ipt_REJECT
ipt_state ip_conntrack iptable_filter ip_tables dm_mod
video thermal processor fan button ohci1394 ieee1394
uhci_hcd ehci_hcd i2c_viapro i2c_core snd_via82xx
snd_ac97_codec snd_seq_dummy snd_seq_oss
snd_seq_midi_event snd_seq snd_pcm_oss snd_mixer_oss
snd_pcm snd_timer snd_page_alloc snd_mpu401_uart
snd_rawmidi snd_seq_device snd soundcore via_rhine mii
r8169 crc32 floppy ide_cd cdrom ext3 mbcache jbd
sata_via libata sd_mod scsi_mod
Pid: 0, comm: swapper Not tainted 2.6.12-ide
RIP: 0010:[<ffffffff80241cb8>]
<ffffffff80241cb8>{__ide_end_request+216}
RSP: 0018:ffffffff80392c08  EFLAGS: 00010046
RAX: 0000000000000061 RBX: ffff81003e649c80 RCX:
0000000000000001
RDX: ffff81003e649c80 RSI: 0000000001600140 RDI:
ffff81003c9bad80
RBP: 0000000000000001 R08: ffffffff803ec000 R09:
0000000000000040
R10: 0000000000000040 R11: 0000000000000040 R12:
ffffffff803cf850
R13: 0000000000000001 R14: 0000000000000001 R15:
0000000000000001
FS:  00002aaaaacfb6e0(0000) GS:ffffffff803e6ac0(0000)
knlGS:0000000000000000
CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
CR2: 00002aaaaaaac000 CR3: 0000000036cee000 CR4:
00000000000006e0
Process swapper (pid: 0, threadinfo ffffffff803ec000,
task ffffffff80326980)
Stack: 0000000000000001 0000000000000001
ffff81003e649c80 ffffffff803cf850 
       0000000000000292 ffffffff80241da0
ffffffff803cf850 0000000000000000 
       ffff81003e649c80 0000000000000001 
Call Trace: <IRQ>
<ffffffff80241da0>{ide_end_request+112}
<ffffffff880725c4>{:ide_cd:cdrom_end_request+1108}
       <ffffffff802365e7>{freed_request+39}
<ffffffff8807323a>{:ide_cd:cdrom_pc_intr+250}
       <ffffffff88073140>{:ide_cd:cdrom_pc_intr+0}
<ffffffff802431e8>{ide_intr+392}
       <ffffffff8015267c>{handle_IRQ_event+44}
<ffffffff80152766>{__do_IRQ+182}
       <ffffffff801110c8>{do_IRQ+72}
<ffffffff8010ec11>{ret_from_intr+0}
        <EOI> <ffffffff8010d110>{default_idle+0}
<ffffffff8010d132>{default_idle+34}
       <ffffffff8010d171>{cpu_idle+49}
<ffffffff803ee7e5>{start_kernel+469}
       <ffffffff803ee1f4>{_sinittext+500} 

Code: 0f 0b 6e e0 2f 80 ff ff ff ff 5f 02 48 8b 43 08
48 89 42 08 
RIP <ffffffff80241cb8>{__ide_end_request+216} RSP
<ffffffff80392c08>
 <3>Debug: sleeping function called from invalid
context at include/linux/rwsem.h:43
in_atomic():1, irqs_disabled():1

Call Trace: <IRQ>
<ffffffff80132fe5>{profile_task_exit+21}
<ffffffff80133f32>{do_exit+34}
       <ffffffff80211aa7>{do_unblank_screen+135}
<ffffffff8010fef5>{die+69}
       <ffffffff80110a23>{do_invalid_op+163}
<ffffffff80241cb8>{__ide_end_request+216}
       <ffffffff8015267c>{handle_IRQ_event+44}
<ffffffff8010ef35>{error_exit+0}
       <ffffffff80241cb8>{__ide_end_request+216}
<ffffffff80241c97>{__ide_end_request+183}
       <ffffffff80241da0>{ide_end_request+112}
<ffffffff880725c4>{:ide_cd:cdrom_end_request+1108}
       <ffffffff802365e7>{freed_request+39}
<ffffffff8807323a>{:ide_cd:cdrom_pc_intr+250}
       <ffffffff88073140>{:ide_cd:cdrom_pc_intr+0}
<ffffffff802431e8>{ide_intr+392}
       <ffffffff8015267c>{handle_IRQ_event+44}
<ffffffff80152766>{__do_IRQ+182}
       <ffffffff801110c8>{do_IRQ+72}
<ffffffff8010ec11>{ret_from_intr+0}
        <EOI> <ffffffff8010d110>{default_idle+0}
<ffffffff8010d132>{default_idle+34}
       <ffffffff8010d171>{cpu_idle+49}
<ffffffff803ee7e5>{start_kernel+469}
       <ffffffff803ee1f4>{_sinittext+500} 
Kernel panic - not syncing: Aiee, killing interrupt
handler!

With 2.6.13-rc1 (+Hugh's patch), all is well in this
computer. And oh, the LG DVD-RW drive doesn't crash
even in 2.6.12, though I didn't wait for more than 10+
minutes. (IOW, it must be hardware dependant.)

Thanks
Hari.

PS: I added -ide suffix to kernel version, so that
kernel build doesn't overwrite the real 2.6.12 modules
directory.



	

	
		
____________________________________________________ 
Do you Yahoo!? 
Try Yahoo! Photomail Beta: Send up to 300 photos in one email! 
http://au.photomail.mail.yahoo.com
