Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264184AbUEDBTl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264184AbUEDBTl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 May 2004 21:19:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264188AbUEDBTl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 May 2004 21:19:41 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:53142 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S264184AbUEDBTh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 May 2004 21:19:37 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: "J. Ryan Earl" <heretic@clanhk.org>
Subject: Re: Booting off of IDE while using different libata drives on same southbridge
Date: Tue, 4 May 2004 03:21:02 +0200
User-Agent: KMail/1.5.3
References: <200403121826.21442.markus.kossmann@inka.de> <200405032344.58597.bzolnier@elka.pw.edu.pl> <4096EA32.10201@clanhk.org>
In-Reply-To: <4096EA32.10201@clanhk.org>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200405040321.03110.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 04 of May 2004 02:56, you wrote:
> Bartlomiej Zolnierkiewicz wrote:
> >On Monday 03 of May 2004 23:19, J. Ryan Earl wrote:
> >>I am having a similar problem to what Markus Kossmann wrote about, but
> >>with the VIA Southbridge (Asus K8V).  My situation is similar, but a
> >>little different.  I would like to boot off a PATA drive attached to the
> >>Southbridge, but use libata for a couple SATA drives attached to the
> >>same Southbridge.
> >>
> >>Is this still not possible?  I also tried hde/hdg=noprobe options, but
> >>they didn't help the situation.  It appears the only way to get the
> >>drives on sata_via is to boot off of them.  Am I correct in thinking
> >>this is the only way to go about this?
> >
> >Did you actually tried it (booting off of them)?
> >[ I can't see how this can help. ]
>
> With libata linked into the kernel, and ide as a module, I can boot off
> of libata.

Therefore you changed order in which these drivers are initialized,
it has nothing to do with booting off of SATA drives.

> >Just don't compile-in generic IDE PCI driver which controls your SATA
> > drives (or don't load this module if you're using initrd).
>
> As I said, I want to boot off of the PATA drives attached to the
> southbridge.  To boot of them, I have to have the IDE driver compiled
> into the kernel; if I do this I can't use libata on that southbridge,
> the IDE driver take precedence for the serial ata channels.

Just don't compile generic IDE PCI driver!!
CONFIG_BLK_DEV_GENERIC=n

VIA PATA controller uses via82cxxx driver not generic IDE PCI one.

> -ryan

