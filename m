Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265103AbSJRM7w>; Fri, 18 Oct 2002 08:59:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265105AbSJRM7w>; Fri, 18 Oct 2002 08:59:52 -0400
Received: from phoenix.mvhi.com ([195.224.96.167]:7436 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S265103AbSJRM7v>; Fri, 18 Oct 2002 08:59:51 -0400
Date: Fri, 18 Oct 2002 14:05:43 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Crispin Cowan <crispin@wirex.com>
Cc: Alexander Viro <viro@math.psu.edu>, Greg KH <greg@kroah.com>,
       torvalds@transmeta.com, linux-kernel@vger.kernel.org,
       linux-security-module@wirex.com
Subject: Re: [PATCH] remove sys_security
Message-ID: <20021018140543.C1670@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Crispin Cowan <crispin@wirex.com>,
	Alexander Viro <viro@math.psu.edu>, Greg KH <greg@kroah.com>,
	torvalds@transmeta.com, linux-kernel@vger.kernel.org,
	linux-security-module@wirex.com
References: <Pine.GSO.4.21.0210180309540.18575-100000@weyl.math.psu.edu> <3DAFCE1B.805@wirex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3DAFCE1B.805@wirex.com>; from crispin@wirex.com on Fri, Oct 18, 2002 at 02:02:19AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 18, 2002 at 02:02:19AM -0700, Crispin Cowan wrote:
>     * root may not follow non-root symlinks in certain circumstances
>       (prevent some temp file attacks)
>     * non-root may not create a hard-link to root-owned files in certain
>       circumstances (prevent some other temp file attacks)
>     * may not ptrace root processes (preventing further recurrance of
>       the bugs in ptrace over the last year or so)
> 
> These policies help a lot to secure a system. But these policies also 
> break some things, so it is good that they be a loadable module, and not 
> a proposed Linux patch.

All three are actually very good examples on how your "Security"
modules work around problems instead of fixing thev actual cause.

Instead of adding hacks for tempfile races you rather want to
give each user a private namesapace and it's own /tmp (IMHO
we should also get rid of symlinks entirely, but they're in too wide
use nowdays unfortunately).

And ptrace _really_ _really_ needs to be replaced by a sane debug
interface,  like the plan9 procfs-based debugging.

But instead of attaking these causes security folks like wirex just
implement fuzzy busword mechanisms that are selable to managers.

