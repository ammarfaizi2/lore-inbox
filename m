Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261921AbTIWTHA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Sep 2003 15:07:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262198AbTIWTG6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Sep 2003 15:06:58 -0400
Received: from pizda.ninka.net ([216.101.162.242]:6620 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S261921AbTIWTFk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Sep 2003 15:05:40 -0400
Date: Tue, 23 Sep 2003 11:51:22 -0700
From: "David S. Miller" <davem@redhat.com>
To: Grant Grundler <iod00d@hp.com>
Cc: bcrl@kvack.org, tony.luck@intel.com, davidm@hpl.hp.com,
       davidm@napali.hpl.hp.com, peter@chubb.wattle.id.au, ak@suse.de,
       iod00d@hp.com, peterc@gelato.unsw.edu.au, linux-ns83820@kvack.org,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: NS83820 2.6.0-test5 driver seems unstable on IA64
Message-Id: <20030923115122.41b7178f.davem@redhat.com>
In-Reply-To: <20030923185104.GA8477@cup.hp.com>
References: <DD755978BA8283409FB0087C39132BD101B01194@fmsmsx404.fm.intel.com>
	<20030923142925.A16490@kvack.org>
	<20030923185104.GA8477@cup.hp.com>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Sep 2003 11:51:04 -0700
Grant Grundler <iod00d@hp.com> wrote:

> Even x86 pays at least a one cycle penalty for every misaligned access.

Yes, one cycle, and it's completely lost in the noise when it
happens.

> In general, open source code has no excuse for using misaligned fields.
> It's (mostly) avoidable.  TCP/IP headers are the historical exception.

It's not the TCP/IP headers intrinsically, it's what they are embedded
inside of.

For example, if the ethernet driver (as nearly all of our's do which
can) optimized for an ethernet header followed by an IP header, guess
what?  That causes ethernet header followed by appletalk followed
by IP to do unaligned accesses.

It is an unavoidable axoim in the kernel networking.  Unaligned accesses
will happen, and they aren't a bug and therefore not worthy of mention
in the kernel logs any more than "page was freed" :-)
