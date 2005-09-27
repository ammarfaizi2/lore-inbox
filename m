Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964937AbVI0Nnn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964937AbVI0Nnn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 09:43:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964939AbVI0Nnn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 09:43:43 -0400
Received: from [212.76.81.47] ([212.76.81.47]:33540 "EHLO raad.intranet")
	by vger.kernel.org with ESMTP id S964937AbVI0Nnn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 09:43:43 -0400
From: Al Boldi <a1426z@gawab.com>
To: Neil Horman <nhorman@tuxdriver.com>
Subject: Re: Resource limits
Date: Tue, 27 Sep 2005 16:42:07 +0300
User-Agent: KMail/1.5
Cc: Matthew Helsley <matthltc@us.ibm.com>, linux-kernel@vger.kernel.org
References: <200509251712.42302.a1426z@gawab.com> <200509270808.21821.a1426z@gawab.com> <20050927120840.GA5947@hmsreliant.homelinux.net>
In-Reply-To: <20050927120840.GA5947@hmsreliant.homelinux.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509271642.07864.a1426z@gawab.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Horman wrote:
> On Tue, Sep 27, 2005 at 08:08:21AM +0300, Al Boldi wrote:
> > Neil Horman wrote:
> > > On Mon, Sep 26, 2005 at 11:26:10PM +0300, Al Boldi wrote:
> > > > Neil Horman wrote:
> > > > > On Mon, Sep 26, 2005 at 08:32:14PM +0300, Al Boldi wrote:
> > > > > > Neil Horman wrote:
> > > > > > > On Mon, Sep 26, 2005 at 05:18:17PM +0300, Al Boldi wrote:
> > > > > > > > Rik van Riel wrote:
> > > > > > > > > On Sun, 25 Sep 2005, Al Boldi wrote:
> > > > > > > > > > Too many process forks and your system may crash.
> > > > > > > > > > This can be capped with threads-max, but may lead you
> > > > > > > > > > into a lock-out.
> > > > > > > > > >
> > > > > > > > > > What is needed is a soft, hard, and a special emergency
> > > > > > > > > > limit that would allow you to use the resource for a
> > > > > > > > > > limited time to circumvent a lock-out.
> > > > > > > > >
> > > > > > > > > How would you reclaim the resource after that limited time
> > > > > > > > > is over ?  Kill processes?
> > > > > > > >
> > > > > > > > That's one way,  but really, the issue needs some deep
> > > > > > > > thought. Leaving Linux exposed to a lock-out is rather
> > > > > > > > frightening.
> > > > > > >
> > > > > > > What exactly is it that you're worried about here?
> > > > > >
> > > > > > Think about a DoS attack.
> > > > >
> > > > > Be more specific.  Are you talking about a fork bomb, a ICMP
> > > > > flood, what?
> >
> > Consider this dilemma:
> > Runaway proc/s hit the limit.
> > Try to kill some and you are denied due to the resource limit.
> > Use some previously running app like top, hope it hasn't been killed by
> > some OOM situation, try killing some procs and another one takes it's
> > place because of the runaway situation.
> > Raise the limit, and it gets filled by the runaways.
> > You are pretty much stuck.
>
> Not really, this is the sort of thing ulimit is meant for.  To keep
> processes from any one user from running away.  It lets you limit the
> damage it can do, until such time as you can control it and fix the
> runaway application.

threads-max = 1024
ulimit = 100 forks
11 runaway procs hitting the threads-max limit

This example is extreme, but it's possible, and there should be a safe and 
easy way out.

What do you think?

Thanks!
--
Al

