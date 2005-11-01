Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932573AbVKAHEa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932573AbVKAHEa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 02:04:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932567AbVKAHEa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 02:04:30 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:18440 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S932564AbVKAHE3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 02:04:29 -0500
Date: Tue, 1 Nov 2005 07:53:27 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Matt Mackall <mpm@selenic.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       linux-arch@vger.kernel.org
Subject: Re: [PATCH 13/20] inflate: (arch) kill silly zlib typedefs
Message-ID: <20051101065327.GP22601@alpha.home.local>
References: <14.196662837@selenic.com> <Pine.LNX.4.62.0510312204400.26471@numbat.sonytel.be> <20051031211422.GC4367@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051031211422.GC4367@waste.org>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 31, 2005 at 01:14:22PM -0800, Matt Mackall wrote:
> On Mon, Oct 31, 2005 at 10:05:15PM +0100, Geert Uytterhoeven wrote:
> > On Mon, 31 Oct 2005, Matt Mackall wrote:
> > > inflate: remove legacy type definitions from callers
> > > 
> > > This replaces the legacy zlib typedefs and usage with kernel types in
> > > all the inflate users.
> > 
> > > -static ulg free_mem_ptr;
> > > -static ulg free_mem_ptr_end;
> > > +static u32 free_mem_ptr;
> > > +static u32 free_mem_ptr_end;
> > 
> > Bang, on 64-bit platforms...
> 
> That was quick.
> 
> Yes, this is broken on Alpha. The other 64-bit arches use proper pointers
> here. But I need to change all the arches to use the same pointer
> type, probably as patch 8.5 in the series.

But if it's a pointer why don't you declare them unsigned long then ?
C defines the long as the integer the right size to store a pointer.
u32 is just a 32 bits unsigned integer, which will not always do what
you're looking for. Having read the rest of the patch, I guess you can
also make the pointer (void *) and avoid a few casts later.

Regards,
Willy

