Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269330AbUINTNO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269330AbUINTNO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 15:13:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269466AbUINTIx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 15:08:53 -0400
Received: from fw.osdl.org ([65.172.181.6]:51622 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269688AbUINTF2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 15:05:28 -0400
Date: Tue, 14 Sep 2004 12:05:09 -0700
From: Chris Wright <chrisw@osdl.org>
To: Chris Wright <chrisw@osdl.org>, William Lee Irwin III <wli@holomorphy.com>,
       Albert Cahalan <albert@users.sourceforge.net>,
       Stephen Smalley <sds@epoch.ncsc.mil>,
       Andrew Morton OSDL <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       Paul Jackson <pj@sgi.com>, James Morris <jmorris@redhat.com>
Subject: Re: [1/1][PATCH] nproc v2: netlink access to /proc information
Message-ID: <20040914120509.I1924@build.pdx.osdl.net>
References: <20040914064403.GB20929@k3.hellgate.ch> <20040914071058.GH9106@holomorphy.com> <20040914075508.GA10880@k3.hellgate.ch> <20040914080132.GJ9106@holomorphy.com> <20040914092748.GA11238@k3.hellgate.ch> <20040914153758.GO9106@holomorphy.com> <20040914160150.GB13978@k3.hellgate.ch> <20040914163712.GT9106@holomorphy.com> <20040914113736.H1924@build.pdx.osdl.net> <20040914185524.GB2655@k3.hellgate.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20040914185524.GB2655@k3.hellgate.ch>; from rl@hellgate.ch on Tue, Sep 14, 2004 at 08:55:25PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Roger Luethi (rl@hellgate.ch) wrote:
> On Tue, 14 Sep 2004 11:37:36 -0700, Chris Wright wrote:
> > Canonical example is access(2) followed by open(2), not really relevant
> > in this case.  However, exec setuid root app...when do you check, and
> > when to you fill in data to send back to user?  For /proc, this type of
> > check happens often (see things like may_ptrace_attach and
> > task_dumpable in fs/proc/base.c).
> 
> For nproc, the procedure looks like this: A tool send(2)s a request,
> credentials are attached to skb. Based on said credentials, the kernel
> is free to provide (netlink_unicast to originating socket) or withhold
> information. In this regard, nproc works like other netlink interfaces.

Understood.  Question is, if the request is for data that's associated
with a task that is in the middle of an execve(setuid_root_app), does
the credential-check/skb-fill for response happen atomically w.r.t. said
execve?  IOW, is it possible to pass credential check, then fill data
that's become sensitive since the check happened?

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
