Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752495AbWKAWTc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752495AbWKAWTc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 17:19:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752520AbWKAWTb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 17:19:31 -0500
Received: from e33.co.us.ibm.com ([32.97.110.151]:9137 "EHLO e33.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1752495AbWKAWTb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 17:19:31 -0500
Subject: Re: [ckrm-tech] [RFC] Resource Management - Infrastructure choices
From: Matt Helsley <matthltc@us.ibm.com>
To: vatsa@in.ibm.com
Cc: Pavel Emelianov <xemul@openvz.org>, dev@openvz.org, sekharan@us.ibm.com,
       ckrm-tech@lists.sourceforge.net, balbir@in.ibm.com, haveblue@us.ibm.com,
       linux-kernel@vger.kernel.org, pj@sgi.com, dipankar@in.ibm.com,
       rohitseth@google.com, menage@google.com
In-Reply-To: <20061101181236.GC22976@in.ibm.com>
References: <20061030103356.GA16833@in.ibm.com>
	 <45486925.4000201@openvz.org>  <20061101181236.GC22976@in.ibm.com>
Content-Type: text/plain
Organization: IBM Linux Technology Center
Date: Wed, 01 Nov 2006 14:19:25 -0800
Message-Id: <1162419565.12419.154.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-11-01 at 23:42 +0530, Srivatsa Vaddagiri wrote:
> On Wed, Nov 01, 2006 at 12:30:13PM +0300, Pavel Emelianov wrote:

<snip>

> > > 	- Support movement of all threads of a process from one group
> > > 	  to another atomically?
> > 
> > I propose such a solution: if a user asks to move /proc/<pid>
> > then move the whole task with threads.
> > If user asks to move /proc/<pid>/task/<tid> then move just
> > a single thread.
> > 
> > What do you think?
> 
> Isnt /proc/<pid> listed also in /proc/<pid>/task/<tid>?
> 
> For ex:
> 
> 	# ls /proc/2906/task
> 	2906  2907  2908  2909
> 
> 2906 is the main thread which created the remaining threads.
> 
> This would lead to an ambiguity when user does something like below:
> 
> 	echo 2906 > /some_res_file_system/some_new_group
> 
> Is he intending to move just the main thread, 2906, to the new group or
> all the threads? It could be either.
> 
> This needs some more thought ...

	I thought the idea was to take in a proc path instead of a single
number. You could then distinguish between the whole thread group and
individual threads by parsing the string. You'd move a single thread if
you find both the tgid and the tid. If you only get a tgid you'd move
the whole thread group. So:

<pid>                   -> if it's a thread group leader move the whole
			   thread group, otherwise just move the thread
/proc/<tgid>            -> move the whole thread group
/proc/<tgid>/task/<tid> -> move the thread


	Alternatives that come to mind are:

1. Read a flag with the pid
2. Use a special file which expects only thread groups as input 

Cheers,
	-Matt Helsley

