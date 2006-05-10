Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964993AbWEJQF5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964993AbWEJQF5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 12:05:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964986AbWEJQF4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 12:05:56 -0400
Received: from py-out-1112.google.com ([64.233.166.180]:9361 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S964929AbWEJQF3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 12:05:29 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=cV5x31KlfXdngGJ8rzyY19mUbSwdpGM4Ke85+L8Ws2sCYH3IP1od9+F/x0VL05MEd8z30zsRVxf6JsTs8MgAzWZW23s5IRKhcfkT0lbFeyjO8xFKcWBXbhOdkUo+/5K+jrPx3VWmGdGBQscYz3pTZDNXmW1fpKiVjd9Mflg74+4=
Message-ID: <3b0ffc1f0605100905x18d07f76jda38d1807cf9e9d7@mail.gmail.com>
Date: Wed, 10 May 2006 12:05:28 -0400
From: "Kevin Radloff" <radsaq@gmail.com>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Subject: Re: Updated libata PATA patch
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1147270145.17886.42.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1147196676.3172.133.camel@localhost.localdomain>
	 <3b0ffc1f0605091848med1f37ua83c283a922ea682@mail.gmail.com>
	 <1147270145.17886.42.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/10/06, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> On Maw, 2006-05-09 at 21:48 -0400, Kevin Radloff wrote:
> > ata3: PATA max PIO0 cmd 0x3100 ctl 0x310E bmdma 0x0 irq 11
> > setup_irq: irq handler mismatch
>
> Ok so we got an interrupt this time and then when we asked for it got
> told "no". That still shouldn't crash but there are some lurking
> problems when ata_device_add fails.
>
> More interesting is how it can occur.
>
> We asked for an IRQ that was "exclusive". We got given IRQ 11 which was
> shared. A look at the pcmcia code suggests the new drivers/pcmcia code
> is broken here: It may fall back to using an interrupt line that is
> shared even when told not to.
>
> What occurs if you change
>
>         ae.irq_flags = 0;
>
> to
>
>         ae.irq_flags = SA_SHIRQ ?

Another new and exciting oops :)

