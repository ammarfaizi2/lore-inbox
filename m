Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932320AbVJJBNM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932320AbVJJBNM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Oct 2005 21:13:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932322AbVJJBNM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Oct 2005 21:13:12 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:12512 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S932320AbVJJBNL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Oct 2005 21:13:11 -0400
Date: Sun, 9 Oct 2005 20:13:04 -0500
From: serue@us.ibm.com
To: Bernard Blackham <bernard@blackham.com.au>
Cc: Ed Tomlinson <tomlins@cam.org>, lokum spand <lokumsspand@hotmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: A possible idea for Linux: Save running programs to disk
Message-ID: <20051010011304.GA28223@sergelap.austin.ibm.com>
References: <BAY105-F35A25DA28443029610815DA48E0@phx.gbl> <20051002045315.GA20946@ucc.gu.uwa.edu.au> <200510020857.27065.tomlins@cam.org> <20051002141637.GC5211@blackham.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051002141637.GC5211@blackham.com.au>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Bernard Blackham (bernard@blackham.com.au):
> On Sun, Oct 02, 2005 at 08:57:26AM -0400, Ed Tomlinson wrote:
> > Is there any kernel api that adding would make cryopid more
> > dependable/cleaner?
> 
> Currently a fair bit of information is obtained by injecting code
> into the process's memory space, executing it, and reaping out the
> results (eg, termcaps, file offsets, fcntl states, locks, signal
> actions, etc).  Can't think of ways to make it cleaner off the top
> of my head, but I'm open to ideas.
> 
> Seeing as you asked though, here's my wishlist :) I don't expect all
> of these to be implemented, but every bit would help. Issues I
> haven't been able to address so far:
> 
>  - Processes that cache their PID and need it, or rely on PIDs of
>    their children.
> 
>    Some way to request a given PID when cloning/forking (or on the
>    fly even) would make life easier.

Have you considered any ways of implementing this?  Perhaps the simplest
way would actually be to allow a process set to be started in some kind
of job/jail/container/vserver, where any userspace query of or by pid
uses the virtual pid - which might collide with a virtual pid in some
other container - but of course the kernel continues to track by real
pids.  So pid 3728 may be vpid 2287 in job 3.  A process inside job 3
just asks to kill -9 2287, whereas a process not in a job must ask to
kill pid 3728, and a process in job 2 can't touch tasks in job 3.  Is
there another way this could work?

-serge
