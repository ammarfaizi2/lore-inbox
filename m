Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267284AbTA0SwQ>; Mon, 27 Jan 2003 13:52:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267285AbTA0SwQ>; Mon, 27 Jan 2003 13:52:16 -0500
Received: from [217.167.51.129] ([217.167.51.129]:33767 "EHLO zion.wanadoo.fr")
	by vger.kernel.org with ESMTP id <S267284AbTA0SwP>;
	Mon, 27 Jan 2003 13:52:15 -0500
Subject: Re: 2.4.21-pre3 kernel crash
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ross Biro <rossb@google.com>
Cc: linux-kernel@vger.kernel.org, alan@redhat.com
In-Reply-To: <3E356403.9010805@google.com>
References: <Pine.OSF.4.51.0301271632230.49659@tao.natur.cuni.cz>
	 <3E356403.9010805@google.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1043694192.2756.55.camel@zion.wanadoo.fr>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.0 
Date: 27 Jan 2003 20:03:13 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-01-27 at 17:53, Ross Biro wrote:
> This looks like the same problem I ran into with IDE and highmem not 
> getting along.  Try compiling your kernel with out highmem enabled and 
> see what happenes.

Indeed, looking at the code, it seems ide_build_sglist() doesn't worry
much about highmem, just picks bh->b_data, assume it's a virtual
address, and gives that to pci_map_sg(). I beleive, at least for highmem
pages, it should rather pick bh->b_page and bh_offset(bh)

I can hack something, maybe tonight, but I can't test HIGHMEM for a while
here. Interestingly, I had no problem report on PPC from users using IDE
with highmem though.

Ben.

