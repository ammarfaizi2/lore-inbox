Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263293AbTEMSuk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 14:50:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263320AbTEMSuk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 14:50:40 -0400
Received: from chaos.analogic.com ([204.178.40.224]:13184 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S263293AbTEMSui
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 14:50:38 -0400
Date: Tue, 13 May 2003 15:04:08 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: "H. Peter Anvin" <hpa@zytor.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Use correct x86 reboot vector
In-Reply-To: <b9refc$qmd$1@cesium.transmeta.com>
Message-ID: <Pine.LNX.4.53.0305131501150.2332@chaos>
References: <200305130851_MC3-1-38A3-A3B4@compuserve.com>
 <b9refc$qmd$1@cesium.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 May 2003, H. Peter Anvin wrote:

> Followup to:  <200305130851_MC3-1-38A3-A3B4@compuserve.com>
> By author:    Chuck Ebbert <76306.1226@compuserve.com>
> In newsgroup: linux.dev.kernel
> >
> > Christer Weinigel wrote:
> >
> > > BTW, what does Windows do here?  Whatever Windows is using should work
> > > with Linux too.
> >
> >   I've only ever seen NT4/2K do a warm reboot, if that's relevant.
> >
> >   FreeBSD unmaps every page in the machine and then flushes the
> > TLB as its last-resort reboot attempt.  I assume this causes a
> > triplefault...
> >
>
> So it does.  It's easier, though, to set the limit on the IDTR to zero
> and then trap.
>
> 	-hpa

Don't thing there's anything much easier than:

		movl	$1, %eax
		movl	%eax, %cr0

... execute that in paged RAM (above the 1:1 mapping), and you
will get a hard processor reset without any bus access at all.
This unmaps everything in one fell-swoop.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.20 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.

