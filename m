Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261373AbTIXDVi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Sep 2003 23:21:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261380AbTIXDVi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Sep 2003 23:21:38 -0400
Received: from pizda.ninka.net ([216.101.162.242]:63712 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S261361AbTIXDVf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Sep 2003 23:21:35 -0400
Date: Tue, 23 Sep 2003 20:08:32 -0700
From: "David S. Miller" <davem@redhat.com>
To: davidm@hpl.hp.com
Cc: davidm@napali.hpl.hp.com, kevin.vanmaren@unisys.com,
       peter@chubb.wattle.id.au, bcrl@kvack.org, ak@suse.de, iod00d@hp.com,
       peterc@gelato.unsw.edu.au, linux-ns83820@kvack.org,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: NS83820 2.6.0-test5 driver seems unstable on IA64
Message-Id: <20030923200832.1a58a215.davem@redhat.com>
In-Reply-To: <16240.42563.834328.584444@napali.hpl.hp.com>
References: <BFF315B8E1D7F845B8FC1C28778693D70AFEC6@usslc-exch1.na.uis.unisys.com>
	<20030923105712.552dbb1e.davem@redhat.com>
	<16240.36993.148535.613568@napali.hpl.hp.com>
	<20030923114744.137d5dac.davem@redhat.com>
	<16240.40001.632466.644215@napali.hpl.hp.com>
	<20030923121044.483d3a5c.davem@redhat.com>
	<16240.42563.834328.584444@napali.hpl.hp.com>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Sep 2003 13:00:03 -0700
David Mosberger <davidm@napali.hpl.hp.com> wrote:

> But they _are_ useful.  Peter certainly noticed very quickly that
> there was a problem with the ns83820 driver.  Do you think it would
> have been better for the kernel to run silently at greatly degraded
> performance?  I think not.

It's not even decided that the copying version is faster.

I bet for bulk data transfers it isn't faster at all, because instead
of spinning in the unaligned trap handler your spinning swiping the
L2 cache clean with the copies.  I'll take some traps over twice the
data footprint any day, because I can optimize the traps but I can't
make the memory overhead go away.

Also, how much have you optimized your unaligned trap handler?  If it's
a thousand cycles now, do you think you could cut that overhead say
in half?  I bet you could, and then some.  I bet a clever handler could
be done on ia64 or sparc64 in a hundred cycles or so, maybe even faster.

Furthermore, like I said, if you want performance you aren't going
to stick a NS83820 in your box.  Even the author of the driver admits
this and it's not like this chip is the only ~$30USD gigabit chip in
town anymore :)
