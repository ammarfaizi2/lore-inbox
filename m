Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265864AbUAEVHB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 16:07:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265849AbUAEVHB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 16:07:01 -0500
Received: from pizda.ninka.net ([216.101.162.242]:61581 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S265697AbUAEVG4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 16:06:56 -0500
Date: Mon, 5 Jan 2004 13:01:18 -0800
From: "David S. Miller" <davem@redhat.com>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
       gibbs@scsiguy.com
Subject: Re: [BUG] x86_64 pci_map_sg modifies sg list - fails multiple 
 map/unmaps
Message-Id: <20040105130118.0cb404b8.davem@redhat.com>
In-Reply-To: <p73brpi1544.fsf@verdi.suse.de>
References: <200401051929.i05JTsM0000014248@mudpuddle.cs.wustl.edu.suse.lists.linux.kernel>
	<20040105112800.7a9f240b.davem@redhat.com.suse.lists.linux.kernel>
	<p73brpi1544.fsf@verdi.suse.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 05 Jan 2004 22:02:19 +0100
Andi Kleen <ak@suse.de> wrote:

> It sets length to zero to terminate the list when entries were merged.
> It doesn't have a dma_length.

I understand, and you are defining dma_length to just use the
normal sg->length field, and I'm trying to explain to you that this
is not allowed.  If you want to modify the length field to zero terminate
the DMA chunks, you must have a seperate dma_length field in your
platforms scatterlist structure.

Again, for the 3rd time, see what sparc64 is doing here.

> It tripping over remapped lists is an side effect, but an useful one 
> because remapping is not supported (merging destroys information that
> cannot be reconstructed). If the bug didn't exist you would get data
> corruption.

You should not be modifying any portion of the non-DMA fields.
Therefore, if the SG is unmapped, then passed into your IOMMU code for
a future map call, it should just work.

