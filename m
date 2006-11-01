Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2992700AbWKASH2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992700AbWKASH2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 13:07:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992701AbWKASH2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 13:07:28 -0500
Received: from e33.co.us.ibm.com ([32.97.110.151]:44967 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S2992700AbWKASH1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 13:07:27 -0500
Date: Wed, 1 Nov 2006 23:42:36 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: Pavel Emelianov <xemul@openvz.org>
Cc: dev@openvz.org, sekharan@us.ibm.com, menage@google.com,
       ckrm-tech@lists.sourceforge.net, balbir@in.ibm.com, haveblue@us.ibm.com,
       linux-kernel@vger.kernel.org, pj@sgi.com, matthltc@us.ibm.com,
       dipankar@in.ibm.com, rohitseth@google.com
Subject: Re: [ckrm-tech] [RFC] Resource Management - Infrastructure choices
Message-ID: <20061101181236.GC22976@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <20061030103356.GA16833@in.ibm.com> <45486925.4000201@openvz.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45486925.4000201@openvz.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 01, 2006 at 12:30:13PM +0300, Pavel Emelianov wrote:
> > Debated:
> > 	- syscall vs configfs interface
> 
> OK. Let's stop at configfs interface to move...

Excellent!

> > 	- Should we have different groupings for different resources?
> 
> I propose to discuss this question as this is the most important
> now from my point of view.
> 
> I believe this can be done, but can't imagine how to use this...

As I mentioned in my earlier mail, I thought openvz folks did want this
flexibility:

	http://lkml.org/lkml/2006/8/18/98

Also:

	http://lwn.net/Articles/94573/

But I am ok if we dont support this feature in the initial round of
development.

Having grouping for different resources could be a hairy to deal
with and could easily mess up applications (for ex: a process in a 80%
CPU class but in a 10% memory class could lead to underutilization of
its cpu share, because it cannot allocated memory as fast as it wants to run), 
it is assumed that administrator will carefully manage these settings.

> > 	- Support movement of all threads of a process from one group
> > 	  to another atomically?
> 
> I propose such a solution: if a user asks to move /proc/<pid>
> then move the whole task with threads.
> If user asks to move /proc/<pid>/task/<tid> then move just
> a single thread.
> 
> What do you think?

Isnt /proc/<pid> listed also in /proc/<pid>/task/<tid>?

For ex:

	# ls /proc/2906/task
	2906  2907  2908  2909

2906 is the main thread which created the remaining threads.

This would lead to an ambiguity when user does something like below:

	echo 2906 > /some_res_file_system/some_new_group

Is he intending to move just the main thread, 2906, to the new group or
all the threads? It could be either.

This needs some more thought ...

-- 
Regards,
vatsa
