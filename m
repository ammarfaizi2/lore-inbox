Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261971AbVFGUUb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261971AbVFGUUb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Jun 2005 16:20:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261963AbVFGUUb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Jun 2005 16:20:31 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:1442 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S261966AbVFGUUS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Jun 2005 16:20:18 -0400
Date: Tue, 7 Jun 2005 15:19:49 -0500
From: Dean Nelson <dcn@sgi.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: mingo@elte.hu, linux-ia64@vger.kernel.org, linux-altix@sgi.com,
       edwardsg@sgi.com, linux-kernel@vger.kernel.org, akpm@osdl.org,
       anton.wilson@camotion.com
Subject: Re: [PATCH] MAX_USER_RT_PRIO and MAX_RT_PRIO are wrong!
Message-ID: <20050607201949.GA11013@sgi.com>
References: <1118112390.4533.10.camel@localhost.localdomain> <20050607053306.GA16181@elte.hu> <1118143504.4533.21.camel@localhost.localdomain> <20050607154846.GA1253@sgi.com> <1118165519.5667.3.camel@localhost.localdomain> <20050607191001.GA8768@sgi.com> <1118172182.4972.4.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1118172182.4972.4.camel@localhost.localdomain>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 07, 2005 at 03:23:02PM -0400, Steven Rostedt wrote:
> On Tue, 2005-06-07 at 14:10 -0500, Dean Nelson wrote:
> 
> > I just built and tested a kernel and xp/xpc/xpnet modules with your patch
> > applied. It ran fine. The priorities of the xpc kthreads were correct.
> > 
> > Looks good to me.
> 
> Dean, 
> 
> If you can do me a favor, the way you really want to test this is by
> changing MAX_USER_RT_PRIO to 99 and MAX_RT_PRIO to 
> (MAX_USER_RT_PRIO+1).  This will make sure that the patch is working.
> Your kernel thread should still run at priority 99. 
> 
> Check it with:  ps -eo pid,rtprio,comm
> 
> And grep for your thread name.

Just did as you asked and things seem fine. Ran on an SGI altix.
(The first process shown below shouldn't have a priority of 99,
just the others.)

cranberry5:~ # ps -eo pid,rtprio,comm | grep xpc
13325      - xpc_hb
13327     99 xpc08
13467     99 xpc06
13469     99 xpc06c1
13501     99 xpc06c1
13502     99 xpc06c1
cranberry5:~ #

