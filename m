Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422795AbWKPNIh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422795AbWKPNIh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Nov 2006 08:08:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423922AbWKPNIh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Nov 2006 08:08:37 -0500
Received: from moutng.kundenserver.de ([212.227.126.187]:18368 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1422795AbWKPNIg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Nov 2006 08:08:36 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Christoph Lameter <clameter@sgi.com>
Subject: Re: [patch 2/2] enables booting a NUMA system where some nodes have no memory
Date: Thu, 16 Nov 2006 14:08:25 +0100
User-Agent: KMail/1.9.5
Cc: Martin Bligh <mbligh@mbligh.org>, Christian Krafft <krafft@de.ibm.com>,
       linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20061115193049.3457b44c@localhost> <200611160126.02016.arnd@arndb.de> <Pine.LNX.4.64.0611151643420.24457@schroedinger.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.64.0611151643420.24457@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200611161408.26328.arnd@arndb.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 16 November 2006 01:45, Christoph Lameter wrote:
> On Thu, 16 Nov 2006, Arnd Bergmann wrote:
> 
> > - we want to be able to boot with the 'mem=512M' option, which effectively
> >   disables the memory on the second node (each node has 512MiB).
> > - Each node has 8 SPUs, all of which we want to use. In order to use an
> >   SPU, we call __add_pages to register the local memory on it, so we have
> >   struct page pointers we can hand out to user mappings with ->nopage().
> 
> This is more like the bringup of a processor right? You need
> to have the memory online before the processor is brought up otherwise
> the slab cannot properly allocate its structures on the node when the
> per node portion is brought up. The page allocator has similar issues.

No, that's not really the issue here. The memory we're trying to add to the
mem_map can not be used for kernel allocations at all and is never entered
into the buddy allocator. It can only be used for applications running on
an SPU itself.

So the problem is not the order in which we do things, but the fact that
node data structure has not been initialized, and never will be, when
we add the SPU to the node.

	Arnd <><
