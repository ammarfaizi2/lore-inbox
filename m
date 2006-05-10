Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965014AbWEJQjY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965014AbWEJQjY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 12:39:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965016AbWEJQjY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 12:39:24 -0400
Received: from py-out-1112.google.com ([64.233.166.180]:11758 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S965014AbWEJQjY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 12:39:24 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=MqmxMzwmcGSYIVaAMspH5NjHFNqK3OQTXJn2yqkpSSx7sSOmYwpGOdgVT7zBGKkFKVRaYoovqOceUYrupHNIFmQdE9Jv+CjBBgMaX4lFa8/V6GJpLmCyMBalORdbT43dR+UJ776HAWMB4gaqJ8QbaM4xcUvpSWy9x0JNRHn5m+U=
Message-ID: <3b0ffc1f0605100939r607ef30dya743a7f1a1dbe03f@mail.gmail.com>
Date: Wed, 10 May 2006 12:39:23 -0400
From: "Kevin Radloff" <radsaq@gmail.com>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Subject: Re: Updated libata PATA patch
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1147279198.19935.6.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1147196676.3172.133.camel@localhost.localdomain>
	 <3b0ffc1f0605091848med1f37ua83c283a922ea682@mail.gmail.com>
	 <1147270145.17886.42.camel@localhost.localdomain>
	 <3b0ffc1f0605100905x18d07f76jda38d1807cf9e9d7@mail.gmail.com>
	 <1147279198.19935.6.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/10/06, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> On Mer, 2006-05-10 at 12:05 -0400, Kevin Radloff wrote:
> > >         ae.irq_flags = SA_SHIRQ ?
> >
> > Another new and exciting oops :)
>
> Yay, so that one was the PCMCIA code being broken.
>
> > pcmcia: registering new device pcmcia1.0
> > ata3: PATA max PIO0 cmd 0x3100 ctl 0x310E bmdma 0x0 irq 11
> > ata3: dev 0 cfg 49:0200 82:0000 83:0000 84:0000 85:0000 86:0000 87:0000 88:0000
> > ata3: dev 0 ATA-10, max PIO4, 2001888 sectors: LBA
> > ata3: dev 0 configured for PIO0
>
> This is all good. Its a PIO0 device (PCMCIA is ISA cycles which are PIO0
> cycles)
>
> > scsi2 : pata_pcmcia
> >   Vendor: ATA       Model: SanDisk SDCFH-10  Rev: HDX
> >   Type:   Direct-Access                      ANSI SCSI revision: 05
> > SCSI device sdb: 2001888 512-byte hdwr sectors (1025 MB)
>
> The disk was found and the indentify data came out correctly.
>
> > sdb: Write Protect is off
> > sdb: Mode Sense: 00 3a 00 00
> > SCSI device sdb: drive cache: write through
> > SCSI device sdb: 2001888 512-byte hdwr sectors (1025 MB)
> > sdb: Write Protect is off
> > sdb: Mode Sense: 00 3a 00 00
> > SCSI device sdb: drive cache: write through
>
> The drive was sized, the cache checked properly.
>
> >  sdb:<1>BUG: unable to handle kernel NULL pointer dereference at
> > virtual address 00000000
>
> Awww.. how to ruin a good day 8)
>
> At this point its trying to read the partition table. It has translated
> the command into a SCSI command block and into ATA,. It has queued it,
> and it has just set out to issue it when it went boom
>
> I'll do some more digging, but putting printks into ata_qc_issue_prot to
> see where it explodes is the next step I suspect.

Ah, I see.. I'll be waiting. :)

--
Kevin 'radsaq' Radloff
radsaq@gmail.com
http://thesaq.com/
