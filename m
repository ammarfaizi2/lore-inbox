Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263591AbTFDRK2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jun 2003 13:10:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263658AbTFDRK1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jun 2003 13:10:27 -0400
Received: from dsl093-098-016.wdc1.dsl.speakeasy.net ([66.93.98.16]:13954 "EHLO
	defaultvalue.org") by vger.kernel.org with ESMTP id S263591AbTFDRK0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jun 2003 13:10:26 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: siimage driver status
From: Rob Browning <rlb@defaultvalue.org>
Date: Wed, 04 Jun 2003 12:23:54 -0500
Message-ID: <874r3521ud.fsf@raven.i.defaultvalue.org>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Alan Cox (alan@lxorguk.ukuu.org.uk) writes:
> On Iau, 2003-05-29 at 15:32, Wm. Josiah Erikson wrote:
> > hard drives that I'm trying to get to work with linux 2.4.21-rc6. The
> > problem I'm having is that it's REALLY slow and crashy. The kernel reports
> > this on bootup:
>
> I'm running the siimage driver fine with several drives. Your setup
> is intriguing in that the BIOS has chosen to leave the drives in PIO
> mode

As an extra datapoint I have very a very similar problem with a WD360
drive and an siimage 3112 PCI controller on a shuttle (via-based)
AK31V2.0 motherboard.

The sii3112 interfaces show up as ide0 and ide1 (can that be changed?)
using MMIO-DMA/pio.  Testing the drive as-is results in ~3.5MB/s
transfer rates (via hdparm -t), and attempting to enable DMA via
"hdparm -d 1" results in an immediate lockup the next time the drive
is accessed.

When I get another chance, I'll probably try the two fixes others in
this thread have suggested:

  hdparm -X66 -d1 /dev/hda

and if that still has trouble under load, someone suggested:

  echo "max_kb_per_request:15" > /proc/ide/hda/settings

Hope this helps.

(I'm not on the list right now, so please cc any replies you want to
 make sure I see -- thanks.)

-- 
Rob Browning
rlb @defaultvalue.org and @debian.org; previously @cs.utexas.edu
GPG starting 2002-11-03 = 14DD 432F AE39 534D B592  F9A0 25C8 D377 8C7E 73A4
