Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261903AbVBUHIK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261903AbVBUHIK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Feb 2005 02:08:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261905AbVBUHIK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Feb 2005 02:08:10 -0500
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:45200 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP id S261903AbVBUHHk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Feb 2005 02:07:40 -0500
Subject: Re: [PATCH 2.6.11-rc3-mm2] connector: Add a fork connector
From: Guillaume Thouvenin <guillaume.thouvenin@bull.net>
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Cc: Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>,
       lkml <linux-kernel@vger.kernel.org>,
       elsa-devel <elsa-devel@lists.sourceforge.net>,
       Gerrit Huizenga <gh@us.ibm.com>, Erich Focht <efocht@hpce.nec.com>
In-Reply-To: <1108655454.14089.105.camel@uganda>
References: <1108652114.21392.144.camel@frecb000711.frec.bull.fr>
	 <1108655454.14089.105.camel@uganda>
Date: Mon, 21 Feb 2005 08:07:36 +0100
Message-Id: <1108969656.8418.59.camel@frecb000711.frec.bull.fr>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 21/02/2005 08:16:29,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 21/02/2005 08:16:32,
	Serialize complete at 21/02/2005 08:16:32
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-02-17 at 18:50 +0300, Evgeniy Polyakov wrote:
> On Thu, 2005-02-17 at 15:55 +0100, Guillaume Thouvenin wrote:
> >     It's a new patch that implements a fork connector in the
> > kernel/fork.c:do_fork() routine. The connector sends information about
> > parent PID and child PID over a netlink interface. It allows to several
> > user space applications to be alerted when a fork occurs in the kernel.
> > The main drawback is that even if nobody listens, a message is send. I
> > don't know how to avoid that. I added an option (FORK_CONNECTOR) to
> > enable the fork connector (or disable) when compiling the kernel. To
> > work, connector must be compiled as built-in (CONFIG_CONNECTOR=y). It
> > has been tested on a 2.6.11-rc3-mm2 kernel with two user space
> > applications connected. 
> > 
> >     It is used by ELSA to manage group of processes in user space. In
> > conjunction with a per-process accounting information, like BSD or CSA,
> > ELSA provides a per-group of processes accounting.
> 
> I think people will complain here...
> ... [cut here] ...
> I still think that lsm with all calls logging is the best way to
> achieve this goal.

I agree with you. My first implementation was with LSM but Chris Wright
(I think it was him) notice that it's not the right framework (and it
seems true). So I looked for another solution. I though about kobject
but it was too "big" and finally, Greg KH spoke about connectors. It's
small and efficient.
 
> from the other side why only fork is monitored in this way?

The problem is the following: I have a user space daemon that manages
group of processes. The main idea is, if a parent belongs to a group
then its child belongs to the same group. To achieve this I need to know
when a fork occurs and which processes are involved. I don't see how to
do this without a hook in the do_fork() routine... Any ideas are
welcome.

Thank you Evgeniy for all your comments about the code, it helps and I
will modify the patch.

Regards,
Guillaume

