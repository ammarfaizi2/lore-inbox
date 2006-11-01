Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423648AbWKAQEU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423648AbWKAQEU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 11:04:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423941AbWKAQEU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 11:04:20 -0500
Received: from e35.co.us.ibm.com ([32.97.110.153]:54415 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1423648AbWKAQET
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 11:04:19 -0500
Subject: Re: [ckrm-tech] [RFC] Resource Management - Infrastructure choices
From: Matt Helsley <matthltc@us.ibm.com>
To: Pavel Emelianov <xemul@openvz.org>
Cc: vatsa@in.ibm.com, dev@openvz.org, sekharan@us.ibm.com,
       ckrm-tech@lists.sourceforge.net, balbir@in.ibm.com, haveblue@us.ibm.com,
       linux-kernel@vger.kernel.org, pj@sgi.com, dipankar@in.ibm.com,
       rohitseth@google.com, menage@google.com, devel@openvz.org
In-Reply-To: <4548545B.4070701@openvz.org>
References: <20061030103356.GA16833@in.ibm.com>
	 <45460743.8000501@openvz.org> <20061031163418.GD9588@in.ibm.com>
	 <4548545B.4070701@openvz.org>
Content-Type: text/plain
Organization: IBM Linux Technology Center
Date: Wed, 01 Nov 2006 08:04:01 -0800
Message-Id: <1162397041.12419.124.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-11-01 at 11:01 +0300, Pavel Emelianov wrote:
> [snip]
> 
> >> 2. Having configfs as the only interface doesn't alow
> >>    people having resource controll facility w/o configfs.
> >>    Resource controller must not depend on any "feature".

	That's not true. It's possible for a resource control system that uses
a filesystem interface to operate without it's filesystem interface. In
fact, for performance reasons I think it's necessary.

	Even assuming your point is true, since you agree there should be only
one interface does it matter that choosing one prevents implementing
another?

	Why must a resource controller never depend on another "feature"?

> > One flexibility configfs (and any fs-based interface) offers is, as Matt
> > had pointed out sometime back, the ability to delage management of a
> > sub-tree to a particular user (without requiring root permission).
> > 
> > For ex:
> > 
> > 			/
> > 			|
> > 		 -----------------
> > 		|		  |
> > 	       vatsa (70%)	linux (20%)
> > 		|
> > 	 ----------------------------------
> > 	|	         | 	          |
> >       browser (10%)   compile (50%)    editor (10%)
> > 
> > In this, group 'vatsa' has been alloted 70% share of cpu. Also user
> > 'vatsa' has been given permissions to manage this share as he wants. If
> > the cpu controller supports hierarchy, user 'vatsa' can create further
> > sub-groups (browser, compile ..etc) -without- requiring root access.
> 
> I can do the same using bcctl tool and sudo :)

bcctl and, to a lesser extent, sudo are more esoteric.

Open, read, write, mkdir, unlink, etc. are all system calls so it seems
we all agree that system calls are the way to go. ;) Now if only we
could all agree on which system calls...

> > Also it is convenient to manipulate resource hierarchy/parameters thr a
> > shell-script if it is fs-based.
> > 
> >> 3. Configfs may be easily implemented later as an additional
> >>    interface. I propose the following solution:
> > 
> > Ideally we should have one interface - either syscall or configfs - and
> > not both.

To incorporate all feedback perhaps we should replace "configfs" with
"filesystem".

Cheers,
	-Matt Helsley

