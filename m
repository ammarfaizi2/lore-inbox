Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269200AbUINI3K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269200AbUINI3K (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 04:29:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269193AbUINI3K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 04:29:10 -0400
Received: from mail2.bluewin.ch ([195.186.4.73]:45736 "EHLO mail2.bluewin.ch")
	by vger.kernel.org with ESMTP id S269201AbUINI2c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 04:28:32 -0400
Date: Tue, 14 Sep 2004 10:27:28 +0200
From: Roger Luethi <rl@hellgate.ch>
To: Greg Ungerer <gerg@snapgear.com>
Cc: William Lee Irwin III <wli@holomorphy.com>,
       Albert Cahalan <albert@users.sf.net>,
       Andrew Morton OSDL <akpm@osdl.org>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       Paul Jackson <pj@sgi.com>
Subject: Re: [1/1][PATCH] nproc v2: netlink access to /proc information
Message-ID: <20040914082728.GA14910@k3.hellgate.ch>
Mail-Followup-To: Greg Ungerer <gerg@snapgear.com>,
	William Lee Irwin III <wli@holomorphy.com>,
	Albert Cahalan <albert@users.sf.net>,
	Andrew Morton OSDL <akpm@osdl.org>,
	linux-kernel mailing list <linux-kernel@vger.kernel.org>,
	Paul Jackson <pj@sgi.com>
References: <20040908184130.GA12691@k3.hellgate.ch> <20040909003529.GI3106@holomorphy.com> <20040909184300.GA28278@k3.hellgate.ch> <20040909184933.GG3106@holomorphy.com> <20040909191142.GA30151@k3.hellgate.ch> <1094941556.1173.12.camel@cube> <20040914055946.GA20929@k3.hellgate.ch> <20040914061800.GD9106@holomorphy.com> <20040914062307.GF9106@holomorphy.com> <4146A228.3080705@snapgear.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4146A228.3080705@snapgear.com>
X-Operating-System: Linux 2.6.9-rc1-bk13 on i686
X-GPG-Fingerprint: 92 F4 DC 20 57 46 7B 95  24 4E 9E E7 5A 54 DC 1B
X-GPG: 1024/80E744BD wwwkeys.ch.pgp.net
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Sep 2004 17:47:52 +1000, Greg Ungerer wrote:
> Yeah, the !CONFIG_MMU code behind this is probably a little stale.
> The thinking has mostly been to keep things as much the same as
> possible, even if the fields didn't have a sensible meaning in
> non-mmu space.

With nproc, tool authors won't need to write any special-casing code
for non-MMU. All they need to handle is the possibility that a field
they ask for does not exist. (Of course it doesn't hurt if they know
how to deal with non-MMU specific fields if any exist)

> >On Tue, Sep 14, 2004 at 07:59:46AM +0200, Roger Luethi wrote:
> >
> >>>I agree with you that those specific fields should be offered for
> >>>!CONFIG_MMU. However, if for some reason they cannot carry a value
> >>>that fits the field description, they should not be offered at all. The
> >>>ambiguity of having 0 mean either "0" or "this field is not available"
> >>>is bad. Trying to read a specific field _can_ fail, and applications
> >>>had better handle that case (it's still trivial compared to having to
> >>>parse different /proc file layouts depending on the configuration).
> 
> In at least one case this is true now, as you mention for the
> VmXxx fields. But looking at these now I think we could actually
> implement most of them in a sensible way for the no-mmu case.
> Size, Exe, Lib, Stk, etc  all apply with their conventional
> meanings.

It seems we all agree on that.

What I'd object to is offering fields like Size, Exe, etc. and filling
them with values that are wrong (e.g. returning always 0 for Exe). In
such a case, the field is simply not offered and asking for it an
error.

That's not a problem we can solve for tool authors: Allowing them to
distinguish between N/A and 0 is a property of the interface, and using
that interface means knowing how to deal with that distinction.

Roger
