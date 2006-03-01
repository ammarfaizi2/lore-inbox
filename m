Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932386AbWCAPnQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932386AbWCAPnQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 10:43:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932393AbWCAPnQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 10:43:16 -0500
Received: from 209-166-240-202.cust.walrus.com ([209.166.240.202]:45760 "EHLO
	mail1.telemetry-investments.com") by vger.kernel.org with ESMTP
	id S932386AbWCAPnP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 10:43:15 -0500
Date: Wed, 1 Mar 2006 10:43:13 -0500
From: "Bill Rugolsky Jr." <brugolsky@telemetry-investments.com>
To: Andi Kleen <ak@suse.de>
Cc: Jason Baron <jbaron@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: AMD64 X2 lost ticks on PM timer
Message-ID: <20060301154313.GC20092@ti64.telemetry-investments.com>
Mail-Followup-To: "Bill Rugolsky Jr." <brugolsky@telemetry-investments.com>,
	Andi Kleen <ak@suse.de>, Jason Baron <jbaron@redhat.com>,
	linux-kernel@vger.kernel.org
References: <200602280022.40769.darkray@ic3man.com> <p73veuzyr8p.fsf@verdi.suse.de> <20060301144641.GB20092@ti64.telemetry-investments.com> <200603011556.10139.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200603011556.10139.ak@suse.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 01, 2006 at 03:56:09PM +0100, Andi Kleen wrote:
> > Thanks for the interest, Andi.
> >  
> > The chipset is NVIDIA nForce Pro 2200 (CK804).  The mobo is Tyan 2895:
> 
> I have such a system sitting next to me and it doesn't show any such symptoms.
> I normally don't let it run unrebooted over days though.

These lost ticks are reproducable in a few minutes with cpio.

> I would suspect some driver.
> Do you use any special addin cards? What modules are you using?

My guess is the sata_nv driver, as it happens during heavy local file read.
The machines all have 2-4 SATA WD Raptors connected to the mobo.

> I don't run these kernels though - only mainline.
 
I wouldn't expect you to be running a Fedora kernel. :-p
I usually roll my own, but I've been really backed up with other tasks.

As I said, I'll build some mainline kernels.  I want to apply
some of Ingo's debugging patches and give John Stultz's new timekeeping
code a try anyway.

rugolsky@ti94: cat /proc/interrupts 
           CPU0       CPU1       
  0:      28474     577049    IO-APIC-edge  timer
  1:          8          0    IO-APIC-edge  i8042
  7:          2          0    IO-APIC-edge  parport0
  8:         40          0    IO-APIC-edge  rtc
  9:          0          0   IO-APIC-level  acpi
 14:         36      21506    IO-APIC-edge  ide0
 50:          3          0   IO-APIC-level  ohci1394
201:          0          0   IO-APIC-level  libata, ehci_hcd:usb1
209:       1876      15495   IO-APIC-level  libata, ohci_hcd:usb2
217:    2483567          0   IO-APIC-level  eth0
233:          0          0   IO-APIC-level  NVidia CK804
NMI:         87         41 
LOC:     605510     605486 
ERR:          0
MIS:          0

Lots-o-modules; I'll have to whittle these down.

rugolsky@ti94: lsmod
Module                  Size  Used by
parport_pc             65581  1 
lp                     49025  0 
parport                77261  2 parport_pc,lp
nfs                   275745  4 
lockd                 107601  2 nfs
nfs_acl                37185  1 nfs
sunrpc                210041  4 nfs,lockd,nfs_acl
8021q                  57041  0 
video                  52553  0 
button                 41185  0 
battery                44233  0 
ac                     38985  0 
ohci1394               71457  0 
ieee1394              407641  1 ohci1394
ohci_hcd               57565  0 
ehci_hcd               70477  0 
i2c_nforce2            41409  0 
i2c_core               59457  1 i2c_nforce2
snd_intel8x0           70889  0 
snd_ac97_codec        146045  1 snd_intel8x0
snd_ac97_bus           36033  1 snd_ac97_codec
snd_seq_dummy          37445  0 
snd_seq_oss            71973  0 
snd_seq_midi_event     42177  1 snd_seq_oss
snd_seq                99225  5 snd_seq_dummy,snd_seq_oss,snd_seq_midi_event
snd_seq_device         43857  3 snd_seq_dummy,snd_seq_oss,snd_seq
snd_pcm_oss            93297  0 
snd_mixer_oss          52673  1 snd_pcm_oss
snd_pcm               139593  3 snd_intel8x0,snd_ac97_codec,snd_pcm_oss
snd_timer              62025  2 snd_seq,snd_pcm
snd                   103073  9 snd_intel8x0,snd_ac97_codec,snd_seq_oss,snd_seq,
snd_seq_device,snd_pcm_oss,snd_mixer_oss,snd_pcm,snd_timer
soundcore              45025  1 snd
snd_page_alloc         46289  2 snd_intel8x0,snd_pcm
forcedeth              60869  0 
floppy                107993  0 
ext3                  179665  5 
jbd                   100073  1 ext3
raid1                  56385  4 
dm_mod                 98697  4 
sata_nv                44101  8 
libata                 98265  1 sata_nv
sd_mod                 53697  10 
scsi_mod              195321  2 libata,sd_mod

Thanks.

	-Bill
