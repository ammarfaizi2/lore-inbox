Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750887AbVI2Cxb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750887AbVI2Cxb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 22:53:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751173AbVI2Cxb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 22:53:31 -0400
Received: from sv1.valinux.co.jp ([210.128.90.2]:19155 "EHLO sv1.valinux.co.jp")
	by vger.kernel.org with ESMTP id S1750887AbVI2Cxa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 22:53:30 -0400
Date: Thu, 29 Sep 2005 11:53:28 +0900
From: KUROSAWA Takahiro <kurosawa@valinux.co.jp>
To: Paul Jackson <pj@sgi.com>
Cc: taka@valinux.co.jp, magnus.damm@gmail.com, dino@in.ibm.com,
       linux-kernel@vger.kernel.org, ckrm-tech@lists.sourceforge.net
Subject: Re: [ckrm-tech] Re: [PATCH 1/3] CPUMETER: add cpumeter framework to
 the CPUSETS
In-Reply-To: <20050928094932.43a1f650.pj@sgi.com>
References: <20050908225539.0bc1acf6.pj@sgi.com>
	<20050909.203849.33293224.taka@valinux.co.jp>
	<20050909063131.64dc8155.pj@sgi.com>
	<20050910.161145.74742186.taka@valinux.co.jp>
	<20050910015209.4f581b8a.pj@sgi.com>
	<20050926093432.9975870043@sv1.valinux.co.jp>
	<20050927013751.47cbac8b.pj@sgi.com>
	<20050927113902.C78A570046@sv1.valinux.co.jp>
	<20050927084905.7d77bdde.pj@sgi.com>
	<20050928062146.6038E70041@sv1.valinux.co.jp>
	<20050928000839.1d659bfb.pj@sgi.com>
	<20050928075331.0408A70041@sv1.valinux.co.jp>
	<20050928094932.43a1f650.pj@sgi.com>
X-Mailer: Sylpheed version 2.1.2+svn (GTK+ 2.6.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20050929025328.E4BFC70046@sv1.valinux.co.jp>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Sep 2005 09:49:32 -0700
Jackson-san wrote:

> > This seems good for me.
> > I'd like to make sure that tasks in CPUSET 2a and CPUSET 2b actually
> > have the cpumask of CPUSET 1a.  Is this correct?
> 
> Oh I think not.  My primary motivation in pushing on this point
> of the design was to allow CPUSET 2a and 2b to have a smaller
> cpumask than CPUSET 1a.  This is used for example to allow a job
> that is running in 1a to setup two child cpusets, 2a and 2b,
> to run two subtasks that are constrained to smaller portions of
> the CPUs allowed to the job in 1a.

Maybe I still misunderstand your idea.
The guarantee assigned to CPUSET 1a might not be satisfied if 
tasks are attached to CPUSET 2a only and no tasks are attached to
CPUSET 1a nor CPUSET 2b.  Does your idea leave as it is because
the user sets up CPUSETs like that?

Leaving that situation as it is seems enough feasible as one option.
Another option is to prohibit CPUSET 2a/2b from having smaller portions
of CPUs that is assigned to CPUSET 1a.

> How would hacking cpuset_cpus_allowed() help here?

I was going to modify cpuset_cpus_allowed(CPUSET 2a/2b) as returning 
cpumask of CPUSET 1a, if tasks in CPUSET 2a and CPUSET 2b have the 
cpumask of CPUSET 1a.


BTW, thank you for fixing the [PATCH] mail that I had sent in wrong format.

-- 
KUROSAWA, Takahiro
