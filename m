Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265357AbUAEUlN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 15:41:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265359AbUAEUlN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 15:41:13 -0500
Received: from pizda.ninka.net ([216.101.162.242]:45965 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S265357AbUAEUku (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 15:40:50 -0500
Date: Mon, 5 Jan 2004 12:35:09 -0800
From: "David S. Miller" <davem@redhat.com>
To: Andi Kleen <ak@muc.de>
Cc: gibbs@scsiguy.com, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
Subject: Re: [BUG] x86_64 pci_map_sg modifies sg list - fails multiple
 map/unmaps
Message-Id: <20040105123509.4bacf670.davem@redhat.com>
In-Reply-To: <m3brpi41q0.fsf@averell.firstfloor.org>
References: <2938942704.1073325455@aslan.btc.adaptec.com>
	<m3brpi41q0.fsf@averell.firstfloor.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 05 Jan 2004 20:47:19 +0100
Andi Kleen <ak@muc.de> wrote:

> Actually I disabled merging by default in the latest x86-64 code,
> but it can be still enabled by the user using options (it makes some
> adapters run several percent faster). I would appreciate if you could
> fix the problem anyways.
> 
> I was actually planning to add a BUG() for this. Should do that.
> There is already one that triggers often when the problem occurs.

Andi, you must not modify sg->length in any way shape or form.

The following is legal:

	pci_map_sg(..&sg);
	pci_unmap_sg(...&sg);
	pci_map_sg(..&sg);

If you must modify the length field for DMA, you must have a seperate
dma_length member of the scatterlist structure on your platform, see what
sparc64 does here.

If the documentation states this wrongly, it's a doc bug.
