Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264866AbUE0QQk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264866AbUE0QQk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 May 2004 12:16:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264869AbUE0QQk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 May 2004 12:16:40 -0400
Received: from holomorphy.com ([207.189.100.168]:27016 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S264866AbUE0QQf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 May 2004 12:16:35 -0400
Date: Thu, 27 May 2004 09:16:14 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: John Bradford <john@grabjohn.com>
Cc: "Piszcz, Justin Michael" <justin.piszcz@mitretek.org>,
       Andy Lutomirski <luto@myrealbox.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Tom Felker <tcfelker@mtco.com>,
       Matthias Schniedermeyer <ms@citd.de>, linux-kernel@vger.kernel.org
Subject: Re: why swap at all?
Message-ID: <20040527161614.GG22648@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	John Bradford <john@grabjohn.com>,
	"Piszcz, Justin Michael" <justin.piszcz@mitretek.org>,
	Andy Lutomirski <luto@myrealbox.com>,
	Nick Piggin <nickpiggin@yahoo.com.au>,
	Tom Felker <tcfelker@mtco.com>,
	Matthias Schniedermeyer <ms@citd.de>, linux-kernel@vger.kernel.org
References: <5D3C2276FD64424297729EB733ED1F7606242C53@email1.mitretek.org> <20040527124145.GD22648@holomorphy.com> <200405271559.i4RFxqN3000359@81-2-122-30.bradfords.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200405271559.i4RFxqN3000359@81-2-122-30.bradfords.org.uk>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quote from William Lee Irwin III <wli@holomorphy.com>:
>> Yes. You want swap so you can physically relocate anonymous pages in the
>> rare case one ends up somewhere it could cause memory pressure against
>> allocations that can only be satisfied by a restricted range of memory.

On Thu, May 27, 2004 at 04:59:52PM +0100, John Bradford wrote:
> I think you are assuming a 100% perfect VM system.  In practice, if
> the machine isn't heavily loaded, unnecessary swap is more likely to
> cause, (slight, and possibly negligable), slowdowns, than bring any
> noticable performance benefit.

First, the above not a performance issue to begin with. It's a workload
feasibility issue. Second, the only overhead of swap when it's unused
is vmallocspace. Third, the only way to eliminate the runtime overhead
of the swap layer is CONFIG_SWAP=n.

The above scenario is not particularly common, but can be "fatal" to
the critical applications whose allocations were infeasible. I'd
recommend using a small amount of swapspace on your 16GB machine, e.g.
256MB or 512MB. One method of removing this requirement that swapspace
be configured so the kernel can get itself out of this pathological
situation is to implement page migration, so that memory movement e.g.
between zones need not be carried out through a backing store.

-- wli
