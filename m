Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261705AbVF0TLJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261705AbVF0TLJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 15:11:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261601AbVF0THa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 15:07:30 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:8123 "EHLO e34.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S261642AbVF0TFj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 15:05:39 -0400
Subject: Re: [ckrm-tech] [patch 25/38] CKRM e18: Add fork rate control to
	the numtasks controller
From: Chandra Seetharaman <sekharan@us.ibm.com>
Reply-To: sekharan@us.ibm.com
To: Naoaki Maeda <maeda.naoaki@jp.fujitsu.com>
Cc: Gerrit Huizenga <gh@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, ckrm-tech@lists.sourceforge.net,
       Matt Helsley <matthltc@us.ibm.com>
In-Reply-To: <42BFA5C6.9040604@jp.fujitsu.com>
References: <20050623061552.833852000@w-gerrit.beaverton.ibm.com>
	 <20050623061759.325157000@w-gerrit.beaverton.ibm.com>
	 <42BFA5C6.9040604@jp.fujitsu.com>
Content-Type: text/plain
Organization: IBM
Date: Mon, 27 Jun 2005 12:05:31 -0700
Message-Id: <1119899131.14910.18.camel@linuxchandra>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 2005-06-27 at 16:07 +0900, Naoaki Maeda wrote:
> Gerrit Huizenga wrote:
> 
> > +As with any other resource under the CKRM framework, numtasks also assigns
> > +all the resources to the detault class(/rcfs/taskclass). Since , the number
> > +of tasks in a system is not limited, this resource controller provides a
> > +way to set the total number of tasks available in the system through the config
> > +file. By default this value is 128k(131072). In other words, if not changed,
> > +the total number of tasks allowed in a system is 131072.
> > +
> > +The config variable that affect this is sys_total_tasks.
> 
> Because there are people who do not want to use the numtask controller,
> no limit is a preferable default value for sys_total_tasks.

It is not a limit, it is the system level number of tasks assumed by the
numtasks controller, so, it cannot be a _no limit_, it has to be real
number.

If one doesn't want a controller, they can avoid compiling it in, and
numtasks even allows one to use it as a module.

If your real concern is that the number is too small, we can make it
bigger.
> 
> > +Usage
> > +-----
> > +
> > +For brevity, unless otherwise specified all the following commands are
> > +executed in the default class (/rcfs/taskclass).
> > +
> > +As explained above the config file shows sys_total_tasks and forkrate
> > +info.
> > +
> > +   # cd /rcfs/taskclass
> > +   # cat config
> > +   res=numtasks,sys_total_tasks=131072,forkrate=1000000,forkrate_interval=3600
> > +
> > +By default, the sys_total_tasks is set to 131072(128k), and forkrate is set
> > +to 1 million and forkrate_interval is set to 3600 seconds. Which means the
> > +total number of tasks in a system is limited to 131072 and the forks are
> > +limited to 1 million per hour.
> 
> >From the same point of view, the default value of forkrate should be
> no limit. (In addition, 1 million tasks per hour is not an abnormally
> high rate.)

we can make it 1 million / second (or minute).
> 
> Thanks,
> MAEDA Naoaki
> 
> 
> 
> -------------------------------------------------------
> SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
> from IBM. Find simple to follow Roadmaps, straightforward articles,
> informative Webcasts and more! Get everything you need to get up to
> speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
> _______________________________________________
> ckrm-tech mailing list
> https://lists.sourceforge.net/lists/listinfo/ckrm-tech
-- 

----------------------------------------------------------------------
    Chandra Seetharaman               | Be careful what you choose....
              - sekharan@us.ibm.com   |      .......you may get it.
----------------------------------------------------------------------


