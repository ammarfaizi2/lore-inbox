Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269387AbUINS7L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269387AbUINS7L (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 14:59:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269362AbUINS5e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 14:57:34 -0400
Received: from mail2.bluewin.ch ([195.186.4.73]:45242 "EHLO mail2.bluewin.ch")
	by vger.kernel.org with ESMTP id S269330AbUINS41 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 14:56:27 -0400
Date: Tue, 14 Sep 2004 20:55:25 +0200
From: Roger Luethi <rl@hellgate.ch>
To: Chris Wright <chrisw@osdl.org>
Cc: William Lee Irwin III <wli@holomorphy.com>,
       Albert Cahalan <albert@users.sourceforge.net>,
       Stephen Smalley <sds@epoch.ncsc.mil>,
       Andrew Morton OSDL <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       Paul Jackson <pj@sgi.com>, James Morris <jmorris@redhat.com>
Subject: Re: [1/1][PATCH] nproc v2: netlink access to /proc information
Message-ID: <20040914185524.GB2655@k3.hellgate.ch>
Mail-Followup-To: Chris Wright <chrisw@osdl.org>,
	William Lee Irwin III <wli@holomorphy.com>,
	Albert Cahalan <albert@users.sourceforge.net>,
	Stephen Smalley <sds@epoch.ncsc.mil>,
	Andrew Morton OSDL <akpm@osdl.org>,
	lkml <linux-kernel@vger.kernel.org>, Paul Jackson <pj@sgi.com>,
	James Morris <jmorris@redhat.com>
References: <1094942212.1174.20.camel@cube> <20040914064403.GB20929@k3.hellgate.ch> <20040914071058.GH9106@holomorphy.com> <20040914075508.GA10880@k3.hellgate.ch> <20040914080132.GJ9106@holomorphy.com> <20040914092748.GA11238@k3.hellgate.ch> <20040914153758.GO9106@holomorphy.com> <20040914160150.GB13978@k3.hellgate.ch> <20040914163712.GT9106@holomorphy.com> <20040914113736.H1924@build.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040914113736.H1924@build.pdx.osdl.net>
X-Operating-System: Linux 2.6.8 on i686
X-GPG-Fingerprint: 92 F4 DC 20 57 46 7B 95  24 4E 9E E7 5A 54 DC 1B
X-GPG: 1024/80E744BD wwwkeys.ch.pgp.net
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Sep 2004 11:37:36 -0700, Chris Wright wrote:
> * William Lee Irwin III (wli@holomorphy.com) wrote:
> > On Tue, 14 Sep 2004 08:37:58 -0700, William Lee Irwin III wrote:
> > >> No, in general races of the form "permissions were altered after I
> > >> checked them" can happen.
> > 
> > On Tue, Sep 14, 2004 at 06:01:50PM +0200, Roger Luethi wrote:
> > > Can you make an example? Some scenario where this would be important?
> > 
> > Not particularly. It largely means poorly-coded apps may report gibberish.
> 
> Canonical example is access(2) followed by open(2), not really relevant
> in this case.  However, exec setuid root app...when do you check, and
> when to you fill in data to send back to user?  For /proc, this type of
> check happens often (see things like may_ptrace_attach and
> task_dumpable in fs/proc/base.c).

For nproc, the procedure looks like this: A tool send(2)s a request,
credentials are attached to skb. Based on said credentials, the kernel
is free to provide (netlink_unicast to originating socket) or withhold
information. In this regard, nproc works like other netlink interfaces.

Roger
