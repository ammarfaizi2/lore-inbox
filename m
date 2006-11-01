Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750897AbWKAXuQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750897AbWKAXuQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 18:50:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751034AbWKAXuQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 18:50:16 -0500
Received: from smtp-out.google.com ([216.239.45.12]:32835 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1750897AbWKAXuO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 18:50:14 -0500
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:to:subject:cc:in-reply-to:
	mime-version:content-type:content-transfer-encoding:
	content-disposition:references;
	b=pQ9v/hFVgANwMSj44beYRK3c/q6LMSdsZTGjWxjdbECxY/3ApRD93o7dYan4UbjX0
	cCqEvIgfV4C0X/k3R4MwA==
Message-ID: <6599ad830611011550m69876b1ase3579167903a7cd7@mail.gmail.com>
Date: Wed, 1 Nov 2006 15:50:01 -0800
From: "Paul Menage" <menage@google.com>
To: "Matt Helsley" <matthltc@us.ibm.com>
Subject: Re: [ckrm-tech] [RFC] Resource Management - Infrastructure choices
Cc: vatsa@in.ibm.com, "Pavel Emelianov" <xemul@openvz.org>, dev@openvz.org,
       sekharan@us.ibm.com, ckrm-tech@lists.sourceforge.net, balbir@in.ibm.com,
       haveblue@us.ibm.com, linux-kernel@vger.kernel.org, pj@sgi.com,
       dipankar@in.ibm.com, rohitseth@google.com
In-Reply-To: <1162419565.12419.154.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061030103356.GA16833@in.ibm.com> <45486925.4000201@openvz.org>
	 <20061101181236.GC22976@in.ibm.com>
	 <1162419565.12419.154.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/1/06, Matt Helsley <matthltc@us.ibm.com> wrote:
> On Wed, 2006-11-01 at 23:42 +0530, Srivatsa Vaddagiri wrote:
> > On Wed, Nov 01, 2006 at 12:30:13PM +0300, Pavel Emelianov wrote:
>
> <snip>
>
> > > >   - Support movement of all threads of a process from one group
> > > >     to another atomically?
> > >
> > > I propose such a solution: if a user asks to move /proc/<pid>
> > > then move the whole task with threads.
> > > If user asks to move /proc/<pid>/task/<tid> then move just
> > > a single thread.
> > >
> > > What do you think?
> >
> > Isnt /proc/<pid> listed also in /proc/<pid>/task/<tid>?
> >
> > For ex:
> >
> >       # ls /proc/2906/task
> >       2906  2907  2908  2909
> >
> > 2906 is the main thread which created the remaining threads.
> >
> > This would lead to an ambiguity when user does something like below:
> >
> >       echo 2906 > /some_res_file_system/some_new_group
> >
> > Is he intending to move just the main thread, 2906, to the new group or
> > all the threads? It could be either.
> >
> > This needs some more thought ...
>
>         I thought the idea was to take in a proc path instead of a single
> number. You could then distinguish between the whole thread group and
> individual threads by parsing the string. You'd move a single thread if
> you find both the tgid and the tid. If you only get a tgid you'd move
> the whole thread group. So:
>
> <pid>                   -> if it's a thread group leader move the whole
>                            thread group, otherwise just move the thread
> /proc/<tgid>            -> move the whole thread group
> /proc/<tgid>/task/<tid> -> move the thread
>
>
>         Alternatives that come to mind are:
>
> 1. Read a flag with the pid
> 2. Use a special file which expects only thread groups as input

I think that having a "tasks" file and a "threads" file in each
container directory would be a clean way to handle it:

"tasks" : read/write complete process members
"threads" : read/write individual thread members

Paul
