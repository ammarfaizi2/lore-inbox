Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965089AbWJBQpx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965089AbWJBQpx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 12:45:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965090AbWJBQpw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 12:45:52 -0400
Received: from mga03.intel.com ([143.182.124.21]:48 "EHLO mga03.intel.com")
	by vger.kernel.org with ESMTP id S965089AbWJBQpw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 12:45:52 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,245,1157353200"; 
   d="scan'208"; a="125841801:sNHT570791221"
Date: Mon, 2 Oct 2006 09:45:18 -0700
From: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
To: Andrey Borzenkov <arvidjaar@mail.ru>
Cc: linux-kernel@vger.kernel.org, jgarzik@pobox.com
Subject: Re: [patch 1/2] libata: _GTF support
Message-Id: <20061002094518.4ba56020.kristen.c.accardi@intel.com>
In-Reply-To: <20061001170216.34F3F54C4EC@chen.mtu.ru>
References: <20060928182211.076258000@localhost.localdomain>
	<20060928112901.62ee8eba.kristen.c.accardi@intel.com>
	<20061001170216.34F3F54C4EC@chen.mtu.ru>
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.8.20; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 01 Oct 2006 21:02:21 +0400
Andrey Borzenkov <arvidjaar@mail.ru> wrote:

> Kristen Carlson Accardi wrote:
> 
> > _GTF is an acpi method that is used to reinitialize the drive.  It returns
> > a task file containing ata commands that are sent back to the drive to
> > restore it to boot up defaults.
> > 
> [...]
> > @@ -1597,6 +1601,9 @@ int ata_bus_probe(struct ata_port *ap)
> >  /* reset and determine device classes */
> >  ap->ops->phy_reset(ap);
> >  
> > +     /* retrieve and execute the ATA task file of _GTF */
> > +     ata_acpi_exec_tfs(ap);
> > +
> >  for (i = 0; i < ATA_MAX_DEVICES; i++) {
> >  dev = &ap->device[i];
> >
> 
> ata_bus_probe() seems to be called only if driver does not provide own error
> handler? Also would GTF be executed on resume? I hoped it may fix resume
> from RAM problem I have but it looks like this is never executed in my case
> (pata_ali).
> 
> TIA
> 
> -andrey

Hi Andrey
On Friday I submitted another patch which changes where this is executed.
http://marc.theaimsgroup.com/?l=linux-ide&m=115957671114738&w=2

Hopefully this will work better for you.

Kristen
