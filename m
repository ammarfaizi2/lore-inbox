Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269056AbUINGKg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269056AbUINGKg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 02:10:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269063AbUINGKg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 02:10:36 -0400
Received: from holomorphy.com ([207.189.100.168]:19857 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S269056AbUINGK3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 02:10:29 -0400
Date: Mon, 13 Sep 2004 23:10:23 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: "David S. Miller" <davem@davemloft.net>
Cc: akpm@osdl.org, raybry@sgi.com, jbarnes@engr.sgi.com,
       linux-kernel@vger.kernel.org
Subject: Re: [profile] amortize atomic hit count increments
Message-ID: <20040914061023.GC9106@holomorphy.com>
References: <20040913015003.5406abae.akpm@osdl.org> <20040914044748.GZ9106@holomorphy.com> <20040913220507.1a269816.davem@davemloft.net> <20040914053218.GB9106@holomorphy.com> <20040913224943.04761a15.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040913224943.04761a15.davem@davemloft.net>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Sep 2004 22:32:18 -0700 William Lee Irwin III wrote:
>> There is also an unusual facet to this; the TLB overhead of a loop like:
[...]
>> is very large and caused "effective nontermination", otherwise known as
>> "exhausting the user's patience", on SGI's systems after about half an
>> hour. So some TLB overhead amortization is necessary for this to be
>> feasible. I suspect iterating over pages of the profile buffer and
>> storing intermediate results for a page full of profile buffer hits
>> in a buffer page may suffice though I've not tried it.

On Mon, Sep 13, 2004 at 10:49:43PM -0700, David S. Miller wrote:
> I bet that, like we found out about page tables on 64-bit, these
> profile buffers are sparsely populated with hits.  So perhaps a
> per-cpu bitmap that indicates regions that might have any hits
> at all, allowing large amounts of skipping and thus amortizing the
> scan cost.

Well, that would speed it up, but the catastrophe was avoided in the
older patches by just processing all the hits for one cpu at a time,
and the buffering methods above for your suggested accounting
structures likely work well enough the overhead of processing unused
portions of the bitmap can be ignored. I don't really want to go about
addressing performance issues besides effective or actual
nontermination for this code, and would rather leave highly efficient
methods to oprofile (in fact, some others believe that even bugfixes
for such issues should be ignored for kernel/profile.c, contrary to my
notion that it shouldn't crash systems regardless of their size).


-- wli
