Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262415AbUCMA2h (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Mar 2004 19:28:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262721AbUCMA2h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Mar 2004 19:28:37 -0500
Received: from holomorphy.com ([207.189.100.168]:48391 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S262415AbUCMA2e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Mar 2004 19:28:34 -0500
Date: Fri, 12 Mar 2004 16:28:20 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrea Arcangeli <andrea@suse.de>, Rik van Riel <riel@redhat.com>,
       Hugh Dickins <hugh@veritas.com>, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: anon_vma RFC2
Message-ID: <20040313002820.GW655@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Linus Torvalds <torvalds@osdl.org>,
	Andrea Arcangeli <andrea@suse.de>, Rik van Riel <riel@redhat.com>,
	Hugh Dickins <hugh@veritas.com>, Ingo Molnar <mingo@elte.hu>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20040311135608.GI30940@dualathlon.random> <Pine.LNX.4.44.0403112226581.21139-100000@chimarrao.boston.redhat.com> <20040312122127.GQ30940@dualathlon.random> <20040312124638.GR655@holomorphy.com> <Pine.LNX.4.58.0403120812430.1045@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0403120812430.1045@ppc970.osdl.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 12, 2004 at 08:17:49AM -0800, Linus Torvalds wrote:
> I have to _violently_ agree with Andrea on this one.
> The absolute _LAST_ thing we want to have is a "remnant" rmap 
> infrastructure that only gets very occasional use. That's a GUARANTEED way 
> to get bugs, and really subtle behaviour.
> I think Andrea is 100% right. Either do rmap for everything (like we do
> now, modulo IO/mlock), or do it for _nothing_.  No half measures with
> "most of the time".
> Quite frankly, the stuff I've seen suggested sounds absolutely _horrible_. 
> Special cases are not just a pain to work with, they definitely will cause 
> bugs. It's not a matter of "if", it's a matter of "when".
> So let's make it clear: if we have an object-based reverse mapping, it 
> should cover all reasonable cases, and in particular, it should NOT have 
> rare fallbacks to code that thus never gets any real testing.
> And if we have per-page rmap like now, it should _always_ be there.
> You do have to realize that maintainability is a HELL of a lot more
> important than scalability of performance can be. Please keep that in
> mind.

The sole point I had to make was against a performance/resource scalabilty
argument; the soft issues weren't part of that, though they may ultimately
be the deciding factor.

-- wli
