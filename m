Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262248AbVGWAXp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262248AbVGWAXp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Jul 2005 20:23:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262249AbVGWAXp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Jul 2005 20:23:45 -0400
Received: from sigma957.CIS.McMaster.CA ([130.113.64.83]:44460 "EHLO
	sigma957.cis.mcmaster.ca") by vger.kernel.org with ESMTP
	id S262248AbVGWAXo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Jul 2005 20:23:44 -0400
Date: Fri, 22 Jul 2005 20:23:32 -0400 (EDT)
From: Mark Hahn <hahn@physics.mcmaster.ca>
X-X-Sender: hahn@coffee.psychology.mcmaster.ca
To: Matthew Helsley <matthltc@us.ibm.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
       CKRM-Tech <ckrm-tech@lists.sourceforge.net>
Subject: Re: [ckrm-tech] Re: 2.6.13-rc3-mm1 (ckrm)
In-Reply-To: <1122063487.5242.255.camel@stark>
Message-ID: <Pine.LNX.4.44.0507221830350.29479-100000@coffee.psychology.mcmaster.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-PMX-Version-Mac: 4.7.1.128075, Antispam-Engine: 2.0.3.2, Antispam-Data: 2005.7.22.31
X-PerlMx-Spam: Gauge=IIIIIII, Probability=7%, Report='__CT 0, __CT_TEXT_PLAIN 0, __HAS_MSGID 0, __MIME_TEXT_ONLY 0, __MIME_VERSION 0, __SANE_MSGID 0'
X-Spam-Flag: NO
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > actually, let me also say that CKRM is on a continuum that includes 
> > current (global) /proc tuning for various subsystems, ulimits, and 
> > at the other end, Xen/VMM's.  it's conceivable that CKRM could wind up
> > being useful and fast enough to subsume the current global and per-proc
> > tunables.  after all, there are MANY places where the kernel tries to 
> > maintain some sort of context to allow it to tune/throttle/readahead
> > based on some process-linked context.  "embracing and extending"
> > those could make CKRM attractive to people outside the mainframe market.
> 
> 	Seems like an excellent suggestion to me! Yeah, it may be possible to
> maintain the context the kernel keeps on a per-class basis instead of
> globally or per-process. 

right, but are the CKRM people ready to take this on?  for instance,
I just grepped 'throttle' in kernel/mm and found a per-task RM in 
page-writeback.c.  it even has a vaguely class-oriented logic, since
it exempts RT tasks.  if CKRM can become a way to make this stuff 
cleaner and more effective (again, for normal tasks), then great.
but bolting on a big new different, intrusive mechanism that slows
down all normal jobs by 3% just so someone can run 10K mostly-idle
guests on a giant Power box, well, that's gross.

> The real question is what constitutes a useful
> "extension" :).

if CKRM is just extensions, I think it should be an external patch.
if it provides a path towards unifying the many disparate RM mechanisms
already in the kernel, great!

> 	I was thinking that per-class nice values might be a good place to
> start as well. One advantage of per-class as opposed to per-process nice
> is the class is less transient than the process since its lifetime is
> determined solely by the system administrator.

but the Linux RM needs to subsume traditional Unix process groups,
and inherited nice/schd class, and even CAP_ stuff.  I think CKRM
could start to do this, since classes are very general.
but merely adding a new, incompatible feature is just Not A Good Idea.

regards, mark hahn.

