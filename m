Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262484AbVGGAXe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262484AbVGGAXe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 20:23:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262337AbVGFUAX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 16:00:23 -0400
Received: from ns2.suse.de ([195.135.220.15]:21970 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S262375AbVGFQpk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 12:45:40 -0400
Date: Wed, 6 Jul 2005 18:45:34 +0200
From: Andi Kleen <ak@suse.de>
To: Christoph Lameter <christoph@lameter.com>
Cc: Andi Kleen <ak@suse.de>, linux-ide@vger.kernel.org, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix crash on boot in kmalloc_node IDE changes
Message-ID: <20050706164533.GK21330@wotan.suse.de>
References: <20050706133052.GF21330@wotan.suse.de> <Pine.LNX.4.62.0507060933330.20107@graphe.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0507060933330.20107@graphe.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 06, 2005 at 09:34:28AM -0700, Christoph Lameter wrote:
> On Wed, 6 Jul 2005, Andi Kleen wrote:
> 
> > -	q = blk_init_queue_node(do_ide_request, &ide_lock,
> > -				pcibus_to_node(drive->hwif->pci_dev->bus));
> > +	int node = 0; /* Should be -1 */
> 
> Why is this not -1?

Because there is no code in rc3 that handles -1 in kmalloc_node.

If you add a patch that handles it then feel free to change.
But fixing the bootup has the highest priority.

> 
> > +		int node = 0; 
> > +		if (hwif->drives[0].hwif) { 
> 
> Also needs to be -1.

Then it would crash again.


-Andi
