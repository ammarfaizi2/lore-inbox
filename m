Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269722AbUINVUY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269722AbUINVUY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 17:20:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269669AbUINVTw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 17:19:52 -0400
Received: from mail5.bluewin.ch ([195.186.1.207]:10159 "EHLO mail5.bluewin.ch")
	by vger.kernel.org with ESMTP id S266186AbUINVNY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 17:13:24 -0400
Date: Tue, 14 Sep 2004 23:12:19 +0200
From: Roger Luethi <rl@hellgate.ch>
To: Chris Wright <chrisw@osdl.org>
Cc: William Lee Irwin III <wli@holomorphy.com>,
       Albert Cahalan <albert@users.sourceforge.net>,
       Stephen Smalley <sds@epoch.ncsc.mil>,
       Andrew Morton OSDL <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       Paul Jackson <pj@sgi.com>, James Morris <jmorris@redhat.com>
Subject: Re: [1/1][PATCH] nproc v2: netlink access to /proc information
Message-ID: <20040914211219.GA7104@k3.hellgate.ch>
Mail-Followup-To: Chris Wright <chrisw@osdl.org>,
	William Lee Irwin III <wli@holomorphy.com>,
	Albert Cahalan <albert@users.sourceforge.net>,
	Stephen Smalley <sds@epoch.ncsc.mil>,
	Andrew Morton OSDL <akpm@osdl.org>,
	lkml <linux-kernel@vger.kernel.org>, Paul Jackson <pj@sgi.com>,
	James Morris <jmorris@redhat.com>
References: <20040914071058.GH9106@holomorphy.com> <20040914075508.GA10880@k3.hellgate.ch> <20040914080132.GJ9106@holomorphy.com> <20040914092748.GA11238@k3.hellgate.ch> <20040914153758.GO9106@holomorphy.com> <20040914160150.GB13978@k3.hellgate.ch> <20040914163712.GT9106@holomorphy.com> <20040914113736.H1924@build.pdx.osdl.net> <20040914185524.GB2655@k3.hellgate.ch> <20040914120509.I1924@build.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040914120509.I1924@build.pdx.osdl.net>
X-Operating-System: Linux 2.6.8 on i686
X-GPG-Fingerprint: 92 F4 DC 20 57 46 7B 95  24 4E 9E E7 5A 54 DC 1B
X-GPG: 1024/80E744BD wwwkeys.ch.pgp.net
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Sep 2004 12:05:09 -0700, Chris Wright wrote:
> Understood.  Question is, if the request is for data that's associated
> with a task that is in the middle of an execve(setuid_root_app), does
> the credential-check/skb-fill for response happen atomically w.r.t. said
> execve?  IOW, is it possible to pass credential check, then fill data
> that's become sensitive since the check happened?

It shouldn't be once we implement access control. I don't pretend to know
what the best way is to prevent that. Checking several times just shrinks
the race window, so I suppose we'd have to lock the source data structures
down prior to checking credentials and copying data.

Roger
