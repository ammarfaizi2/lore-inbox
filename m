Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268993AbUINGAz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268993AbUINGAz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 02:00:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269038AbUINGAz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 02:00:55 -0400
Received: from mail6.bluewin.ch ([195.186.4.229]:28565 "EHLO mail6.bluewin.ch")
	by vger.kernel.org with ESMTP id S268993AbUINGAx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 02:00:53 -0400
Date: Tue, 14 Sep 2004 07:59:46 +0200
From: Roger Luethi <rl@hellgate.ch>
To: Albert Cahalan <albert@users.sf.net>
Cc: William Lee Irwin III <wli@holomorphy.com>,
       Andrew Morton OSDL <akpm@osdl.org>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       Paul Jackson <pj@sgi.com>
Subject: Re: [1/1][PATCH] nproc v2: netlink access to /proc information
Message-ID: <20040914055946.GA20929@k3.hellgate.ch>
Mail-Followup-To: Albert Cahalan <albert@users.sf.net>,
	William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton OSDL <akpm@osdl.org>,
	linux-kernel mailing list <linux-kernel@vger.kernel.org>,
	Paul Jackson <pj@sgi.com>
References: <20040908184028.GA10840@k3.hellgate.ch> <20040908184130.GA12691@k3.hellgate.ch> <20040909003529.GI3106@holomorphy.com> <20040909184300.GA28278@k3.hellgate.ch> <20040909184933.GG3106@holomorphy.com> <20040909191142.GA30151@k3.hellgate.ch> <1094941556.1173.12.camel@cube>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1094941556.1173.12.camel@cube>
X-Operating-System: Linux 2.6.9-rc1-mm4nproc on i686
X-GPG-Fingerprint: 92 F4 DC 20 57 46 7B 95  24 4E 9E E7 5A 54 DC 1B
X-GPG: 1024/80E744BD wwwkeys.ch.pgp.net
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 11 Sep 2004 18:25:56 -0400, Albert Cahalan wrote:
> > One nitpick: As vmexe and vmlib are always 0 for !CONFIG_MMU, we should
> > ifdef them out of the list of offered fields for that configuration (and
> > maybe in nproc_ps_field as well).
> 
> No. First of all, I think they can be offered. Until proven
> otherwise, I'll assume that the !CONFIG_MMU case is buggy.

I agree with you that those specific fields should be offered for
!CONFIG_MMU. However, if for some reason they cannot carry a value
that fits the field description, they should not be offered at all. The
ambiguity of having 0 mean either "0" or "this field is not available"
is bad. Trying to read a specific field _can_ fail, and applications
had better handle that case (it's still trivial compared to having to
parse different /proc file layouts depending on the configuration).

> mean that fewer apps can run on !CONFIG_MMU boxes. It's
> same problem as "All the world's a VAX". It's better that
> the apps work; an author working on a Pentium 4 Xeon is
> likely to write code that relies on the fields and might
> not really understand what "no MMU" is all about.

The presumed wrong assumptions underlying broken tools of the future
are not a good base for designing a new interface. My interest is in
making it easy to write correct applications (or in fixing broken apps
that won't work, say, on !CONFIG_MMU systems).

Roger
