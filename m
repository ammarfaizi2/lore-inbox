Return-Path: <linux-kernel-owner+w=401wt.eu-S1751515AbXAKVI7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751515AbXAKVI7 (ORCPT <rfc822;w@1wt.eu>);
	Thu, 11 Jan 2007 16:08:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751516AbXAKVI7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Jan 2007 16:08:59 -0500
Received: from wx-out-0506.google.com ([66.249.82.227]:36270 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751518AbXAKVI6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Jan 2007 16:08:58 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=sdkMpCysSmAm+SfSM7+89v98B4f6f6BD4SaBowpf+eVLGefB3hFzUi/9ch7XcnHHaqqSLfrSAbG/RlQkZMuezdmzkRYsPrNR3z1oTdoxnPCyGDUMUcJ7xfTbfemRjEwYOFa7XLPGEY6rD1TN6ZvBNYglCVu9QHgjUr9ZU9q6dJ4=
Message-ID: <948ae28c0701111308w6cfba9f2gf23557b402efc60f@mail.gmail.com>
Date: Thu, 11 Jan 2007 14:08:57 -0700
From: "meaty biscuit" <meatybiscuit@gmail.com>
To: "Bartlomiej Zolnierkiewicz" <bzolnier@gmail.com>
Subject: Re: DMA problems in ide-scsi
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <58cb370e0701101800v19496013w9fa2e496949d4e40@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <948ae28c0701101559j1e750d61g1f810feb04c1c4fb@mail.gmail.com>
	 <948ae28c0701101653n572d0c63n2145e9b4208a6e5b@mail.gmail.com>
	 <58cb370e0701101800v19496013w9fa2e496949d4e40@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is a log of the kernel panic (via serial console, if there is a
better way to capture the output please let me know):

ide-scsi: hdb: suc 91
ide-scsi: hdb: que 92, cmd = [ 51 0 0 0 0 0 0 0 64 0 ]
ide-scsi: hdb: suc 92, rst = [ 0 20 0 1 1 1 1 0 ff 0 0 0 0 0 0 0 ]
ide-scsi: hdb: que 93, cmd = [ 52 1 0 0 0 1 0 0 ff 0 ]
ide-scsi: hdb: suc 93, rst = [ 0 22 1 1 0 6 42 1 0 0 0 0 0 0 0 0 ]
ide-scsi: hdb: que 94, cmd = [ 52 1 0 0 0 1 0 0 ff 0 ]
ide-scsi: hdb: suc 94, rst = [ 0 22 1 1 0 6 42 1 0 0 0 0 0 0 0 0 ]
ide-scsi: hdb: que 95, cmd = [ 0 0 0 0 0 0 ]
ide-scsi: hdb: suc 95
ide-scsi: hdb: que 96, cmd = [ 2a 0 0 0 0 0 0 0 80 0 ]
Unable to handle kernel NULL pointer dereference at virtual address 00000024
 printing eip:
f88c0969
*pde = 00000000
Oops: 0000 [#1]
PREEMPT SMP
Modules linked in: sg sr_mod cdrom snd_pcm_oss snd_mixer_oss nvidia
agpgart i2c_core snd_hda_intel snd_hda_codec snd_intel8x0
snd_ac97_codec snd_ac97_bus snd_pcm snd_timer snd soundcore
snd_page_alloc UniMc nfsd lockd nfs_acl sunrpc usbserial e1000
af_packet iptable_filter ip_tables ide_scsi aic7xxx scsi_transport_spi
piix ide_core psmouse microcode ext3 jbd mbcache usbmouse usbkbd
usbhid uhci_hcd ehci_hcd usbcore rtc xfs exportfs sd_mod ata_piix
libata scsi_mod
CPU:    0
EIP:    0060:[<f88c0969>]    Tainted: P      VLI
EFLAGS: 00010086   (2.6.15.7-gemOS-v009)
EIP is at idescsi_expiry+0x1b/0x44 [ide_scsi]
eax: 00000000   ebx: f883e2e0   ecx: 00000001   edx: 00000286
esi: f8a47c58   edi: f88c0992   ebp: ffffffff   esp: c02fdee4
ds: 007b   es: 007b   ss: 0068
Process swapper (pid: 0, threadinfo=c02fc000 task=c02b5b40)
Stack: f88c2240 00000286 f7495e80 f7495e80 f8a33cdd f8a47c58 00000102 f882d18c
       c19070e0 00000286 f7495e80 00000102 f8a33c90 c19070e0 c0127a0b f7495e80
       a56b6b80 000f422a c02b5b40 c02fc000 c02fdf34 c02fdf34 c02b5b40 c02f3308
Call Trace:
 [<f8a33cdd>] ide_timer_expiry+0x4d/0x1d2 [ide_core]
 [<f882d18c>] scsi_times_out+0x0/0x8c [scsi_mod]
 [<f8a33c90>] ide_timer_expiry+0x0/0x1d2 [ide_core]
 [<c0127a0b>] run_timer_softirq+0xdf/0x1d2
 [<c01234e3>] __do_softirq+0xbf/0xd2
 [<c012353e>] do_softirq+0x48/0x4a
 [<c0123648>] irq_exit+0x42/0x44
 [<c0103aac>] apic_timer_interrupt+0x1c/0x24
 [<c0100ff8>] mwait_idle+0x4a/0x54
 [<c0100fae>] mwait_idle+0x0/0x54
 [<c0100e18>] cpu_idle+0x82/0xa0
 [<c02fe8e7>] start_kernel+0x189/0x1c6
 [<c02fe328>] unknown_bootoption+0x0/0x1a8
Code: a5 89 c1 83 e1 03 74 02 f3 a4 0f b6 45 00 eb 97 83 ec 10 89 5c
24 0c 8b 44 24 14 8b 40 1c 8b 58 10 c7 04 24 40 22 8c f8 8b 43 2c <8b>
40 24 89 44 24 04 a1 00 34 2f c0 89 44 24 08 e8 3a db 85 c7
 <0>Kernel panic - not syncing: Fatal exception in interrupt
ide-scsi: abort called for 96

This is the output when the module is compiled with debug messages
turned on, notice the last SCSI command:  ide-scsi: hdb: que 96, cmd =
[ 2a 0 0 0 0 0 0 0 80 0 ]

I checked the SCSI standard, 2a is the "write (10)" command.

Below is another log that I captured when attempting to burn a CD
(again with DMA enabled) using a different application (internally
developed) that writes to CD by sending SCSI ioctls directly to the
/dev/sgX device (as opposed to burning an ISO or another file using
cdrecord):


ide-scsi: The scsi wants to send us more data than expected - discarding data
ide-scsi: transferred 1 of 2 bytes
ide-scsi: The scsi wants to send us more data than expected - discarding data
ide-scsi: transferred 1 of 2 bytes
hdb: DMA timeout retry
hdb: timeout waiting for DMA
ide-scsi: No active request in idescsi_eh_reset
hdb: status timeout: status=0xd0 { Busy }
ide: failed opcode was: unknown
hdb: drive not ready for command
hdb: status timeout: status=0xd0 { Busy }
ide: failed opcode was: unknown
hdb: drive not ready for command
ata1: BUG: timeout without command

Thanks again to anyone that can respond.  Special thanks to Bart!



On 1/10/07, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:
> Hi,
>
> On 1/11/07, meaty biscuit <meatybiscuit@gmail.com> wrote:
> > I know there are lots of people that are glad to be done with
> > ide-scsi, but I'm hoping there is someone out there that has some
> > experience with this driver that my be able to help.  I would happily
> > switch modules and start using ide-cd, but I have a few pieces of
> > software that rely on ide-scsi to work properly and I don't have
> > enough time to change my software to work with ide-cd before my
> > product release deadline.
> >
> > I am working with a mainline kernel, version 2.6.15.7 (I cannot change
> > kernel versions either).  If DMA is enabled and I try to write to a
> > CD, I get a kernel panic.  However, reading from a CD with DMA enabled
> > works fine.  If DMA is disabled and programmed IO is used, I can both
> > read and write CDs but the fact that PIO uses so much of the CPU
> > causes my application to have some problems and again, I don't have
> > time to go through several application release cycles to make them
> > work with PIO.
> >
> > I have noticed that writing to CD (with DMA enabled) in 2.6.9 works
> > fine, it seems as though the breakage of ide-scsi occured in 2.6.10.
> > Also, burning a CD using DMA with ide-scsi in 2.6.19 seems to work as
>
> If it works fine in the current kernels it seems like the problem
> is not kernel bug but the fact that you are stuck on 2.6.15.7.
>
> > well.  I have looked through the ide-scsi code for hours, and I have
> > also done a fair amount of debugging looking for the problem but I
> > have had no success.  I tried contacting Bartlomiej and have been
> > unsuccessful in getting a hold of him.  Does anyone know of a patch
>
> I've just read your mail from Jan 4 (was on TODO).
> [ sorry but ide-scsi problems are (very) low priority ]
>
> > floating around that may fix this problem?  Does anyone that is more
> > familiar with the ide, scsi, or dma subsystems have any suggestions
> > for me?  I am willing to put in the time and effort to fix this
> > problem and I would be more than happy to submit a fix back into the
> > open source world, but I am stuck and need any help I can get.
>
> If you send me the log/photo of the kernel panic I might be able to help you.
>
> Bart
>
