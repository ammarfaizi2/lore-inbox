Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263422AbTIWU6k (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Sep 2003 16:58:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263418AbTIWU6k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Sep 2003 16:58:40 -0400
Received: from pizda.ninka.net ([216.101.162.242]:44765 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S263415AbTIWU6h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Sep 2003 16:58:37 -0400
Date: Tue, 23 Sep 2003 13:45:29 -0700
From: "David S. Miller" <davem@redhat.com>
To: Grant Grundler <iod00d@hp.com>
Cc: bcrl@kvack.org, tony.luck@intel.com, davidm@hpl.hp.com,
       davidm@napali.hpl.hp.com, peter@chubb.wattle.id.au, ak@suse.de,
       peterc@gelato.unsw.edu.au, linux-ns83820@kvack.org,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: NS83820 2.6.0-test5 driver seems unstable on IA64
Message-Id: <20030923134529.7ea79952.davem@redhat.com>
In-Reply-To: <20030923203819.GB8477@cup.hp.com>
References: <DD755978BA8283409FB0087C39132BD101B01194@fmsmsx404.fm.intel.com>
	<20030923142925.A16490@kvack.org>
	<20030923185104.GA8477@cup.hp.com>
	<20030923115122.41b7178f.davem@redhat.com>
	<20030923203819.GB8477@cup.hp.com>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Sep 2003 13:38:19 -0700
Grant Grundler <iod00d@hp.com> wrote:

> Given misaligned accesses are infrequent enough to affect
> performance, it makes sense to do this in SW because
> it reduces cost of the HW design/test/mfg cycles.

Intel actually optimizes this on the P4, what is your
response to that?  Is Intel wasting they time? :-)

> Ok. If the kernel networking stack used get_unaligned() in the one place
> Peter originally found, x86/sparc64?/et al wouldn't see a difference.
> It would avoid traps on ia64 and parisc.  Bad idea?
> Any other arches it might help/hurt on?

It's needed on every access to every TCP and IP header portion
for the case we're talking about in this thread, where the network
device driver gives the networking a packet that ends up with
unaligned IP and TCP headers.

I once considered adding some get_unaligned() uses to the TCP option
parsing code, guess who rejected that patch?  It wasn't me, it was
Linus himself and I came to learn that he's right on this one.
