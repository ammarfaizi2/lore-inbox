Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262727AbVBYQYc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262727AbVBYQYc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Feb 2005 11:24:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262733AbVBYQYc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Feb 2005 11:24:32 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:43139 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S262727AbVBYQY2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Feb 2005 11:24:28 -0500
Subject: Re: Xterm Hangs - Possible scheduler defect?
From: Lee Revell <rlrevell@joe-job.com>
To: Paulo Marques <pmarques@grupopie.com>
Cc: Ingo Oeser <ioe-lkml@axxeo.de>, Chris Friesen <cfriesen@nortel.com>,
       "Chad N. Tindel" <chad@tindel.net>, Mike Galbraith <EFAULT@gmx.de>,
       akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <421F49E0.9090806@grupopie.com>
References: <20050224075756.GA18639@calma.pair.com>
	 <200502250151.41793.ioe-lkml@axxeo.de> <421F4042.3020302@nortel.com>
	 <200502251639.50238.ioe-lkml@axxeo.de>  <421F49E0.9090806@grupopie.com>
Content-Type: text/plain
Date: Fri, 25 Feb 2005 11:24:27 -0500
Message-Id: <1109348667.9681.10.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-02-25 at 15:53 +0000, Paulo Marques wrote:
> Ingo Oeser wrote:
> > Chris Friesen wrote:
> > 
> >>Ingo Oeser wrote:
> >>[...]
> > You would need to change the priority of task 1 until it releases the
> > mutex. Ideally the owner gets the maximum priority of
> > his and all the waiters on it, until it releases his mutex, where he regains
> > its old priority after release of mutex. But this priority elevation happens
> > only, if he is runnable. If not, he gets his old priority back, until he is 
> > runnable.
> 
> This is called a "priority inversion" problem, and there was some work 
> done by Ingo Molnar to make the scheduler aware of such cases and handle 
> them appropriatelly.
> 
> You can follow this thread for more info:
> 
> http://marc.theaimsgroup.com/?l=linux-kernel&m=110106915415886&w=2
> 

The solution to your problem (which is as old as the hills) involves
priority inheriting mutexes which are available in the RT preempt patch
(if you build with CONFIG_PREEMPT_RT).  This should be usable for hard
realtime applications.

http://people.redhat.com/mingo/realtime-preempt

If you just need very good soft realtime performance I recommend
PREEMPT_DESKTOP.

Lee

