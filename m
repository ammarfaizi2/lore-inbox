Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751740AbWBEMOT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751740AbWBEMOT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Feb 2006 07:14:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751741AbWBEMOT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Feb 2006 07:14:19 -0500
Received: from natipslore.rzone.de ([81.169.145.179]:58273 "EHLO
	natipslore.rzone.de") by vger.kernel.org with ESMTP
	id S1751739AbWBEMOS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Feb 2006 07:14:18 -0500
Subject: Re: amd64 cdrom access locks system
From: Erwin Rol <mailinglists@erwinrol.com>
To: Christer =?ISO-8859-1?Q?B=E4ckstr=F6m?= 
	<cbackstrom@letterboxes.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <43CD8C64.4080909@letterboxes.org>
References: <S1750841AbWAQXWc/20060117232242Z+104@vger.kernel.org>
	 <43CD8C64.4080909@letterboxes.org>
Content-Type: text/plain; charset=utf-8
Date: Sun, 05 Feb 2006 13:14:13 +0100
Message-Id: <1139141653.3319.36.camel@xpc.home.erwinrol.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.90 (2.5.90-1) 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-01-18 at 01:31 +0100, Christer Bäckström wrote:
>  > Aric Cyr <Aric.Cyr () gmail ! com> writes:
> >> > 
> >> >    Jun 14 03:21:50 localhost kernel: ide-cd: cmd 0x3 timed out
> >> >    Jun 14 03:21:50 localhost kernel: hda: lost interrupt
> >> >    Jun 14 03:22:50 localhost kernel: ide-cd: cmd 0x3 timed out
> >> >    Jun 14 03:22:50 localhost kernel: hda: lost interrupt
> >> >    Jun 14 03:23:30 localhost kernel: hda: lost interrupt
> >> 
> >> 
> Exactly the same problems here, on a laptop (Amd64, Mandriva 2006, 
> linux-2.6.15) with an:
> 
> ALi Corporation M5229 IDE (rev c7)
> 
> The cd-writer locks up if the DMA is enabled, as above. But the drive is 
> usable if it is disabled.
> 

I just wanted to add a "me too". I have a Shuttle ST20G5 with a M5229
rev c7:

00:1f.0 IDE interface: ALi Corporation M5229 IDE (rev c7) (prog-if fa)
        Subsystem: Holco Enterprise Co, Ltd/Shuttle Computer Unknown device f391
        Flags: bus master, 66MHz, medium devsel, latency 32, IRQ 185
        I/O ports at 8880 [size=16]

Reading CD's and DVD's always works, but writing or blanking hangs the
drive, with the following entries in the log files;

ide-cd: cmd 0x3 timed out
hda: lost interrupt
hda: request sense failure: status=0x51 { DriveReady SeekComplete Error }
hda: request sense failure: error=0x40 { LastFailedSense=0x04 }
hda: lost interrupt
hda: lost interrupt

The "lost interrupt" message is than repeated endlessly until i reboot,
and every program that tries to access the drive (including reading)
will hang for example:

31527 pts/0    D+     0:00 cat /proc/ide/hda/capacity

This is also on a AMD64, so i don't know maybe it is a AMD64 problem
only.

- Erwin



