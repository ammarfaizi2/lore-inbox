Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265053AbUH1B2B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265053AbUH1B2B (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 21:28:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266013AbUH1B2B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 21:28:01 -0400
Received: from 18-165-237-24-mvl.nwc.gci.net ([24.237.165.18]:60048 "EHLO
	nevaeh-linux.org") by vger.kernel.org with ESMTP id S265053AbUH1B16
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 21:27:58 -0400
Date: Fri, 27 Aug 2004 17:26:26 -0800 (AKDT)
From: Arthur Corliss <corliss@digitalmages.com>
X-X-Sender: acorliss@bifrost.nevaeh-linux.org
To: Tim Schmielau <tim@physik3.uni-rostock.de>
cc: Andrew Morton <akpm@osdl.org>, Jay Lan <jlan@engr.sgi.com>,
       lkml <linux-kernel@vger.kernel.org>, erikj@dbear.engr.sgi.com,
       limin@engr.sgi.com, lse-tech@lists.sourceforge.net,
       =?X-UNKNOWN?Q?Ragnar_Kj=F8rstad?= <kernel@ragnark.vestdata.no>,
       Yoshitaka ISHIKAWA <y.ishikawa@soft.fujitsu.com>,
       Guillaume Thouvenin <guillaume.thouvenin@bull.net>
Subject: Re: [PATCH] new CSA patchset for 2.6.8
In-Reply-To: <Pine.LNX.4.53.0408262133190.8515@broiler.physik3.uni-rostock.de>
Message-ID: <Pine.LNX.4.58.0408271714550.1075@bifrost.nevaeh-linux.org>
References: <412D2E10.8010406@engr.sgi.com> <20040825221842.72dd83a4.akpm@osdl.org>
 <Pine.LNX.4.53.0408261821090.14826@gockel.physik3.uni-rostock.de>
 <Pine.LNX.4.58.0408261111520.22750@bifrost.nevaeh-linux.org>
 <Pine.LNX.4.53.0408262133190.8515@broiler.physik3.uni-rostock.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: -1.971 () AWL,BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Aug 2004, Tim Schmielau wrote:

> That's ok, we carefully discussed the changes to make sure no new tools
> are required ;-)

Understood, and appreciated.

> Does this mean you would want to have both in the same kernel, potentially
> turning on both at the same time?

I think that's definitely the route to go.  Not everyone needs the level of
visibility that CSA provides, so I think that with a unified data collection
methodology the users can decide for themselves what they need, and the kernel
stays in good shape with no implementation-specific bloat.

> Ok, let me summarize what I learned until now:
>
> It should be easy to combine the data collection enhancements from
> CSA and ELSA to provide a common superset of information.
>
> Output file formats vary, but might be unified if projects don't insist
> too much.

I don't think we'd necessarly want a unified accounting *file*.  BSD account
files grow pretty damned quick as it is, and that's with a lot less visibility
than if you included the extract counters that CSA provides.  Make the data
available the logging module(s) or what have you via a common struct, but let
each module decide what to actually commit to disk, and when (on job exit,
etc.).

> Main difference between CSA and ELSA on the one hand and BSD acct on the
> other is that the latter writes one record per process, while the former
> write one per job.
> With the new BSD acct v3 format, it should be possible to do per job
> accounting entirely from userspace, using pid and ppid information to
> reconstruct the process tree and some userland database for the
> pid -> job mapping. It would, however, be greatly simplified if the
> accounting records provided some kind of job id, and some indicator
> whether or not this process was the last of a job (group).
>
> CSA and ELSA might even be more lightweight since fewer accounting records
> are actually written.
>
> Sounds like it should be possible to fulfill the different needs by
> having loadable modules for the different output formats, or by a /proc
> entry that controls some aspects like whether records are written per
> job or per process.

On one hand, loadable modules would be more helpful for people doing
side-by-side comparisons of the accounting systems, but the /proc method would
be better for dynamic adjustments of a single system.  I don't think I have a
horse in this race, either way.

	--Arthur Corliss
	  Bolverk's Lair -- http://arthur.corlissfamily.org/
	  Digital Mages -- http://www.digitalmages.com/
	  "Live Free or Die, the Only Way to Live" -- NH State Motto
