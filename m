Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263544AbTKXAal (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Nov 2003 19:30:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263545AbTKXAak
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Nov 2003 19:30:40 -0500
Received: from intra.cyclades.com ([64.186.161.6]:4284 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S263544AbTKXAag
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Nov 2003 19:30:36 -0500
Date: Sun, 23 Nov 2003 22:22:26 -0200 (BRST)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
X-X-Sender: marcelo@logos.cnet
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Arkadiusz Miskiewicz <arekm@pld-linux.org>, Alan Cox <alan@redhat.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: modular IDE in 2.4.23
In-Reply-To: <200311232123.06635.bzolnier@elka.pw.edu.pl>
Message-ID: <Pine.LNX.4.44.0311232221080.1292-100000@logos.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 23 Nov 2003, Bartlomiej Zolnierkiewicz wrote:

> 
> On Sunday 23 of November 2003 18:08, Marcelo Tosatti wrote:
> > On Sun, 23 Nov 2003, Arkadiusz Miskiewicz wrote:
> > > On Sunday 23 of November 2003 01:54, Arkadiusz Miskiewicz wrote:
> > > > Could you give more specific hints how to fix ,,other stuff''?
> > >
> > > Did this in not the right way probably but it works fine for me (just
> > > modular ide tested):
> > >
> > > http://cvs.pld-linux.org/cgi-bin/cvsweb/SOURCES/linux-2.4.23-modular-ide.
> > >patch?rev=1.9
> > >
> > > [misiek@arm ~]$ lsmod | grep ide
> > > ide-scsi                9904   0
> > > scsi_mod               93888   2 [sg ide-scsi]
> > > ide-cd                 30944   0
> > > cdrom                  29248   0 [ide-cd]
> > > ide-disk               16076  13
> > > ide-core              104504  13 [ide-scsi ide-cd ide-disk pdc202xx_new
> > > via82cxxx]
> > >
> > > Thanks for hint (now only cmd640 isse left for me).
> > >
> > > > > Alan
> >
> > Arkadiusz,
> 
> Unfortunately this patch is not sufficient.
> 
> > I agree with you that modular IDE (I dont care that much about the
> > cmd640 really) should work on 2.4.23.
> 
> Some people want cmd640 fixes in 2.4.23, really!
> 
> > I dont think the "ide-probe-mini" is required though. Just calling
> > the ide-probe.o init functions from IDE init should work right?
> 
> "ide-probe-mini" is not required and just calling init functions from IDE init
> won't work (will break modular chipsets).
> 
> > Does the attached patch work for you (it moves ide-probe into ide-core,
> > as Alan mentioned) ?
> 
> It will break drives probing for all modular chipset drivers.
> 
> Uh. Oh. 2.4.23 IDE changes are obscure...  Modular IDE breakage is caused by
> Alan's hotplug changes and is not easy to fix properly.
> 
> I would like to have these changes removed:
> (a) they break modular IDE
> (b) such changes should be first added to 2.6 and then backported to 2.4
>    (otherwise you are magically creating regression in 2.6)
> (c) they are ugly and will cause much maintaining headache
>    (and it seems it won't be Alan who will suffer ;))
> 
> Anyway it is up to you :-).

Hum I think the saner approach is to remove the hotplugging indeed.

Mind writting me a patch Bart? :) 


