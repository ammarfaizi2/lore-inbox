Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263370AbTLJIds (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Dec 2003 03:33:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263464AbTLJIds
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Dec 2003 03:33:48 -0500
Received: from pizda.ninka.net ([216.101.162.242]:55968 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S263370AbTLJIdr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Dec 2003 03:33:47 -0500
Date: Wed, 10 Dec 2003 00:32:34 -0800
From: "David S. Miller" <davem@redhat.com>
To: Rask Ingemann Lambertsen <rask@sygehus.dk>
Cc: jt@hpl.hp.com, jt@bougret.hpl.hp.com, linux-kernel@vger.kernel.org,
       tsbogend@alpha.franken.de, jgarzik@pobox.com, netdev@oss.sgi.com
Subject: Re: [BUG 2.6.0-test11] pcnet32 oops
Message-Id: <20031210003234.2cb6f74e.davem@redhat.com>
In-Reply-To: <20031209151459.A1345@sygehus.dk>
References: <20031205234510.GA2319@bougret.hpl.hp.com>
	<20031205165900.2920ea6a.davem@redhat.com>
	<20031209151459.A1345@sygehus.dk>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Sorry, forgot to mention this in the previous email.

The way to fix this properly in the pcnet32 driver itself would
be to pass a stack local "struct sk_buff_head" list down into
these deep routines while we have the locks held.

Instead of freeing the TX skbs, we add them all to this list.

At the top level, the code drops the spinlock and enables cpu irqs,
then it frees up any SKBs that were put on that list.
