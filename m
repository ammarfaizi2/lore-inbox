Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264883AbTL0Xzr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Dec 2003 18:55:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264884AbTL0Xzr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Dec 2003 18:55:47 -0500
Received: from holomorphy.com ([199.26.172.102]:54192 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S264883AbTL0Xzq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Dec 2003 18:55:46 -0500
Date: Sat, 27 Dec 2003 15:55:38 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>, Rik van Riel <riel@surriel.com>,
       torvalds@osdl.org, benh@kernel.crashing.org,
       linux-kernel@vger.kernel.org, andrea@suse.de
Subject: Re: Page aging broken in 2.6
Message-ID: <20031227235538.GP22443@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@osdl.org>, Rik van Riel <riel@surriel.com>,
	torvalds@osdl.org, benh@kernel.crashing.org,
	linux-kernel@vger.kernel.org, andrea@suse.de
References: <1072423739.15458.62.camel@gaston> <Pine.LNX.4.58.0312260957100.14874@home.osdl.org> <1072482941.15458.90.camel@gaston> <Pine.LNX.4.58.0312261626260.14874@home.osdl.org> <1072485899.15456.96.camel@gaston> <Pine.LNX.4.58.0312261649070.14874@home.osdl.org> <Pine.LNX.4.55L.0312262147030.7686@imladris.surriel.com> <20031226190045.0f4651f3.akpm@osdl.org> <20031227230757.GA25229@k3.hellgate.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031227230757.GA25229@k3.hellgate.ch>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 28, 2003 at 12:07:58AM +0100, Roger Luethi wrote:
> It can matter. Evicting a page that is infrequently referenced by many
> processes increases the chance that all runnable processes block waiting
> for that same page later. The likelihood of that happening grows under
> memory pressure, when "infrequently" may actually be "quite often" and
> when disk I/O is congested (resulting in higher disk access times).
> You won't have the same effect when evicting a page that is referenced
> by one process only, no matter how frequently.

Part of this is unrealistic; paging I/O being congested must be due to
paging itself causing seeks without additional I/O load. Reading a
single page once and then faulting that one page back into numerous
process address spaces is only one I/O request, and so cannot seek in
and of itself. So in this scenario, a convoy of processes on a single
page is plausible; aggravated paging I/O seekiness is not. Did you have
in mind some additional I/O load? Or do affected processes actually all
fault before the one I/O completes, and so all block temporarily?

On Sun, Dec 28, 2003 at 12:07:58AM +0100, Roger Luethi wrote:
> Having all processes blocked is indeed one problem of 2.6 under memory
> pressure. I don't know what the cause is, though.

Can you capture sysrq t while a situation like this is in progress?

-- wli
