Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751877AbWEPQu7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751877AbWEPQu7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 12:50:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751876AbWEPQu7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 12:50:59 -0400
Received: from mailfe01.swip.net ([212.247.154.1]:55689 "EHLO swip.net")
	by vger.kernel.org with ESMTP id S1751873AbWEPQu6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 12:50:58 -0400
X-T2-Posting-ID: 6GBUGr3zkYYCG9T7x2Ik0yQrRuFhZLxyP+8apJj5Sjg=
X-Cloudmark-Score: 0.000000 []
From: "Leopold Gouverneur" <lgouv@tele2.be>
Date: Tue, 16 May 2006 18:50:54 +0200
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-rc4-mm1 panic on boot
Message-ID: <20060516165054.GA8192@localhost>
References: <20060516001501.GA7528@localhost> <e4c3fi$utm$1@terminus.zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e4c3fi$utm$1@terminus.zytor.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 16, 2006 at 01:45:38AM -0700, H. Peter Anvin wrote:
> Followup to:  <20060516001501.GA7528@localhost>
> By author:    lgouv@tele2.be
> In newsgroup: linux.dev.kernel
> >
> > Just upgraded from rc3-mm4.
> > Panic on boot with this message (copied by hand ):
> > 	kinit:do_mount
> > 	kinit: name_to_dev_t(/dev/hda8) = dev (0,0)
> > 	kinit:rot_dev = dev (0,0)
> > 	kinit root_dev = dev (0,0)
> > 	kinit trying to mount /dev/root on /root
> > 	...........
> > /dev/hda8 is my root partition but I suppose dev (0,0) is the first
> > partition on hda which is FAT.
> > I tried vanilla rc4 with the same result.
> > 
> 
> This means kinit couldn't find a name-to-number mapping for the string
> /dev/hda8.  However, you said you tried vanilla rc4 with the same
> result, and vanilla rc4 doesn't use klibc.
Sorry for my silliness, actually rc4 boot OK
> 
> This means hda8 simply isn't discovered on your system, which probably
> means hda isn't discovered.  This typically is an issue with your
> kernel configuration, but it's not always.
yes that was my problem: rc4-mm1 need CONFIG_SCSI_PATA_AMD=y
which -rc4 don't for my nForce2 ide controller.

many thankx
