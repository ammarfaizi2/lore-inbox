Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262002AbTJFHDZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Oct 2003 03:03:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262192AbTJFHDZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Oct 2003 03:03:25 -0400
Received: from codepoet.org ([166.70.99.138]:43166 "EHLO mail.codepoet.org")
	by vger.kernel.org with ESMTP id S262002AbTJFHDX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Oct 2003 03:03:23 -0400
Date: Mon, 6 Oct 2003 01:03:24 -0600
From: Erik Andersen <andersen@codepoet.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Philippe Lochon <plochon.n0spam@free.fr>, linux-kernel@vger.kernel.org
Subject: Re: P4C800E-Dlx: ICH5/S-ATA and Intel Pro onboard network incompatibility ?
Message-ID: <20031006070324.GA10474@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	Jeff Garzik <jgarzik@pobox.com>,
	Philippe Lochon <plochon.n0spam@free.fr>,
	linux-kernel@vger.kernel.org
References: <3F7EDCDD.7090500@free.fr> <20031004180338.GA24607@codepoet.org> <20031004192733.GA30371@gtf.org> <20031004195342.GA25328@codepoet.org> <20031005201638.GB4259@codepoet.org> <3F80B68D.8090109@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F80B68D.8090109@pobox.com>
X-Operating-System: Linux 2.4.19-rmk7, Rebel-NetWinder(Intel StrongARM 110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun Oct 05, 2003 at 08:25:49PM -0400, Jeff Garzik wrote:
> Erik Andersen wrote:
> >When I have the Bios set to compatible mode everything works --
> >except for the obvious problem that I have to put my SATA drive
> >onto my promise SATA card (since the ICH5 SATA is disabled).
> >
> >When I have the Bios set to Enhanced mode (so the ICH5 provides
> >both SATA and PATA) then my system will wedge solid as a rock.
> >
> >It turns out it was locking up while loading up the ide-scsi
> >kernel module.  I have
> >
> >    options ide-cd ignore='hdc'
> 
> 
> So, things work in Enchanced mode if ide-scsi module is not loaded?

After a bit more testing....  loading either ide-scsi or
ide-cd is sufficient to lock my system dead dead dead if
the bios is set to Enhanced mode.

After _not_ loading ide-scsi or ide-cd I was able to boot in
Enhanced mode.  I think I am getting some sortof wierd interrupt
storm.  Everything freezes for a few second every so often...
Here is what I am seeing.  

$ uptime
 00:51:41 up 25 min,  3 users,  load average: 0.04, 0.10, 0.07
$ cat /proc/interrupts 
           CPU0       CPU1       
  0:     152450          0    IO-APIC-edge  timer
  1:       5334          0    IO-APIC-edge  keyboard
  2:          0          0          XT-PIC  cascade
  8:          4          0    IO-APIC-edge  rtc
  9:          0          0   IO-APIC-level  acpi
 12:      36125          0    IO-APIC-edge  PS/2 Mouse
 16:     105720          0   IO-APIC-level  usb-uhci, usb-uhci, radeon@PCI:1:0:0
 17:          0          0   IO-APIC-level  Intel ICH5
 18:  175250680       2019   IO-APIC-level  ide0, ide1, libata, usb-uhci
 19:          0          0   IO-APIC-level  usb-uhci
 22:      90380          0   IO-APIC-level  SysKonnect SK-98xx, bttv
 23:          0          0   IO-APIC-level  ehci_hcd
NMI:          0          0 
LOC:     156771     156777 
ERR:          0
MIS:       2019

I have a P4 with hyperthreading so my kernel is SMP.  The huge
number of interrupts on 18 (I'm not doing very much beyong ssh to
another box to write this email) looks suspicious to me.

> And, drivers/ide is picking up your PATA devices as expected?

yes.

> As a tangent, I wonder if the latest cdrecord works in 2.4 with 
> 'dev=/dev/hdc' ... that would elimiante the need for ide-scsi.

I'll check...

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
