Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262346AbVGFULi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262346AbVGFULi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 16:11:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262512AbVGFULg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 16:11:36 -0400
Received: from graphe.net ([209.204.138.32]:21898 "EHLO graphe.net")
	by vger.kernel.org with ESMTP id S262346AbVGFTdx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 15:33:53 -0400
Date: Wed, 6 Jul 2005 12:33:51 -0700 (PDT)
From: Christoph Lameter <christoph@lameter.com>
X-X-Sender: christoph@graphe.net
To: Andi Kleen <ak@suse.de>
cc: akpm@osdl.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
       gregkh@suse.de
Subject: Re: [PATCH] Run PCI driver initialization on local node
In-Reply-To: <20050706175603.GL21330@wotan.suse.de>
Message-ID: <Pine.LNX.4.62.0507061232040.720@graphe.net>
References: <20050706133248.GG21330@wotan.suse.de> <Pine.LNX.4.62.0507060934360.20107@graphe.net>
 <20050706175603.GL21330@wotan.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: -5.8
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Jul 2005, Andi Kleen wrote:

> > That depends on the architecture. Some do round robin allocs for periods 
> > of time during bootup. I think it is better to explicitly place control 
> 
> slab will usually do the right thing because it has a forced
> local node policy, but __gfp might not.

The slab allocator will do the right thing with the numa slab allocator in 
Andrew's tree but not with the one in Linus'tree. The one is Linus tree
will just pickup whatever slab is available irregardless of the node.
Only kmalloc_node will make a reasonable attempt to locate the memory on 
a specific node.

