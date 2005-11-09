Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030781AbVKIVzh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030781AbVKIVzh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 16:55:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030784AbVKIVzh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 16:55:37 -0500
Received: from rwcrmhc13.comcast.net ([216.148.227.118]:242 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S1030781AbVKIVzf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 16:55:35 -0500
Subject: Re: openat()
From: Nicholas Miell <nmiell@comcast.net>
To: dean gaudet <dean-list-linux-kernel@arctic.org>
Cc: Ulrich Drepper <drepper@redhat.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.63.0511091338200.728@twinlark.arctic.org>
References: <43724AB3.40309@redhat.com>
	 <Pine.LNX.4.63.0511091338200.728@twinlark.arctic.org>
Content-Type: text/plain
Date: Wed, 09 Nov 2005 13:55:33 -0800
Message-Id: <1131573333.2856.4.camel@entropy>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4.njm.1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-11-09 at 13:42 -0800, dean gaudet wrote:
> On Wed, 9 Nov 2005, Ulrich Drepper wrote:
> 
> > Can we please get the openat() syscall implemented?  I know Linus already
> > declared this is a good idea and I can only stress that it is really essential
> > for some things.  It is today impossible to write correct code which uses long
> > pathnames since all these operations would require the use of chdir() which
> > affect the whole POSIX process and not just one thread.  In addition we have
> > the reduction of race conditions.
> 
> oh sweet i've always wanted this for perf improvements in multithreaded 
> programs which have to deal with lots of lookups deep in a directory tree 
> (especially over NFS).
> 
> would this include other related syscalls such as link, unlink, rename, 
> chown, chmod... so that the the virtualization of the "current working 
> directory" concept is more complete?
> 
> -dean

I think that the full suite of "pathname lookups relative to a fd"
functions was implied.

Note that you could always introduce pthread_attr_setsharedfs(3) and
pthread_attr_getsharedfs(3) (or whatever you want to call them) which
control the passing of CLONE_FS to clone(2) in pthread_create(). This
would allow you to create threads which have their own pwd and umask
(and even chroot, but I don't think that would be very useful) without
any kernel changes.

-- 
Nicholas Miell <nmiell@comcast.net>

