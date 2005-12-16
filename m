Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750834AbVLPXkQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750834AbVLPXkQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 18:40:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751171AbVLPXkP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 18:40:15 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.144]:25305 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750834AbVLPXkN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 18:40:13 -0500
Subject: Re: [ckrm-tech] Re: [RFC][patch 00/21] PID Virtualization:
	Overview and Patches
From: Hubertus Franke <frankeh@watson.ibm.com>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: Gerrit Huizenga <gh@us.ibm.com>, Matt Helsley <matthltc@us.ibm.com>,
       CKRM-Tech <ckrm-tech@lists.sourceforge.net>,
       LKML <linux-kernel@vger.kernel.org>,
       LSE <lse-tech@lists.sourceforge.net>, vserver@list.linux-vserver.org,
       Andrew Morton <akpm@osdl.org>, Rik van Riel <riel@redhat.com>,
       pagg@oss.sgi.com
In-Reply-To: <1134767454.19403.12.camel@localhost>
References: <E1EnMSU-0004pH-00@w-gerrit.beaverton.ibm.com>
	 <1134767454.19403.12.camel@localhost>
Content-Type: text/plain
Date: Fri, 16 Dec 2005 18:40:04 -0500
Message-Id: <1134776404.28779.12.camel@elg11.watson.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-22) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-12-16 at 13:10 -0800, Dave Hansen wrote:
> On Fri, 2005-12-16 at 12:45 -0800, Gerrit Huizenga wrote:
> > Interesting...  So how to tasks get *into* a container?
> 
> Only by inheritance.  

That is only true today. There is no reason (other then introducing
some heavy code complexity (haven't thought about that) 
why we can't at some point move a process group/tree into a container.
The reason for this is that for the global container V=R in pid space
terms (read the vpid=realpid). Moving an entire group into a container
requires to assign new kernel pids to each task, while keeping the 
the vpid part constant. Lots of kpid related references though..
Don't know whether that's worth the trouble, particularly at this stage.

> 
> > And can they ever get back "out" of a container?
> 
> No.  Think of the pids again.  Even the "outside" of a container, things
> like the real init, have to have unique pids.  What if the process's pid
> is the same as one in use in the default container?

Correct..look at my answer above  moving from global to container can be
accomplished because in a fresh container all pids are available, so we
can simply reoccupy the same vpids in the new pidspace. This keeps all
user level "references" and pid values valid.
The only way we could EVER go back is if we could guarantee that the
pids the global space are free, hence they would have to be reserved.
NOWAY.... particularly if migration is involved later on..

> 
> > Are most processes on the system
> > initially not in a container?  And then they can be stuffed in a container?
> > And then containers can be moved around or be isolated from each other?
> 
> The current idea is that processes are assigned at fork-time.  The
> isolation is for the lifetime of the process.
> 
> > And, is pid virtualization the point where this happens?  Or is that
> > a slightly higher level?  In other words, is pid virtualization the
> > full implementation of container isolation?  Or is it a significant
> > element on which additional policy, restrictions, and usage models
> > can be built?
> 
> pid virtualization is simply the one that's easiest to understand, and
> the one that demonstrates the largest number of issues.  It is a small
> piece of the puzzle, but an important one.
> 

Ditto..

> -- Dave
> 
> 
-- 
Hubertus Franke <frankeh@watson.ibm.com>

