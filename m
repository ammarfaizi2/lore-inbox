Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263603AbUFCMad@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263603AbUFCMad (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jun 2004 08:30:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263623AbUFCMad
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jun 2004 08:30:33 -0400
Received: from vsmtp4alice-fr.tin.it ([212.216.176.150]:38813 "EHLO
	vsmtp4.tin.it") by vger.kernel.org with ESMTP id S263603AbUFCMa3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jun 2004 08:30:29 -0400
Subject: Re: 2.6.x partition breakage and dual booting
From: Frediano Ziglio <freddyz77@tin.it>
To: Andries Brouwer <Andries.Brouwer@cwi.nl>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20040603103907.GV23408@apps.cwi.nl>
References: <40BA2213.1090209@pobox.com>
	 <20040530183609.GB5927@pclin040.win.tue.nl> <40BA2E5E.6090603@pobox.com>
	 <20040530200300.GA4681@apps.cwi.nl> <s5g8yf9ljb3.fsf@patl=users.sf.net>
	 <20040531180821.GC5257@louise.pinerecords.com>
	 <1086245495.3988.4.camel@freddy>  <20040603103907.GV23408@apps.cwi.nl>
Content-Type: text/plain
Message-Id: <1086265833.3988.13.camel@freddy>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Thu, 03 Jun 2004 14:30:33 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Il gio, 2004-06-03 alle 12:39, Andries Brouwer ha scritto:
> On Thu, Jun 03, 2004 at 08:51:35AM +0200, Frediano Ziglio wrote:
> 
> > Actually I'm writing two patch:
> >  - extending EDD code to provide DPTE informations and signature for all
> > drives
> >  - modify IDE code to match BIOS disks.
> 
> That second part is undesirable.
> The Linux IDE code is not interested in getting a conjecture about
> how other operating systems would name or number the disks.
> 
> > How to match BIOS with Linux?
> 
> It is impossible. But you can easily do a 95% job.
> 
> > I think it's important to know BIOS point of view. Linux provide these
> > information so we have two choices to solve the problem:
> > - correct the informations we return
> > - do not return anything and let user space programs do the job!
> 
> Yes, leave it to user space. That is what we do today.
> 

Yes and not... HDIO_GETGEO still exists and report inconsistent
informations. IMHO should be removed. I know this breaks some existing
programs however these programs do not actually works correctly.

> > - EDD 2.0. I don't understand why Linux code int 41h/46h and ignore
> > these informations.
> 
> Long ago, long before EDD, disks actually had a geometry, and it was
> necessary to find it in order to do I/O to e.g. MFM disks.
> Today disk geometry is not related to the disk, but to the BIOS.
> The kernel has no need to know it.
> 

EDD 2.0 information consists of
- base port 
- control port
- flags (slave or not)
- others (DMA, etc)
In order to be able (for user space programs) to match these
informations user space programs should be able to read at last base
port of hdX disks.

freddy77


