Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268075AbUIAVy0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268075AbUIAVy0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 17:54:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268095AbUIAVup
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 17:50:45 -0400
Received: from omx1-ext.SGI.COM ([192.48.179.11]:47270 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S268075AbUIAVsK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 17:48:10 -0400
Date: Wed, 1 Sep 2004 16:44:43 -0500
From: John Hesterberg <jh@sgi.com>
To: Guillaume Thouvenin <guillaume.thouvenin@bull.net>
Cc: Jay Lan <jlan@sgi.com>, Tim Schmielau <tim@physik3.uni-rostock.de>,
       Arthur Corliss <corliss@digitalmages.com>,
       Andrew Morton <akpm@osdl.org>, Jay Lan <jlan@engr.sgi.com>,
       lkml <linux-kernel@vger.kernel.org>, erikj@dbear.engr.sgi.com,
       limin@engr.sgi.com, lse-tech@lists.sourceforge.net,
       Ragnar Kj?rstad <kernel@ragnark.vestdata.no>,
       Yoshitaka ISHIKAWA <y.ishikawa@soft.fujitsu.com>
Subject: Re: [Lse-tech] Re: [PATCH] new CSA patchset for 2.6.8
Message-ID: <20040901214443.GA7967@sgi.com>
References: <412D2E10.8010406@engr.sgi.com> <20040825221842.72dd83a4.akpm@osdl.org> <Pine.LNX.4.53.0408261821090.14826@gockel.physik3.uni-rostock.de> <Pine.LNX.4.58.0408261111520.22750@bifrost.nevaeh-linux.org> <Pine.LNX.4.53.0408262133190.8515@broiler.physik3.uni-rostock.de> <20040827054218.GA4142@frec.bull.fr> <412F9197.4030806@sgi.com> <20040831090647.GA3441@frec.bull.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040831090647.GA3441@frec.bull.fr>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 31, 2004 at 11:06:47AM +0200, Guillaume Thouvenin wrote:
> On Fri, Aug 27, 2004 at 12:55:03PM -0700, Jay Lan wrote:
> > Please visit http://oss.sgi.com/projects/pagg/
> > The page has been updated to provide information on a per job
> > accounting project called 'job' based on PAGG.
> > 
> > There is one userspace rpm and one kernel  module for job.
> > This may provide what you are looking for. It is a mature product
> > as well. I am sure Limin(job) and Erik(pagg) would appreciate any
> > input you can provide to make 'job' more useful.
> 
>   I have a question about job. If I understand how it works, you can not
> add a process in a job. I mean when you start a session, a container is 
> created and it's the only way to create it.

Right, that's the current implementation.  Any privileged process can
create a job, though, it doesn't *have* to be at the start of a session.
I believe job is currently hardwired that the initial member process is
the creator, and the only other way in is via inheritance, and there's
no way out of the job other than exiting or creating your own job.

> If I'm right, I think that it could be interesting to add a process
> using ioctl and /proc interface. 

We're planning on changing that interface, but I think your question
applies regardless of what interface is used.

> For example, if I want to know how resources are used by a
> compilation, I need to add the process gcc in a container. Any
> comments? 
>
> Best,
> Guillaume

It sounds like a slightly different kind of job.

The gcc process should already be in a job via it's parent.
If it's already in a job, we don't let it out, as jobs are designed to
be inescapable so that users can't sneak processes outside their job.
If the only client of job is accounting, that might not be required.
Maybe as long as they become a member of another job, and the usage is
tracked, that would be OK.  I'm not sure what that would do to
the current CSA tools, though.

On IRIX, I think jobs are also used to do resource limits, and that's
probably where the hard requirement for jobs being inescapable came from.

The ISP/ASP non-acct uses of job would probably want it to be inescapable.

Different inheritance and creation policies could be implemented
in job.  Or, since it's just a loadable module, different job modules
could be written to implement different styles of job as are required
for different uses.

John
