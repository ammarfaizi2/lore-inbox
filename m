Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265222AbSLBG4u>; Mon, 2 Dec 2002 01:56:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265236AbSLBG4u>; Mon, 2 Dec 2002 01:56:50 -0500
Received: from holomorphy.com ([66.224.33.161]:50316 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S265222AbSLBG4u>;
	Mon, 2 Dec 2002 01:56:50 -0500
Date: Sun, 1 Dec 2002 23:04:12 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Maximum Physical Memory on 2.4 and ia32
Message-ID: <20021202070412.GO697@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	LKML <linux-kernel@vger.kernel.org>
References: <20021202120835.4ecb87fd.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021202120835.4ecb87fd.sfr@canb.auug.org.au>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 02, 2002 at 12:08:35PM +1100, Stephen Rothwell wrote:
> (http://www.redhat.com/services/techsupport/production/GSS_caveat.html)
> What are the "operating system design limits" that restrict the amount of
> supported memory to 16GB?

I've relayed this privately in less organized private discussions:

The design limitation is that a PTE is required to map a PAGE_SIZE
-sized region. The kernel allocation unit needs to be enlarged without
breaking ABI to reduce the fraction of physical memory reserved for
metadata i.e. mem_map[]. This is called page clustering.

Hugh Dickins implemented page clustering by creating a distinction
between PAGE_SIZE and MMUPAGE_SIZE then introducing an API for dealing
with vectors of PTE's. He implemented this for 2.4.6 and 2.4.7. His
patches are at ftp://ftp.veritas.com/linux/ In other environments this
is an optimization, not a requirement to be able to run, and so it
benefits all platforms.

There are, of course, other kinds of metadata generated at runtime that
may impose limitations on feasibility of workloads on large highmem boxen.

Bill
