Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261409AbUKSNwR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261409AbUKSNwR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 08:52:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261411AbUKSNwR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 08:52:17 -0500
Received: from havoc.gtf.org ([69.28.190.101]:55731 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S261408AbUKSNwK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 08:52:10 -0500
Date: Fri, 19 Nov 2004 08:48:32 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: "Tomita, Haruo" <haruo.tomita@toshiba.co.jp>,
       Marcelo Tosatti <marcelo@hera.kernel.org>, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org, alan@redhat.com
Subject: Re: linux-2.4.28 released
Message-ID: <20041119134832.GA9552@havoc.gtf.org>
References: <BF571719A4041A478005EF3F08EA6DF05EB481@pcsmail03.pcs.pc.ome.toshiba.co.jp> <20041118111235.GA26216@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041118111235.GA26216@logos.cnet>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 18, 2004 at 09:12:36AM -0200, Marcelo Tosatti wrote:
> On Thu, Nov 18, 2004 at 06:50:03PM +0900, Tomita, Haruo wrote:
> > Hi,
> > 
> > It seems that combined mode does not work at linux-2.4.28 about
> > the ata_piix driver of the Intel 82801EB/82801ER SATA controller
> > of Intel 82801EB/82801ER. In using combined mode, 
> > I think that the following patches are required. Is this right?
> 
> Yes, I think so? Jeff is the man.
> 
> I dislike the ____request_resource() hack, it has been rejected and 
> Jeff agreed with me here.

The reason ____request_resource() is used for combined mode is to
facilitate libata taking one PCI device, and IDE driver taking another
PCI device.  This is done because libata did not support PATA, and so,
could not drive the PATA controller.

Now PATA and ATAPI are working, so we could present the IMO ideal
situation:  libata can support combined mode best by supporting both
PATA and SATA controllers, on the ICH5.  That way DMA works for both
PATA and SATA (DMA doesn't work for PATA, in split-driver configuration),
and there is no split-driver to worry about.

I think there may need to be some code to prevent the IDE driver from
claiming the legacy ISA ports.

	Jeff



