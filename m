Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261603AbVACUaq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261603AbVACUaq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 15:30:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261693AbVACUaq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 15:30:46 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:45702 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S261603AbVACUaj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 15:30:39 -0500
Date: Mon, 3 Jan 2005 12:30:29 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: Linus Torvalds <torvalds@osdl.org>
cc: Florian Weimer <fw@deneb.enyo.de>, 7eggert@gmx.de, akpm@osdl.org,
       linux-ia64@vger.kernel.org, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org
Subject: Re: Prezeroing V2 [3/4]: Add support for ZEROED and NOT_ZEROED free
 maps
In-Reply-To: <Pine.LNX.4.58.0412261511030.2353@ppc970.osdl.org>
Message-ID: <Pine.LNX.4.58.0501031225130.22688@schroedinger.engr.sgi.com>
References: <fa.n0l29ap.1nqg39@ifi.uio.no> <fa.n04s9ar.17sg3f@ifi.uio.no>
 <E1ChwhG-00011c-00@be1.7eggert.dyndns.org> <87wtv464ty.fsf@deneb.enyo.de>
 <Pine.LNX.4.58.0412261511030.2353@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 26 Dec 2004, Linus Torvalds wrote:

> Anyway, at this point I think the most interesting question is whether it
> actually improves any macro-benchmark behaviour, rather than just a page
> fault latency tester microbenchmark..

Any suggestion as to what macro-benchmark would allow that kind of
testing? I tried lmbench but it immediately writes to the complete page
that was allocated. I tried to vary the number of cache cells touched
after an allocation of an prezeroed page. Unsurprisingly it degenerates to
regular behavior if all cache lines are touched. So we would need a
benchmar that allows sparse memory use testing and preferably is able to
also allow SMP tests. I will test with some of the typical apps running
on  Altix machines but those are extremely heavy in terms of memory use
and  will likely be as positive as my microbenches.

BTW my bench does simulate the typical behavior of such an app using a
sparse array and allows the configuration of the number of cache lines
per page to touch.

