Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262356AbTIUIMx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Sep 2003 04:12:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262361AbTIUIMw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Sep 2003 04:12:52 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:63164 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S262356AbTIUIMv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Sep 2003 04:12:51 -0400
Subject: Re: What's the point of __KERNEL_SYSCALLS__?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Matthew Wilcox <willy@debian.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030921045411.GC13172@parcelfarce.linux.theplanet.co.uk>
References: <20030919164044.GF21596@parcelfarce.linux.theplanet.co.uk>
	 <20030921045411.GC13172@parcelfarce.linux.theplanet.co.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1064131876.3424.20.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-7) 
Date: Sun, 21 Sep 2003 09:11:16 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2003-09-21 at 05:54, Matthew Wilcox wrote:
> On Fri, Sep 19, 2003 at 05:40:44PM +0100, Matthew Wilcox wrote:
> > This doesn't seem like a big list to clean up.  Any objections to
> > getting rid of them and making the calls directly?
> 
> Here's a patch that removes them for i386 and parisc.  Other arches can
> catch up as they see fit.  Comments?  I've compiled the files that aren't
> completely arch-specific (eg sparc or m68k).

> -static inline int execve(char *filename, char * argv [],
> -	char * envp[])
> -{
> -	extern int __execve(char *, char **, char **, struct task_struct *);
> -	return __execve(filename, argv, envp, current);
> -}

execve on some platforms relies on the entry stuff. Take a look at the
use of the passed registers in sys_execve on x86 as an example. Simply 
calling sys_execve won't work. The same is true for sys_clone used to
create threads.


