Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751165AbWBORtw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751165AbWBORtw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 12:49:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751172AbWBORtw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 12:49:52 -0500
Received: from [194.90.237.34] ([194.90.237.34]:62067 "EHLO mtlexch01.mtl.com")
	by vger.kernel.org with ESMTP id S1751156AbWBORtu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 12:49:50 -0500
Date: Wed, 15 Feb 2006 19:51:18 +0200
From: "Michael S. Tsirkin" <mst@mellanox.co.il>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Badari Pulavarty <pbadari@us.ibm.com>, linux-arch@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Andrew Morton <akpm@osdl.org>,
       Roland Dreier <rdreier@cisco.com>, Hugh Dickins <hugh@veritas.com>,
       Gleb Natapov <gleb@minantech.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       openib-general@openib.org, Petr Vandrovec <vandrove@vc.cvut.cz>,
       Matthew Wilcox <matthew@wil.cx>
Subject: Re: [PATCH] add asm-generic/mman.h
Message-ID: <20060215175118.GK12974@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
References: <20060215151649.GA12090@mellanox.co.il> <1140019088.21448.3.camel@dyn9047017100.beaverton.ibm.com> <20060215165016.GD12974@mellanox.co.il> <1140022377.21448.6.camel@dyn9047017100.beaverton.ibm.com> <20060215170935.GE12974@mellanox.co.il> <Pine.LNX.4.64.0602150916580.3691@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0602150916580.3691@g5.osdl.org>
User-Agent: Mutt/1.4.2.1i
X-OriginalArrivalTime: 15 Feb 2006 17:51:44.0953 (UTC) FILETIME=[7C3D2290:01C63258]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting r. Linus Torvalds <torvalds@osdl.org>:
> Rule #1: use tools instead of eyeballs whenever you possibly can. Humans 
> are bad at noticing changes like this.

OK, this

#!/usr/bin/perl

my %new_values;
my @old_names;
my @old_values;
while (<>)
{
	if (m/^\+#define\s+(\S+)\s+(\S+)\s+.*$/) {
		$new_values{$1}=$2;
	}
	if (m/^\-#define\s+(\S+)\s+(\S+)\s+.*$/) {
		push @old_names, $1;
		push @old_values, $2;
	}
}

for (my $i = 0; $i <= $#old_values; $i++) {
	if (oct($new_values{$old_names[$i]}) != oct($old_values[$i])) {
		print "Changed: $old_names[$i] $old_values[$i] " .
		      " to $new_values{$old_names[$i]}\n";
	}
}

Shows that the only numbers changed are
MADV_REMOVE
MADV_DONTFORK
MADV_DOFORK

As was intended.
OK now?

-- 
Michael S. Tsirkin
Staff Engineer, Mellanox Technologies
