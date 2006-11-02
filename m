Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752007AbWKBI4t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752007AbWKBI4t (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 03:56:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752750AbWKBI4t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 03:56:49 -0500
Received: from mailhub.sw.ru ([195.214.233.200]:57705 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S1752007AbWKBI4s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 03:56:48 -0500
Message-ID: <4549B1CF.3000505@openvz.org>
Date: Thu, 02 Nov 2006 11:52:31 +0300
From: Pavel Emelianov <xemul@openvz.org>
User-Agent: Thunderbird 1.5 (X11/20060317)
MIME-Version: 1.0
To: vatsa@in.ibm.com
CC: Pavel Emelianov <xemul@openvz.org>, dev@openvz.org, sekharan@us.ibm.com,
       menage@google.com, ckrm-tech@lists.sourceforge.net, balbir@in.ibm.com,
       haveblue@us.ibm.com, linux-kernel@vger.kernel.org, pj@sgi.com,
       matthltc@us.ibm.com, dipankar@in.ibm.com, rohitseth@google.com
Subject: Re: [ckrm-tech] [RFC] Resource Management - Infrastructure choices
References: <20061030103356.GA16833@in.ibm.com> <45486925.4000201@openvz.org> <20061101181236.GC22976@in.ibm.com>
In-Reply-To: <20061101181236.GC22976@in.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> I believe this can be done, but can't imagine how to use this...
> 
> As I mentioned in my earlier mail, I thought openvz folks did want this
> flexibility:
> 
> 	http://lkml.org/lkml/2006/8/18/98
> 
> Also:
> 
> 	http://lwn.net/Articles/94573/
> 
> But I am ok if we dont support this feature in the initial round of
> development.

Yes. Lets start with it - no separate groupings for a while.

BTW I think that hierarchy is a good (and easier to make than)
replacement for separate grouping. Say if I want two groups to
have separate CPU shares and common kmemsize this is the same as
if I want one group for kmemsize with two kids - one for X% of
CPU share and the other for Y%. And this (hierarchy) provides
more flexibility than "plain" although separate grouping.
Moreover configfs can provide a clean interface for it. E.g.
 $ mkdir /configfs/beancounters/0
 $ mkdir /configfs/beancounters/0/1
 $ mkdir /confgifs/beancounters/0/2
and each task_struct will have a single pointer - current
container - but not 10 - for each controller.

What do you think?

> Having grouping for different resources could be a hairy to deal
> with and could easily mess up applications (for ex: a process in a 80%

That's it... One more thing against separate grouping.

[snip]

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

I agree with Paul Menage that having
/configfs/beancounters/<id>/tasks and /.../threads is perfect.
