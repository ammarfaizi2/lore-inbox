Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288951AbSAFNwX>; Sun, 6 Jan 2002 08:52:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288955AbSAFNwN>; Sun, 6 Jan 2002 08:52:13 -0500
Received: from holomorphy.com ([216.36.33.161]:39881 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S288951AbSAFNwB>;
	Sun, 6 Jan 2002 08:52:01 -0500
Date: Sun, 6 Jan 2002 05:51:47 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Anton Blanchard <anton@samba.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Remove 8 bytes from struct page on 64bit archs
Message-ID: <20020106055147.G10391@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Anton Blanchard <anton@samba.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20020106123913.GA5407@krispykreme> <20020106051134.E10391@holomorphy.com> <20020106133326.GD30292@krispykreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <20020106133326.GD30292@krispykreme>; from anton@samba.org on Mon, Jan 07, 2002 at 12:33:26AM +1100
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 07, 2002 at 12:33:26AM +1100, Anton Blanchard wrote:
> For archs that need ->zone, merging it with ->flags sounds like a
> great idea. Id like to cram something into ->flags on 64 bit archs
> since its only a long due to bitop constraints. I had thought of
> stuffing ->count in the high word but now Im just getting silly
> since all non atomic accesses to ->flags would then have to be word
> ones.

At some point in the past, I wrote:
>> My i386 version, which makes ->virtual conditional on CONFIG_HIGHMEM as
>> well, is at:

On Mon, Jan 07, 2002 at 12:33:26AM +1100, Anton Blanchard wrote:
> Id like to do redo some profiling, on ppc64 we had page_address() doing
> pointer arithmetic (instead of page->virtual) and the compiler created
> an awful sequence of instructions in the acenic interrupt handler.
> A zero copy TCP benchmark made it rather obvious.

I'm not entirely surprised at this, CONFIG_HIGHMEM is probably just
not quite a strict enough criterion for eliminating ->virtual as it's
a time/space tradeoff that just happens to be bad on ppc64. Maybe we
should figure out some other criterion in addition to it.


Cheers,
Bill
