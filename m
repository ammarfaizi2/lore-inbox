Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264058AbTE0TY1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 15:24:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264059AbTE0TY1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 15:24:27 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:4041 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S264058AbTE0TYX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 15:24:23 -0400
Date: Tue, 27 May 2003 12:37:42 -0700
From: Andrew Morton <akpm@digeo.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: jgarzik@pobox.com, zwane@linuxpower.ca, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] xirc2ps_cs irq return fix
Message-Id: <20030527123742.0ab46471.akpm@digeo.com>
In-Reply-To: <1054032047.18160.19.camel@dhcp22.swansea.linux.org.uk>
References: <200305252318.h4PNIPX4026812@hera.kernel.org>
	<3ED16351.7060904@pobox.com>
	<Pine.LNX.4.50.0305252051570.28320-100000@montezuma.mastecende.com>
	<1053992128.17129.15.camel@dhcp22.swansea.linux.org.uk>
	<3ED2E03E.80004@pobox.com>
	<20030526205548.4853c92b.akpm@digeo.com>
	<1054028411.18165.5.camel@dhcp22.swansea.linux.org.uk>
	<20030527034548.4aaae353.akpm@digeo.com>
	<1054032047.18160.19.camel@dhcp22.swansea.linux.org.uk>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 27 May 2003 19:37:37.0280 (UTC) FILETIME=[6D801000:01C32487]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
>
> On Maw, 2003-05-27 at 11:45, Andrew Morton wrote:
> > The below patch has been in -mm for some time.  It was supposed to kill the
> > IRQ if 750 of the previous 1000 IRQs weren't handled.
> > 
> > I disabled the killing code because it was triggering on someone's
> > works-just-fine setup.
> > 
> > There will be pain involved in getting all this to work right.  Do you
> > really think there's much value in it?
> 
> Being able to at least turn it on at run time is valuable when you are debugging
> a box operated by someone who doesnt habitually rebuild kernels. The 750 of 1000
> thing doesnt work because it can happen to be timing triggered by blocks of IRQ's
> from a chip being folded together. The "million in a row" should be a stuck IRQ,
> maybe 50,000 in a row even but just "zillions in a row"
> 

The problem with zillions-in-a-row is that the babbling device could be
sharing the IRQ with a non-babbling device.  So the legitimate interrupts
from the non-babbler will cause the detection state machine to reset
itself.  It will never go off, and the box remains locked up.

Maybe the 750/1000 should be 100/100,000.  Who knows...

