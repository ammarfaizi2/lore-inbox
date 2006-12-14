Return-Path: <linux-kernel-owner+w=401wt.eu-S1750795AbWLNTyf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750795AbWLNTyf (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 14:54:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750959AbWLNTyf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 14:54:35 -0500
Received: from mx1.redhat.com ([66.187.233.31]:51376 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750795AbWLNTye (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 14:54:34 -0500
Date: Thu, 14 Dec 2006 14:53:14 -0500
From: Bill Nottingham <notting@redhat.com>
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
Cc: Alan <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: libata-pata with ICH4, rootfs
Message-ID: <20061214195314.GC10955@nostromo.devel.redhat.com>
Mail-Followup-To: Alistair John Strachan <s0348365@sms.ed.ac.uk>,
	Alan <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
References: <200612141714.55948.s0348365@sms.ed.ac.uk> <20061214182010.477073a9@localhost.localdomain> <200612141832.50587.s0348365@sms.ed.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200612141832.50587.s0348365@sms.ed.ac.uk>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alistair John Strachan (s0348365@sms.ed.ac.uk) said: 
> > > Is it possible to use pata_mpiix (or pata_oldpiix) with an ICH4 IDE
> > > controller and boot off it?
> >
> > ata_piix (the SATA/PATA driver) deals with the ICH4. pata_mpiix is
> > specifically for the Intel MPIIX laptop chipset and pata_oldpiix
> > explicitly for the original PIIX chipset and none of the later ones.
> 
> Correct me if I'm wrong, but SATA wasn't available on ICH4. Only 5 and 
> greater. The kernel help text agrees with me.
> 
> My IDE controller usually works with CONFIG_BLK_DEV_PIIX; I was interested in 
> using your pata_xxx drivers in replacement, assuming there was support.

pata_xxx is for older PIIX, not ICH4. ICH* is handled by ata_piix, which
can drive both SATA *and* PATA in the new kernels. In fact:

[notting@nostromo: ~]$ lspci | grep IDE
00:1f.1 IDE interface: Intel Corporation 82801DBM (ICH4-M) IDE Controller (rev 01)
[notting@nostromo: ~]$ dmesg | grep ata
...
ata_piix 0000:00:1f.1: version 2.00ac6
ata1: PATA max UDMA/100 cmd 0x1F0 ctl 0x3F6 bmdma 0x1860 irq 14
ata2: PATA max UDMA/100 cmd 0x170 ctl 0x376 bmdma 0x1868 irq 15
...
[notting@nostromo: ~]$ uname -r
2.6.19-1.2839.fc7

Bill
