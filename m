Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270151AbTGMHdi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jul 2003 03:33:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270149AbTGMHdi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jul 2003 03:33:38 -0400
Received: from rth.ninka.net ([216.101.162.244]:12428 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id S265182AbTGMHdg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jul 2003 03:33:36 -0400
Date: Sun, 13 Jul 2003 00:48:18 -0700
From: "David S. Miller" <davem@redhat.com>
To: "Alan Shih" <alan@storlinksemi.com>
Cc: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org,
       netdev@oss.sgi.com
Subject: Re: TCP IP Offloading Interface
Message-Id: <20030713004818.4f1895be.davem@redhat.com>
In-Reply-To: <ODEIIOAOPGGCDIKEOPILCEMBCMAA.alan@storlinksemi.com>
References: <ODEIIOAOPGGCDIKEOPILCEMBCMAA.alan@storlinksemi.com>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 13 Jul 2003 00:33:00 -0700
"Alan Shih" <alan@storlinksemi.com> wrote:

> Or TOE is a forbidden discussion?

TOE is evil, read this:

http://www.usenix.org/events/hotos03/tech/full_papers/mogul/mogul.pdf

TOE is exactly suboptimal for the very things performance
matters, high connection rates.

Your return is also absolutely questionable.  Servers "serve" data
and we offload all of the send side TCP processing that can
reasonably be done (segmentation, checksumming).

I've never seen an impartial benchmark showing that TCP send
side performance goes up as a result of using TOE vs. the usual
segmentation + checksum offloading offered today.

On receive side, clever RX buffer flipping tricks are the way
to go and require no protocol changes and nothing gross like
TOE or weird buffer ownership protocols like RDMA requires.

I've made postings showing how such a scheme can work using a limited
flow cache on the networking card.  I don't have a reference handy,
but I suppose someone else does.

And finally, this discussion belongs on the "networking" lists.
Nearly all of the "networking" developers don't have time to sift
through linux-kernel every day.
