Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422831AbWCXKHI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422831AbWCXKHI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 05:07:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422833AbWCXKHI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 05:07:08 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.142]:18891 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1422831AbWCXKHG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 05:07:06 -0500
Subject: Re: [2.6.16 PATCH] Connector: Filesystem Events Connector
From: Matt Helsley <matthltc@us.ibm.com>
To: Yi Yang <yang.y.yi@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Michael Kerrisk <michael.kerrisk@gmx.net>,
       Evgeniy Polyakov <johnpol@2ka.mipt.ru>
In-Reply-To: <44235E65.2020708@gmail.com>
References: <44216612.3060406@gmail.com> <1143099809.29668.89.camel@stark>
	 <44235E65.2020708@gmail.com>
Content-Type: text/plain
Date: Fri, 24 Mar 2006 01:53:26 -0800
Message-Id: <1143194006.29668.251.camel@stark>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-03-24 at 10:50 +0800, Yi Yang wrote:
> Matt Helsley wrote:
> > On Wed, 2006-03-22 at 22:58 +0800, Yi Yang wrote:

<snip>
 
> >> +struct fsevent {
> >> +	__u32 type;
> >> +	__u32 cpu;
> >> +	struct timespec timestamp;
> >> +	__u32 tgid;
> >>     
> >
> > 	I think pid_t would be more appropriate here instead of a __u32.
> > Also a tid field of type pid_t would be consistent with the Process
> > Events returned to userspace. If a userspace program ever wanted to
> > relate the two sets of events the tid field could be important. That
> > said it would be nice to know if any userspace programs are planning on
> > using this.
> >   
> 
> I think size of pid_t must be changed from 2.4 to 2.6, in Redhat 9.0, I 
> find size of pid_t in user space is
>  different from kernel space, I believe that is the problem of stale 
> header files.

I'm not sure why a connector would have to be concerned with the size of
pid_t in linux-2.4.x unless it's backported since, as far as I'm aware,
connectors have not been backported.

> >   
> >> +	__u32 uid;
> >> +	__u32 gid;
> >> +	__u32 err;
> >>     
> >
> > 	The err field appears to be unused when sending events back to
> > userspace. I suggest reusing it for the event mask and using the type
> > field to indicate whether the message is a CMDACK or simply an EVENT.
> >   
> err is useful when you use unknown CMD for  the connector, ACK will tell 
> the user CMD is invalid.

	Yes, but the point is for an event -- which presumably is *much* more
frequent that a CMD -- the err field would be unused. Hence my
suggestion of having it serve as the mask field for event messages
instead of combining the event mask into the type field.

<snip>

Cheers,
	-Matt Helsley

