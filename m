Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265208AbUAETWN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 14:22:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265158AbUAETWN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 14:22:13 -0500
Received: from rth.ninka.net ([216.101.162.244]:26753 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id S265130AbUAETWK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 14:22:10 -0500
Date: Mon, 5 Jan 2004 11:22:02 -0800
From: "David S. Miller" <davem@redhat.com>
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
       berkley@cs.wustl.edu
Subject: Re: [BUG] x86_64 pci_map_sg modifies sg list - fails multiple
 map/unmaps
Message-Id: <20040105112202.1fe5cacf.davem@redhat.com>
In-Reply-To: <2938942704.1073325455@aslan.btc.adaptec.com>
References: <2938942704.1073325455@aslan.btc.adaptec.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 05 Jan 2004 10:57:35 -0700
"Justin T. Gibbs" <gibbs@scsiguy.com> wrote:

> DMA-API.txt doesn't seem to cover this issue.  Should the low-level DMA
> code restore the S/G list to its original state on unmap or should the
> SCSI HBA drivers be changed to update "use_sg" with the segment count
> reported by the pci_map_sg() API?  If the latter, this seems to contradict
> the mandate in DMA-API that the nseg parameter passed into the unmap call
> be the same as that passed into the map call.  Most of the kernel assumes
> that an S/G list can be mapped an unmapped multiple times using the same
> arguments.  This doesn't seem to me to be an unreasonable expectation.

No, the PCI layer is not required at all to restore the SG to it's original state
if it does DMA page coalescing as sparc64 and x86_64 do.

But I don't see what the real problem is, all the PCI layer is doing is setting up
the DMA address/length pairs in the entries that are needed, then returning
the number of such slots that exist.  You, in your driver, can remember the original
total number of physical entries and use that value to pass things back in.
