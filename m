Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264889AbUAFVwM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jan 2004 16:52:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265346AbUAFVwM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jan 2004 16:52:12 -0500
Received: from brmea-mail-3.Sun.COM ([192.18.98.34]:23460 "EHLO
	brmea-mail-3.sun.com") by vger.kernel.org with ESMTP
	id S264889AbUAFVwJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jan 2004 16:52:09 -0500
Date: Tue, 6 Jan 2004 13:50:18 -0800
From: Tim Hockin <thockin@Sun.COM>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Mike Waychison <Michael.Waychison@Sun.COM>,
       autofs mailing list <autofs@linux.kernel.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [autofs] [RFC] Towards a Modern Autofs
Message-ID: <20040106215018.GA911@sun.com>
Reply-To: thockin@Sun.COM
References: <3FFB12AD.6010000@sun.com> <3FFB223A.8000606@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FFB223A.8000606@zytor.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 06, 2004 at 01:01:46PM -0800, H. Peter Anvin wrote:
> Finally, throwing out the daemon is a huge step backwards.  Most of the
> problems with autofs v3 (and to a lesser extent v4) are due to the
> *lack* of state in userspace (the current daemon is mostly stateless);
> putting additional state in userspace would be a benefit in my experience.

Can you maybe share some details?  I think this deign moves MORE state to
userspace (expiry aside).  The "state" in kernel is really mostly sent back
to userspace.  No more passing pipes into the kernel (state) or tracking the
pgid of the daemon (state).

> Pardon me for sounding harsh, but I'm seriously sick of the oft-repeated
> idiocy that effectively boils down to "the daemon can die and would lose
> its state, so let's put it all in the kernel."  A dead daemon is a
> painful recovery, admitted.  It is also a THIS SHOULD NOT HAPPEN

But it *does* happen.

> condition.  By cramming it into the kernel, you're in fact making the
> system less stable, not more, because the kernel being tainted with
> faulty code is a total system malfunction; a crashed userspace daemon is

I don't think this design crams anything into the kernel.  It doesn't put a
whole lot more into the kernel than is currently in there (expiry and new
mount stuff, aside).  All the work still happens in userland.

The daemon as it stands does NOT handle namespaces, does NOT handle expiry
well, and is a pretty sad copy of an old design.

> "merely" a messy cleanup.  In practice, the autofs daemon does not die
> unless a careless system administrator kills it.  It is a non-problem.

I have some customers I'd love to send to you, if you really think that's
true.
