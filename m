Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266158AbUA1U6g (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jan 2004 15:58:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266160AbUA1U6g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jan 2004 15:58:36 -0500
Received: from jurassic.park.msu.ru ([195.208.223.243]:14085 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id S266158AbUA1U6e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jan 2004 15:58:34 -0500
Date: Wed, 28 Jan 2004 23:58:15 +0300
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Greg KH <greg@kroah.com>
Cc: Andrew Morton <akpm@osdl.org>, moilanen@austin.ibm.com,
       johnrose@austin.ibm.com, linux-kernel@vger.kernel.org,
       torvalds@osdl.org, Anton Blanchard <anton@samba.org>
Subject: Re: [PATCH][2.6] PCI Scan all functions
Message-ID: <20040128235815.A8539@den.park.msu.ru>
References: <1075222501.1030.45.camel@magik> <20040127211253.GA27583@kroah.com> <20040127133314.0ddf00cd.akpm@osdl.org> <20040127214444.GA27874@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20040127214444.GA27874@kroah.com>; from greg@kroah.com on Tue, Jan 27, 2004 at 01:44:44PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 27, 2004 at 01:44:44PM -0800, Greg KH wrote:
> > -	if (base && base <= limit) {
> > +	if (base <= limit) {

I think the patch is safe. Architectures that don't accept
bridge windows (and regular BARs) at bus address 0 already have
that check elsewhere.
For example, in arch/i386/pci/i386.c:pcibios_allocate_bus_resources():
...
			for (idx = PCI_BRIDGE_RESOURCES; idx < PCI_NUM_RESOURCES; idx++) {
				r = &dev->resource[idx];
				if (!r->start)
				    ^^^^^^^^^
					continue;
...

Ivan.
