Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932554AbVLPXrq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932554AbVLPXrq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 18:47:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932558AbVLPXrq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 18:47:46 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.145]:56490 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932554AbVLPXrq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 18:47:46 -0500
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
In-Reply-To: <1134754519.19403.6.camel@localhost>
References: <E1En6H2-0005ok-00@w-gerrit.beaverton.ibm.com>
	 <1134754519.19403.6.camel@localhost>
Content-Type: text/plain
Date: Fri, 16 Dec 2005 18:47:44 -0500
Message-Id: <1134776864.28779.19.camel@elg11.watson.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-22) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-12-16 at 09:35 -0800, Dave Hansen wrote:
> On Thu, 2005-12-15 at 19:28 -0800, Gerrit Huizenga wrote:
> > In the pid virtualization, I would think that tasks can move between
> > containers as well,
> 
> I don't think tasks can not be permitted to move between containers.  As
> a simple exercise, imagine that you have two processes with the same
> pid, one in container A and one in container B.  You wish to have them
> both run in container A.  They can't both have the same pid.  What do
> you do?
> 

Dave, I think you meant "I don't think tasks can <strike>not</strike> be
permitted"...
Anyway, you make the constraints very clear, unless one can guarantee 
that the pidspaces don't have any overlaps in vpid usage, there is NOWAY
that we can allow this. Otherwise vpids that have been handed to 
to userspace (think sys_getpid()) need to be revoked (think coherence
here). That violates the transparency requirements.

> I've been talking a lot lately about how important filesystem isolation
> between containers is to implement containers properly.  Isolating the
> filesystem namespaces makes it much easier to do things like fs-based
> shared memory during a checkpoint/resume.  If we want to allow tasks to
> move around, we'll have to throw out this entire concept.  That means
> that a _lot_ of things get a notch closer to the too-costly-to-implement
> category.
> 

Not only that, as the example of pids already show, while at the surface
these might seem as desirable features ( particular since they came up
wrt to the CKRM discussion ), there are significant technical limitation
to these. 

-- 
Hubertus Franke <frankeh@watson.ibm.com>

