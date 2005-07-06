Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262268AbVGFXxr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262268AbVGFXxr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 19:53:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262426AbVGFUFz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 16:05:55 -0400
Received: from mx2.suse.de ([195.135.220.15]:57307 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S262421AbVGFSWF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 14:22:05 -0400
Date: Wed, 6 Jul 2005 20:21:59 +0200
From: Andi Kleen <ak@suse.de>
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, torvalds@osdl.org, linux-kernel@vger.kernel.org,
       christoph@lameter.com
Subject: Re: [PATCH] Fix crash on boot in kmalloc_node IDE changes
Message-ID: <20050706202159.5d353b72@basil.nowhere.org>
In-Reply-To: <58cb370e05070607351fe5eced@mail.gmail.com>
References: <20050706133052.GF21330@wotan.suse.de>
	<58cb370e050706070512c93ee1@mail.gmail.com>
	<20050706140933.GH21330@wotan.suse.de>
	<58cb370e05070607351fe5eced@mail.gmail.com>
X-Mailer: Sylpheed-Claws 1.0.3 (GTK+ 1.2.10; x86_64-suse-linux)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Jul 2005 16:35:11 +0200
Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:

> On 7/6/05, Andi Kleen <ak@suse.de> wrote:
> > > drive->hwif check is redundant, please remove it
> > 
> > It's not. My first version didn't have it but it still crashed.
> > It's what actually prevents the crash.
> > I also don't know why, but it's true.
> 
> very weird as HWIF(drive) == drive->hwif:
> 
> 	ide_hwif_t *hwif = HWIF(drive);
> 
> ...
> 
> 	q = blk_init_queue_node(do_ide_request, &ide_lock,
> 				pcibus_to_node(drive->hwif->pci_dev->bus));
                                               ^^^^^^^^^^^^^^

I oops on that one. Maybe it takes the early return. 

> 	if (!q)
> 		return 1;
> 
> ...
> 
> 	if (!hwif->rqsize) {
> 
> you should OOPS here


I would appreciate if some form of this patch is merged asap because it breaks
booting on my test machines.

-Andi
