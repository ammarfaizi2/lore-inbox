Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263290AbUAISeg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jan 2004 13:34:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263370AbUAISeg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jan 2004 13:34:36 -0500
Received: from wombat.indigo.net.au ([202.0.185.19]:55313 "EHLO
	wombat.indigo.net.au") by vger.kernel.org with ESMTP
	id S263290AbUAISee (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jan 2004 13:34:34 -0500
Date: Sat, 10 Jan 2004 02:32:12 +0800 (WST)
From: Ian Kent <raven@themaw.net>
X-X-Sender: <raven@wombat.indigo.net.au>
To: "H. Peter Anvin" <hpa@zytor.com>
cc: Mike Waychison <Michael.Waychison@Sun.COM>,
       autofs mailing list <autofs@linux.kernel.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [autofs] [RFC] Towards a Modern Autofs
In-Reply-To: <3FFD9498.6030905@zytor.com>
Message-ID: <Pine.LNX.4.33.0401100223130.21972-100000@wombat.indigo.net.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam, SpamAssassin (score=-5.5, required 8, AWL,
	BAYES_10, EMAIL_ATTRIBUTION, IN_REP_TO, QUOTED_EMAIL_TEXT,
	REPLY_WITH_QUOTES, USER_AGENT_PINE)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Jan 2004, H. Peter Anvin wrote:

> Ian Kent wrote:
> >
> > If wildcard map entries are not in autofs v3 then Jeremy implemented this
> > in v4.
> >
>
> v3 has had wildcard map entries and substitutions for a very, very, very
> long time... it was a v2 feature, in fact.
>
> > And yes the host map is basically a program map and that's all. Worse, as
> > pointed out in the paper it mounts everything under it. This is a source
> > of stress for mount and umount. I have put in a fair bit of time on ugly
> > hacks to work around this. This same problem is also evident in startup
> > and shutdown for master maps with a good number of entries (~50 or more).
> > A consequence of the current multiple daemon approach.
>
> This is why one wants to implement a mount tree with "direct mount
> pads"; which also means keeping some state in the daemon.
>
> For example, let's say one has a mount tree like:
>
> /foo		server1:/export/foo \
> /foo/bar	server1:/export/bar \
> /bar		server2:/export/bar
>
> ... then you actually have four diffenent filesystems involved: first,
> some kind of "scaffolding" (this can be part of the autofs filesystem
> itself or a ramfs) that hold the "foo" and "bar" directories, and then
> foo, foo/bar, and bar.
>
> Consider the following implementation: when one encounters the above,
> the daemon stashes this away as an already-encountered map entry (in
> case the map entries change, we don't want to be inconsistent), creates
> a ramfs for the scaffolding, creates the "foo" and "bar" subdirectories
> and mount-traps "foo" and "bar".  Then it releases userspace.  When it
> encounters an access on "foo", it gets invoked again, looks it up in its
> "partial mounts" state, then mounts "foo" and mount-traps "foo/bar",
> then releases userspace.
>

Umm. The cross filesystem problem again.

This may sound a little silly but it may be able to be done using
stackable filesystem methods (aka. Zadok et. al.). I'm thinking of an
autofs filesystem stacked on a host filesystem. The dentrys corresponding
to mount points marked in some way and the mount occuring under it, on top
of the host filesystem. Yes I know it sounds ugly but maybe it's not.
Maybe it's actually quite simple. I can't give an opinion yet as I'm still
thinking it through and haven't done any feasibility. However, this
approach would lend itself to providing autofs filesystem transparency. A
requirement as yet not discussed.

Ian