pccard: PCMCIA card inserted into slot 1
cs: memory probe 0x0c0000-0x0fffff: excluding 0xc0000-0xcffff 0xdc000-0xfffff
cs: memory probe 0x50000000-0x53ffffff: excluding 0x50000000-0x53ffffff
cs: memory probe 0x60000000-0x60ffffff: clean.
cs: memory probe 0xa0000000-0xa0ffffff: clean.
cs: memory probe 0xd0200000-0xd02fffff: excluding 0xd0200000-0xd021ffff
pcmcia: registering new device pcmcia1.0
ata3: PATA max PIO0 cmd 0x3100 ctl 0x310E bmdma 0x0 irq 11
ata3: dev 0 cfg 49:0200 82:0000 83:0000 84:0000 85:0000 86:0000 87:0000 88:0000
ata3: dev 0 ATA-10, max PIO4, 2001888 sectors: LBA
ata3: dev 0 configured for PIO0
scsi2 : pata_pcmcia
  Vendor: ATA       Model: SanDisk SDCFH-10  Rev: HDX
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sdb: 2001888 512-byte hdwr sectors (1025 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 3a 00 00
SCSI device sdb: drive cache: write through
SCSI device sdb: 2001888 512-byte hdwr sectors (1025 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 3a 00 00
SCSI device sdb: drive cache: write through
 sdb:<1>BUG: unable to handle kernel NULL pointer dereference at
virtual address 00000000
 printing eip:
00000000
*pde = 00000000
Oops: 0000 [#1]
PREEMPT
Modules linked in: pata_pcmcia rfcomm l2cap bluetooth appletalk psnap
llc ipt_LOG xt_limit xt_state iptable_filter ip_conntrack i915 drm
fuj02b1_acpi snd_intel8x0 snd_intel8x0m snd_ac97_codec snd_ac97_bus
snd_pcm_oss snd_mixer_oss snd_pcm snd_timer ehci_hcd pcmcia
firmware_class uhci_hcd joydev sg 8139too mii snd soundcore usbcore
sr_mod cdrom crc32 ohci1394 ieee1394 snd_page_alloc yenta_socket
rsrc_nonstatic pcmcia_core evdev psmouse
CPU:    0
EIP:    0060:[<00000000>]    Not tainted VLI
EFLAGS: 00010046   (2.6.17-rc3-ck3-ide2-fu-mw #1)
EIP is at _stext+0x4feffde0/0x3c
eax: e6c98b88   ebx: e6c98a90   ecx: 00000016   edx: f02b8fe0
esi: e6c98b88   edi: e6c98b98   ebp: e6c98b88   esp: e5954678
ds: 007b   es: 007b   ss: 0068
Process modprobe (pid: 3100, threadinfo=e5954000 task=eefd6030)
Stack: <0>b02411c5 00000000 ef620e50 b1926b00 b023ee3e e6c98a90
e6c98a90 ef620e40
       b02367f7 ef620e40 b0242f1d e6c98a90 e6c98b08 e5ed4800 b1926b00 e6c98a90
       b0243726 b02367f7 b0242f1d b02367f7 00000287 b1926b00 e6c98800 b191e02c
Call Trace:
 <b02411c5> ata_qc_issue_prot+0x5e/0x115   <b023ee3e> ata_qc_issue+0x31e/0x378
 <b02367f7> scsi_done+0x0/0x16   <b0242f1d> ata_scsi_rw_xlat+0x0/0x2b5
 <b0243726> ata_scsi_queuecmd+0x181/0x197   <b02367f7> scsi_done+0x0/0x16
 <b0242f1d> ata_scsi_rw_xlat+0x0/0x2b5   <b02367f7> scsi_done+0x0/0x16
 <b0236eb7> scsi_dispatch_cmd+0x178/0x1c8   <b023af8a>
scsi_request_fn+0x211/0x2b7
 <b01e8365> __generic_unplug_device+0x1d/0x1f   <b01e618e> elv_insert+0x97/0x130
 <b01e9647> __make_request+0x2e9/0x32c   <b01e799b>
generic_make_request+0x12d/0x13d
 <b012f661> __alloc_pages+0x4f/0x25c   <b012dcbd> mempool_alloc+0x1f/0xc6
 <b01e8f26> submit_bio+0xa3/0xa9   <b0147dcf> bio_alloc_bioset+0x9b/0xf3
 <b0145253> submit_bh+0xc5/0xe0   <b01476d2> block_read_full_page+0x22b/0x23a
 <b014a8b0> blkdev_get_block+0x0/0x33   <b012b679> add_to_page_cache+0x33/0x89
 <b012b6dc> add_to_page_cache_lru+0xd/0x20   <b012d3c2>
read_cache_page+0x7b/0x116
 <b0149c8f> blkdev_readpage+0x0/0xc   <b016f43a> msdos_partition+0x0/0x422
 <b016f293> read_dev_sector+0x22/0x78   <b016f480> msdos_partition+0x46/0x422
 <b01f1d8a> snprintf+0x1c/0x1f   <b011433c> printk+0x14/0x18
 <b016f43a> msdos_partition+0x0/0x422   <b016f1d7> rescan_partitions+0xe7/0x15d
 <b014a43d> do_open+0x200/0x2cb   <b014a55c> blkdev_get+0x54/0x5f
 <b016f3e4> register_disk+0xfb/0x14b   <b01eaa2a> add_disk+0x2b/0x36
 <b01ea3f4> exact_match+0x0/0x7   <b01ea8e9> exact_lock+0x0/0xd
 <b02462b1> sd_probe+0x2cb/0x32e   <b0233471> driver_probe_device+0x42/0x8b
 <b02334ba> __device_attach+0x0/0x5   <b0232ed7> bus_for_each_drv+0x32/0x58
 <b02334ff> device_attach+0x40/0x4f   <b02334ba> __device_attach+0x0/0x5
 <b0232dff> bus_add_device+0x27/0xcd   <b0232403> device_add+0xc4/0x122
 <b023cef2> scsi_sysfs_add_sdev+0x2a/0x1ce   <b011433c> printk+0x14/0x18
 <b023b9c1> scsi_probe_and_add_lun+0x60f/0x6f7   <b023bdf2>
scsi_alloc_target+0x20f/0x316
 <b023bfe5> __scsi_scan_target+0x84/0x4cc   <b01413a8>
cache_alloc_refill+0x2bb/0x433
 <b0170746> sysfs_new_dirent+0x19/0x5f   <b0170836> sysfs_make_dirent+0x11/0x66
 <b023c62e> scsi_scan_target+0x5f/0x73   <b02422c0> ata_scsi_scan_host+0x33/0x42
 <b0240e97> ata_device_add+0x4ea/0x599   <f02b7506>
pcmcia_init_one+0x4b4/0x512 [pata_pcmcia]
 <f017717e> pcmcia_device_probe+0x7b/0x109 [pcmcia]   <b023350e>
__driver_attach+0x0/0x59
 <b0233471> driver_probe_device+0x42/0x8b   <b0233544> __driver_attach+0x36/0x59
 <b0232f9c> bus_for_each_dev+0x33/0x55   <b02333db> driver_attach+0x11/0x13
 <b023350e> __driver_attach+0x0/0x59   <b0232cc6> bus_add_driver+0x64/0xfa
 <f0176d1f> pcmcia_register_driver+0x4a/0xab [pcmcia]   <b0128815>
sys_init_module+0x1221/0x13ae
 <b0102aeb> syscall_call+0x7/0xb
Code:  Bad EIP value.
EIP: [<00000000>] _stext+0x4feffde0/0x3c SS:ESP 0068:e5954678
 <6>note: modprobe[3100] exited with preempt_count 1

--
Kevin 'radsaq' Radloff
radsaq@gmail.com
http://thesaq.com/
