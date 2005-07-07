Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261367AbVGGQey@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261367AbVGGQey (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 12:34:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261448AbVGGQew
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 12:34:52 -0400
Received: from graphe.net ([209.204.138.32]:13974 "EHLO graphe.net")
	by vger.kernel.org with ESMTP id S261410AbVGGQcz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 12:32:55 -0400
Date: Thu, 7 Jul 2005 09:32:51 -0700 (PDT)
From: Christoph Lameter <christoph@lameter.com>
X-X-Sender: christoph@graphe.net
To: Andi Kleen <ak@suse.de>
cc: linux-ide@vger.kernel.org, torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [another PATCH] Fix crash on boot in kmalloc_node IDE changes
In-Reply-To: <20050707162442.GI21330@wotan.suse.de>
Message-ID: <Pine.LNX.4.62.0507070930220.5875@graphe.net>
References: <20050706133052.GF21330@wotan.suse.de> <Pine.LNX.4.62.0507070912140.27066@graphe.net>
 <20050707162442.GI21330@wotan.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: -5.8
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Jul 2005, Andi Kleen wrote:

> On Thu, Jul 07, 2005 at 09:21:55AM -0700, Christoph Lameter wrote:
> > On Wed, 6 Jul 2005, Andi Kleen wrote:
> > 
> > > Without this patch a dual Xeon EM64T machine would oops on boot
> > > because the hwif pointer here was NULL. I also added a check for
> > > pci_dev because it's doubtful that all IDE devices have pci_devs.
> > 
> > Here is IMHO the right way to fix this. Test for the hwif != NULL and
> > test for pci_dev != NULL before determining the node number of the pci 
> > bus that the device is connected to. Maybe we need a hwif_to_node for ide 
> > drivers that is also able to determine the locality of other hardware?
> 
> Hmm? Where is the difference? 

node = -1 if the node cannot be determined.

> This is 100% equivalent to my code except that you compressed
> it all into a single expression.

My patch consistently checks for hwif != NULL and pci_dev != NULL. 
There was someother stuff in your patch. This patch does not add any 
additional variables and is more readable.
