Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267615AbUHRXdt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267615AbUHRXdt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Aug 2004 19:33:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267614AbUHRXdt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Aug 2004 19:33:49 -0400
Received: from holomorphy.com ([207.189.100.168]:60858 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S267615AbUHRXdd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Aug 2004 19:33:33 -0400
Date: Wed, 18 Aug 2004 16:33:24 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: "David S. Miller" <davem@redhat.com>
Cc: pj@sgi.com, linux-kernel@vger.kernel.org
Subject: Re: Does io_remap_page_range() take 5 or 6 args?
Message-ID: <20040818233324.GT11200@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	"David S. Miller" <davem@redhat.com>, pj@sgi.com,
	linux-kernel@vger.kernel.org
References: <20040818133348.7e319e0e.pj@sgi.com> <20040818205338.GF11200@holomorphy.com> <20040818135638.4326ca02.davem@redhat.com> <20040818210503.GG11200@holomorphy.com> <20040818143029.23db8740.davem@redhat.com> <20040818214026.GL11200@holomorphy.com> <20040818220001.GN11200@holomorphy.com> <20040818225915.GQ11200@holomorphy.com> <20040818161658.49aa8de3.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040818161658.49aa8de3.davem@redhat.com>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Aug 2004 15:59:15 -0700
>> Given this, will a pfn suffice?

On Wed, Aug 18, 2004 at 04:16:58PM -0700, David S. Miller wrote:
> There is an error in the calculations.  16TB "RAM", means "RAM".
> On many systems, a large chunk of the physical address space is
> taken up by I/O areas, not real memory.
> Such areas do not take up mem_map[] array space.
> Regardless, I think an "unsigned long" page frame number is sufficient
> for now.  Don't even make the new type.

Oh, virtualspace footprint of IO areas is far worse, as the convention
is to direct map them into a single address space if they're ever used.
Of course this convention is much more loosely established than e.g.
struct page is for RAM. Some analogue of kmap_atomic() for such
machines to multiplex virtualspace in interrupt context would help, but
is unrelated to physical address passing issues.


-- wli
