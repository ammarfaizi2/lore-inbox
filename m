Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266595AbUHTM0R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266595AbUHTM0R (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 08:26:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266689AbUHTM0R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 08:26:17 -0400
Received: from the-village.bc.nu ([81.2.110.252]:33415 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S266595AbUHTMYg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 08:24:36 -0400
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Mark Lord <lkml@rtr.ca>, Frank Steiner <fsteiner-mail@bio.ifi.lmu.de>,
       Joerg Schilling <schilling@fokus.fraunhofer.de>,
       kernel@wildsau.enemy.org, diablod3@gmail.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200408200057.55050.bzolnier@elka.pw.edu.pl>
References: <200408041233.i74CX93f009939@wildsau.enemy.org>
	 <1092938773.28350.27.camel@localhost.localdomain> <4124FD46.8040109@rtr.ca>
	 <200408200057.55050.bzolnier@elka.pw.edu.pl>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1093000925.30941.18.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 20 Aug 2004 12:22:14 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2004-08-19 at 23:57, Bartlomiej Zolnierkiewicz wrote:
> Alan's example is invalid because IDE driver requires CAP_SYS_ADMIN and 
> CAP_SYS_RAWIO so if there is some security risk involved - it is in the user 
> apps not in the kernel.  Also Linus first fixed SG_IO correctly with 
> requiring CAP_SYS_RAWIO but then (under Alan's influence?) he added filtering 
> which broke cd writing and which is just unmaintainable.

SG_IO prior to 2.6.8 doesn't do any checks on any path into and through
the IDE driver. Thus I sent Linus a patch for 2.6.8 that just added
capable(CAP_SYS_RAWIO) to the raw command path.

Filtering was something Jens and I were talking about. I was a little
suprised when Linus added filters just before release. We do now have
good traces of what various apps want. Some of those commands may be
problematic without sg_io knowing the target class however.

> Also filtering cannot work in all cases because there are vendor specific 
> opcodes, some devices redefines some opcodes etc. - this should be left to 
> user space.

Possibly. Vendor commands are not in themselves a problems. The answer
to those is "no" 8)

