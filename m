Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263201AbTFGPaJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jun 2003 11:30:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263202AbTFGPaJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jun 2003 11:30:09 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:32212 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S263201AbTFGPaG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jun 2003 11:30:06 -0400
Date: Sat, 7 Jun 2003 17:43:15 +0200 (MET DST)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Paul Mackerras <paulus@samba.org>
cc: <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Move BUG/BUG_ON/WARN_ON to asm headers
In-Reply-To: <16097.56616.35782.882995@argo.ozlabs.ibm.com>
Message-ID: <Pine.SOL.4.30.0306071738580.28622-100000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Paul,

What about adding asm-generic/bug.h ?
--
Bartlomiej

On Sat, 7 Jun 2003, Paul Mackerras wrote:

> Linus,
>
> This patch moves the definitions of BUG, BUG_ON and WARN_ON from
> <linux/kernel.h> to <asm/bug.h> (which <linux/kernel.h> includes), and
> supplies a new implementation for PPC which uses a conditional trap
> instruction for BUG_ON and WARN_ON, thus avoiding a conditional
> branch.  This patch trims over 50kB from the size of the kernel that I
> use on powermacs.
>
> With this patch, on PPC we have a __bug_table section in the vmlinux
> binary, and also in modules if they use BUG, BUG_ON or WARN_ON.  The
> __bug_table section has one entry for each BUG/BUG_ON/WARN_ON, giving
> the address of the trap instruction and the corresponding line number,
> filename and function name.  This information is used in the exception
> handler for the exception that the trap instruction produces.  The
> arch-specific module code handles the __bug_table section so that
> BUG/BUG_ON/WARN_ON work correctly in modules.
>
> Several architecture maintainers have acked this change.  It should be
> completely benign for all of the other architectures (though they may
> decide to do something similar if they have a conditional trap
> instruction available).
>
> Please apply.
>
> Thanks,
> Paul.


