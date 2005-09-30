Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965015AbVI3Jjk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965015AbVI3Jjk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Sep 2005 05:39:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965016AbVI3Jjk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Sep 2005 05:39:40 -0400
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:6570 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP id S965015AbVI3Jjk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Sep 2005 05:39:40 -0400
Date: Fri, 30 Sep 2005 11:39:24 +0200 (CEST)
From: Simon Derr <simon.derr@bull.net>
X-X-Sender: derr@localhost.localdomain
To: KUROSAWA Takahiro <kurosawa@valinux.co.jp>
Cc: Paul Jackson <pj@sgi.com>, taka@valinux.co.jp, magnus.damm@gmail.com,
       dino@in.ibm.com, linux-kernel@vger.kernel.org,
       ckrm-tech@lists.sourceforge.net
Subject: Re: [ckrm-tech] Re: [PATCH 1/3] CPUMETER: add cpumeter framework to
 the CPUSETS
In-Reply-To: <20050929025328.E4BFC70046@sv1.valinux.co.jp>
Message-ID: <Pine.LNX.4.58.0509301117500.28042@localhost.localdomain>
References: <20050908225539.0bc1acf6.pj@sgi.com> <20050909.203849.33293224.taka@valinux.co.jp>
 <20050909063131.64dc8155.pj@sgi.com> <20050910.161145.74742186.taka@valinux.co.jp>
 <20050910015209.4f581b8a.pj@sgi.com> <20050926093432.9975870043@sv1.valinux.co.jp>
 <20050927013751.47cbac8b.pj@sgi.com> <20050927113902.C78A570046@sv1.valinux.co.jp>
 <20050927084905.7d77bdde.pj@sgi.com> <20050928062146.6038E70041@sv1.valinux.co.jp>
 <20050928000839.1d659bfb.pj@sgi.com> <20050928075331.0408A70041@sv1.valinux.co.jp>
 <20050928094932.43a1f650.pj@sgi.com> <20050929025328.E4BFC70046@sv1.valinux.co.jp>
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 30/09/2005 11:52:57,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 30/09/2005 11:52:59,
	Serialize complete at 30/09/2005 11:52:59
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 29 Sep 2005, KUROSAWA Takahiro wrote:

> > Oh I think not.  My primary motivation in pushing on this point
> > of the design was to allow CPUSET 2a and 2b to have a smaller
> > cpumask than CPUSET 1a.  This is used for example to allow a job
> > that is running in 1a to setup two child cpusets, 2a and 2b,
> > to run two subtasks that are constrained to smaller portions of
> > the CPUs allowed to the job in 1a.
>
> Maybe I still misunderstand your idea.
> The guarantee assigned to CPUSET 1a might not be satisfied if
> tasks are attached to CPUSET 2a only and no tasks are attached to
> CPUSET 1a nor CPUSET 2b.  Does your idea leave as it is because
> the user sets up CPUSETs like that?

Hi Takahiro-san

It seems to me that this "guarantee" can only be guaranteed if the owner
of cpuset 1a:
-runs enough tasks to use all the cpus of cpuset 1a
-does not tamper with the scheduler decisions by creating other cpusets
inside cpuset 1a, or by using sched_setaffinity().

Outside of this, he accepts to get less cpu than "guaranteed".
Sounds acceptable to me.

	Simon.

