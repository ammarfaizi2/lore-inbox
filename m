Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262868AbTL2LOZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Dec 2003 06:14:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263244AbTL2LOZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Dec 2003 06:14:25 -0500
Received: from holomorphy.com ([199.26.172.102]:20669 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S262868AbTL2LOX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Dec 2003 06:14:23 -0500
Date: Mon, 29 Dec 2003 03:14:18 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: mfedyk@matchmail.com, Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Page Colouring (was: 2.6.0 Huge pages not working as expected)
Message-ID: <20031229111418.GX22443@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	mfedyk@matchmail.com,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20031228163952.GQ22443@holomorphy.com> <20031229003631.GE1882@matchmail.com> <20031229025507.GT22443@holomorphy.com> <Pine.LNX.4.58.0312282000390.11299@home.osdl.org> <20031229065240.GU22443@holomorphy.com> <Pine.LNX.4.58.0312290112450.11299@home.osdl.org> <20031229092203.GL27687@holomorphy.com> <Pine.LNX.4.58.0312290129510.11299@home.osdl.org> <20031229102319.GW22443@holomorphy.com> <20031229105918.GH1882@matchmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031229105918.GH1882@matchmail.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 29, 2003 at 02:23:19AM -0800, William Lee Irwin III wrote:
>> bits are sprinkled around, along with a few more involved changes because
>> a large number of distributed changes are required to handle oddities
>> that occur when PAGE_SIZE changes from 4KB. The more involved changes
>> are often for things such as the only reason it uses PAGE_SIZE is
>> really that it just expects 4KB and says PAGE_SIZE, or that it wants
>> some fixed (even across compiles) size and needs updating for more
>> general PAGE_SIZE numbers, or sometimes that it expects PAGE_SIZE to be
>> what a pte maps when this is now represented by MMUPAGE_SIZE.

On Mon, Dec 29, 2003 at 02:59:18AM -0800, Mike Fedyk wrote:
> Any chance some of these changes are self contained, and could be split out
> and possibly merged into -mm?

I talked about this for a little while. Basically, there is only one
concept in the entire patch, despite its large size. The vast bulk of
the "distributed changes" are s/PAGE_SIZE/MMUPAGE_SIZE/.

At some point I was told to keep the whole shebang rolling out of tree
or otherwise not answered by akpm and/or Linus, after I sent in what a
split up (this is actually very easy to split up file-by-file) version
of what just some of the totally trivial arch/i386/ changes would look
like. The nontrivial changes are stupid in nature, but touch "fragile"
or otherwise "scary to touch" code, and so sort of relegate them to 2.7.
This is not entirely unjustified, as changes of a similar code impact
wrt. the GDT appear to have affected some APM systems' suspend ability
(I know for a fact my changes do not have impacts on APM suspend, but
other, analogous support issues could arise after broader testing.)

Basically, the MMUPAGE_SIZE introductions didn't interest anyone a while
ago, and I suspect people probably just want them all at once, since it's
unlikely people want to repeat the pain analogous to PAGE_CACHE_SIZE (I
should clarify later how this is different) where the incremental
introduction never culminated in the introduction of functionality.


-- wli
