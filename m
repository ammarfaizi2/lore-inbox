Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264013AbUDFU5K (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 16:57:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264016AbUDFU5J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 16:57:09 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:45029 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S264008AbUDFUyB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 16:54:01 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: "John Stoffel" <stoffel@lucent.com>
Subject: Re: 2.6.5-rc3: cat /proc/ide/hpt366 kills disk on second channel
Date: Tue, 6 Apr 2004 23:02:17 +0200
User-Agent: KMail/1.5.3
Cc: linux-kernel@vger.kernel.org, andre@linux-ide.org
References: <16496.41345.341470.807320@gargle.gargle.HOWL> <200404061900.36497.bzolnier@elka.pw.edu.pl> <16499.3204.604627.205193@gargle.gargle.HOWL>
In-Reply-To: <16499.3204.604627.205193@gargle.gargle.HOWL>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200404062302.17698.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 06 of April 2004 22:01, John Stoffel wrote:
> Bart,
>
> You're patch does the trick, I can now do cat /proc/ide/hpt366 without
> any problems.  Time to re-sync my md mirror.
>
> I'll also pull this patch forward to 2.6.5 and make sure to submit it
> to Linus/Andrew, unless you'll do that part?

I'll take care of it. :)

> I do wish the cable detection stuff worked though... too bad about the

Cable detection works just fine, see init_hwif_hpt366().

> outb() stuff.  Maybe I can poke at it and figure out what kind of
> locking is required here to make this work right.  Would it need to be
> queued up as a regular HWIF command?  Can you tell I don't know what
> I'm talking about?  *grin*

regular HWIF command?  It can be fixed using REQ_SPECIAL special request
but I don't think it's worth the work - remove #ifdef/#endif DEBUG around
printk() in init_hwif_hpt366() if you need info about cable.

Thanks,
Bartlomiej

