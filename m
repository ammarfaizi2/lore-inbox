Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290767AbSAYSfU>; Fri, 25 Jan 2002 13:35:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290770AbSAYSex>; Fri, 25 Jan 2002 13:34:53 -0500
Received: from mailhost.nmt.edu ([129.138.4.52]:62482 "EHLO mailhost.nmt.edu")
	by vger.kernel.org with ESMTP id <S290767AbSAYSes>;
	Fri, 25 Jan 2002 13:34:48 -0500
Date: Fri, 25 Jan 2002 11:34:43 -0700
From: Val Henson <val@nmt.edu>
To: benh@kernel.crashing.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: Athlon/AGP issue update
Message-ID: <20020125113443.C26874@boardwalk>
In-Reply-To: <20020123.060855.26275529.davem@redhat.com> <20020123154737.19204@mailhost.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020123154737.19204@mailhost.mipsys.com>; from benh@kernel.crashing.org on Wed, Jan 23, 2002 at 04:47:37PM +0100
Favorite-Color: Polka dot
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 23, 2002 at 04:47:37PM +0100, benh@kernel.crashing.org wrote:
> >I don't think your PPC case needs the kernel mappings messed with.
> >I really doubt the PPC will speculatively fetch/store to a TLB
> >missing address.... unless you guys have large TLB mappings on
> >PPC too?
> 
> Yes, we use BATs (sort of built-in fixed large TLBs) to map
> the lowmem (or entire RAM without CONFIG_HIGHMEM).

Looking at bat_mapin_ram, it looks like we only map the first 512MB of
RAM with BATs, so we actually map the 512MB - 768MB range with PTEs
(and highmem starts at 768MB).  Two of the DBATs are used by I/O
mappings, so that only leaves two DBATs of 256MB each to map lowmem
anyway.  Am I missing something?

By the way, does the "nobats" option currently work on PowerMac?

-VAL
