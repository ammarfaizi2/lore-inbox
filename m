Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131457AbRCWUol>; Fri, 23 Mar 2001 15:44:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131455AbRCWUoX>; Fri, 23 Mar 2001 15:44:23 -0500
Received: from [193.120.224.170] ([193.120.224.170]:49814 "EHLO
	florence.itg.ie") by vger.kernel.org with ESMTP id <S131446AbRCWUnT>;
	Fri, 23 Mar 2001 15:43:19 -0500
Date: Fri, 23 Mar 2001 20:41:01 +0000 (GMT)
From: Paul Jakma <paulj@itg.ie>
To: Szabolcs Szakacsits <szaka@f-secure.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Stephen Clouse <stephenc@theiqgroup.com>,
        Guest section DW <dwguest@win.tue.nl>,
        Rik van Riel <riel@conectiva.com.br>,
        "Patrick O'Rourke" <orourke@missioncriticallinux.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Prevent OOM from killing init
In-Reply-To: <Pine.LNX.4.30.0103232124120.13864-100000@fs131-224.f-secure.com>
Message-ID: <Pine.LNX.4.33.0103232026310.31380-100000@rossi.itg.ie>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Mar 2001, Szabolcs Szakacsits wrote:

> About the "use resource limits!". Yes, this is one solution. The
> *expensive* solution (admin time, worse resource utilization, etc).

traditional user limits have worse resource utilisation? think what
kind of utilisation a guaranteed allocation system would have. instead
of 128MB, you'd need maybe a GB of RAM and many many GB of swap for
most systems.

some hopefully non-ranting points:

- setting up limits on a RH system takes 1 minute by editing
/etc/security/limits.conf.

- Rik's current oom killer may not do a good job now, but it's
impossible for it to do a /perfect/ job without implementing
kernel/esp.c.

- with limits set you will have:
 - /possible/ underutilisation on some workloads.
 - chance of hitting Rik's OOM killer reduced to almost nothing.

no matter how good or bad Rik's killer is, i'd much rather set limits
and just about /never/ have it invoked.

more beancounting will make limits more useful (eg global?) and maybe
dists can start setting up some kind of limits by default at install
time based on the RAM installed and whether user selected
server/workstation/etc.. install.

Then hopefully we can be a little less concerned about how close Rik
gets to the impossible task of implementing esp.c.

>         Szaka

--paulj

