Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268051AbTBMOAo>; Thu, 13 Feb 2003 09:00:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268052AbTBMOAo>; Thu, 13 Feb 2003 09:00:44 -0500
Received: from host194.steeleye.com ([66.206.164.34]:64526 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S268051AbTBMOAn>; Thu, 13 Feb 2003 09:00:43 -0500
Subject: Re: [PATCH] fix scsi/aha15*.c for 2.5.60
From: James Bottomley <James.Bottomley@steeleye.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: rudmer@legolas.dynup.net, "Randy.Dunlap" <randy.dunlap@verizon.net>,
       Mike Anderson <andmike@us.ibm.com>, linux-kernel@vger.kernel.org,
       fischer@norbit.de, Tommy.Thorn@irisa.fr
In-Reply-To: <20030212233121.A20476@infradead.org>
References: <3E49DC38.52D278C4@verizon.net> <200302122246.19225@gandalf>
	<1045089866.1763.3.camel@mulgrave>  <20030212233121.A20476@infradead.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 13 Feb 2003 09:10:24 -0500
Message-Id: <1045145427.2053.48.camel@mulgrave>
Mime-Version: 1.0
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-02-12 at 18:31, Christoph Hellwig wrote:
> On Wed, Feb 12, 2003 at 05:44:24PM -0500, James Bottomley wrote:
> > > this gives these modules in /lib/modules/2.5.60/kernel/drivers/scsi/:
> > > aha152x.ko  scsi_mod.ko  sg.ko
> > > 
> > > what am i missing??
> > 
> > Nothing really, the symbols need to be exported from the SCSI core. 
> > I'll add them to the export list.
> 
> it should _not_ be exported.  drivers are supposed to use the
> request-based interface instead.

Yes, if they issue commands via the mid-layer.  This one is queueing a
message (encapsulated as a pseudo command) on it's internal queue (which
is a cmd queue) to issue a bus device reset.  In this instance, it
cannot use the request based interface because the device will be
in_recovery when this happens, so it would never be issued.

Personally, it would be nice to have a messaging interface to get around
these problems, but I don't think that one's coming any time soon...

James


