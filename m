Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269367AbUINTzD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269367AbUINTzD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 15:55:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269725AbUINTyI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 15:54:08 -0400
Received: from mail5.bluewin.ch ([195.186.1.207]:14464 "EHLO mail5.bluewin.ch")
	by vger.kernel.org with ESMTP id S269367AbUINTvp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 15:51:45 -0400
Date: Tue, 14 Sep 2004 21:50:30 +0200
From: Roger Luethi <rl@hellgate.ch>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Albert Cahalan <albert@users.sf.net>, Stephen Smalley <sds@epoch.ncsc.mil>,
       Andrew Morton OSDL <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       Albert Cahalan <albert@users.sourceforge.net>,
       Paul Jackson <pj@sgi.com>, James Morris <jmorris@redhat.com>,
       Chris Wright <chrisw@osdl.org>
Subject: Re: [1/1][PATCH] nproc v2: netlink access to /proc information
Message-ID: <20040914195030.GC30827@k3.hellgate.ch>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Albert Cahalan <albert@users.sf.net>,
	Stephen Smalley <sds@epoch.ncsc.mil>,
	Andrew Morton OSDL <akpm@osdl.org>,
	lkml <linux-kernel@vger.kernel.org>,
	Albert Cahalan <albert@users.sourceforge.net>,
	Paul Jackson <pj@sgi.com>, James Morris <jmorris@redhat.com>,
	Chris Wright <chrisw@osdl.org>
References: <20040914092748.GA11238@k3.hellgate.ch> <20040914153758.GO9106@holomorphy.com> <20040914160150.GB13978@k3.hellgate.ch> <20040914163712.GT9106@holomorphy.com> <20040914171525.GA14031@k3.hellgate.ch> <20040914174325.GX9106@holomorphy.com> <20040914184517.GA2655@k3.hellgate.ch> <20040914190747.GA9106@holomorphy.com> <20040914193139.GA30827@k3.hellgate.ch> <20040914193626.GG9106@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040914193626.GG9106@holomorphy.com>
X-Operating-System: Linux 2.6.8 on i686
X-GPG-Fingerprint: 92 F4 DC 20 57 46 7B 95  24 4E 9E E7 5A 54 DC 1B
X-GPG: 1024/80E744BD wwwkeys.ch.pgp.net
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Sep 2004 12:36:26 -0700, William Lee Irwin III wrote:
> On Tue, Sep 14, 2004 at 09:31:39PM +0200, Roger Luethi wrote:
> > In published code: No access control whatsoever. In dev tree: Silently
> > dropped. Possible: Any kind of error and additional information that
> > makes sense (we have netlink messages as a transport, after all).
> 
> I'm not sure what to make of this.

I was just trying to say that anything is possible (there are no
limitations inherent to the design), but I prefer it the way it is now.
I don't feel strongly about it should something different turn out to
be the preferred method of tool authors.

> This sounds safe enough, though it's unclear how to predict what fields
> may be restricted. I suppose one doesn't try and requests one field at

Simple: The fact that a field is subject to access restrictions is part
of the field ID. You can check that nproc.h contains this:

/* Access control (unused) */
#define NPROC_PERM_MASK		0x00300000
#define NPROC_PERM_USER		0x00100000
#define NPROC_PERM_ROOT		0x00200000

So even if a tool were to discover a new, previously unknown field offered
by the kernel, it could immediately tell that access restrictions apply and
what type they are (in case you wonder, there's extra space in reserve to
cover additional types of restrictions, including some catch-all thing (say
NPROC_PERM_COMPLEX_WHICH_MEANS_YOU_HAD_BETTER_KNOW_WHAT_YOU'RE_DOING)). So
nproc can cover everything /proc does today and is ready to go way beyond
that -- should that ever be deemed a good thing.

Roger
