Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422634AbWCIFfS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422634AbWCIFfS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 00:35:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750943AbWCIFfS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 00:35:18 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:34731 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750705AbWCIFfR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 00:35:17 -0500
Subject: Re: [2.6.16-rc5-m3 PATCH] inotify: add the monitor for the event
	source
From: Arjan van de Ven <arjan@infradead.org>
To: Yi Yang <yang.y.yi@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <440FBA9C.3050109@gmail.com>
References: <440F075F.1030404@gmail.com>
	 <1141836798.12175.1.camel@laptopd505.fenrus.org>
	 <440FBA9C.3050109@gmail.com>
Content-Type: text/plain
Date: Thu, 09 Mar 2006 06:35:13 +0100
Message-Id: <1141882513.2883.2.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-03-09 at 13:18 +0800, Yi Yang wrote:
> Arjan van de Ven wrote:
> > On Thu, 2006-03-09 at 00:33 +0800, Yi Yang wrote:
> >   
> >> Current inotify implementation only focus on change of file system, but it doesn't
> >>  know who results in this change, this patch adds three fields to struct inotify_event,
> >>  tgid, uid and gid, they will save process ID, user ID and user group ID of the process
> >>  which leads to change in the file system, such software as anti-virus can make use 
> >> of this feature to monitor who is modifying a specific file.
> >>     
> >
> >
> > this patch appears to change the ABI! That is bad bad bad.
> >   
> a change of struct inotify_event can't change ABI, can you describe it 
> more clear?

it breaks ABI because this structure is communicated to userspace, and
you change both the layout and the size of it. What else would ABI
mean??


> > Also, how can you guarantee that "current" is valid and meaningful at
> > the place you use it to get the user id ??
> >   
> Of course, current process/thread never disappears before fsnotify_* 
> returns.

but... what makes you think it's not a kernel thread such as kjournald?
(which have basically meaningless current)


> > Also the process ID part is really bogus, after all the process may have
> > exited by the time the inotify client gets to it, and the PID may even
> > already have been reused.
> >
> >   
> Your concern is correct, but uid and git can give out some hints, I ever 
> considered to
> save the name of current process, however that needs a bigger and 
> length-variable
> inotify_event struct, moreover, to get the full path name of current 
> process/thread
> in kernel will have a big overhead, so I must select a comprise way.

there is no "full path name" concept in linux like that. And even worse,
many processes will not have *any* path because they have been deleted,
especially the viruses will use this ;)


