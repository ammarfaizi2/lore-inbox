Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262880AbTEGGHd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 02:07:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262883AbTEGGHd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 02:07:33 -0400
Received: from phoenix.infradead.org ([195.224.96.167]:3593 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S262880AbTEGGHb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 02:07:31 -0400
Date: Wed, 7 May 2003 07:20:02 +0100
From: Christoph Hellwig <hch@infradead.org>
To: "David S. Miller" <davem@redhat.com>
Cc: dwmw2@infradead.org, thomas@horsten.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.4.21-rc1: byteorder.h breaks with __STRICT_ANSI__ defined (trivial)
Message-ID: <20030507072002.A7424@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	"David S. Miller" <davem@redhat.com>, dwmw2@infradead.org,
	thomas@horsten.com, linux-kernel@vger.kernel.org
References: <1052255946.7532.66.camel@imladris.demon.co.uk> <20030506.200638.78728404.davem@redhat.com> <20030507062613.A5318@infradead.org> <20030506.220714.35679546.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030506.220714.35679546.davem@redhat.com>; from davem@redhat.com on Tue, May 06, 2003 at 10:07:14PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 06, 2003 at 10:07:14PM -0700, David S. Miller wrote:
> This doesn't even consider the case where the ipsec-tools copy of the
> headers becomes out of date with the kernel copy.  This isn't a
> theoretical issue, this problem is real.
> 
> For example, I just changed the values of a few SADB_EALG_* values in
> pfkeyv2.h.  Now ipsec-tools is effectively broken.  Oops, when will
> the copy in ipsec-tools get updated?

You just broke the userland ABI which must not happen.  at all.  That's
why userland having older headers is fine.

> What about applications, ie. normal ones, that want to pass IPSEC
> policies into the kernel via the socket options we have that allows
> per-socket IPSEC rules to be specified?  The copy in ipsec-tools
> doesn't help them at all.

That's why we want the glibc-kernheader package.  Or even better
a package of headers that can be used by the kernel and userland,
but this would require people to properly sort out kernel header
functionality like internal structures and prototypes/inlines from
the actual ABI-relevant contents.  The networking headers currently
are very bad on this.

