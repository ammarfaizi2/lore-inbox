Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270995AbTHKEzv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 00:55:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271002AbTHKEzv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 00:55:51 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:31621 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S270995AbTHKEzt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 00:55:49 -0400
Date: Mon, 11 Aug 2003 05:55:31 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Willy Tarreau <willy@w.ods.org>
Cc: Albert Cahalan <albert@users.sourceforge.net>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       davem@redhat.com, chip@pobox.com
Subject: Re: [PATCH] 2.4.22pre10: {,un}likely_p() macros for pointers
Message-ID: <20030811045531.GH10446@mail.jlokier.co.uk>
References: <1060488233.780.65.camel@cube> <20030810072945.GA14038@alpha.home.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030810072945.GA14038@alpha.home.local>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Willy Tarreau wrote:
> > I looked at the assembly (ppc, gcc 3.2.3) and didn't
> > see any overhead.
> 
> same here on x86, gcc-2.95.3 and gcc-3.3.1. The compiler is smart enough not
> to add several intermediate tests for !!(x).

What I recall is no additional tests, but the different forms affected
the compilers choice of instructions on x86, making one form better
than another.  Unfortunately I don't recall what that was, or what
test it showed up in :(

> I agree (I didn't think about pointers, BTW). But what I meant is that we
> don't need the result to be precisely 1, but we need it to be something the
> compiler interpretes as different from zero, to match the condition. So it
> should be cleaner to always check against 0 which is also OK for pointers,
> whatever their type (according to Chip's link) :
> 
>   likely => __builtin_expect(!(x), 0)

This will break "if (likely(p)) { ... }"

> unlikely => __builtin_expect((x), 0)

This will give a warning with "if (unlikely(p)) { ... }"

-- Jamie
