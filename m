Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751228AbWAPWy3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751228AbWAPWy3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 17:54:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751247AbWAPWy3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 17:54:29 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:7379 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751228AbWAPWy3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 17:54:29 -0500
Subject: Re: [2.6 patch] fix sched_setscheduler semantics
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Jason Baron <jbaron@redhat.com>, mingo@elte.hu,
       linux-kernel@vger.kernel.org, drepper@redhat.com, Tony.Reix@bull.net
In-Reply-To: <20060116225215.GA11049@mipter.zuzino.mipt.ru>
References: <Pine.LNX.4.61.0601161650540.21530@dhcp83-105.boston.redhat.com>
	 <20060116225215.GA11049@mipter.zuzino.mipt.ru>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 16 Jan 2006 22:57:46 +0000
Message-Id: <1137452266.15553.89.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2006-01-17 at 01:52 +0300, Alexey Dobriyan wrote:
> On Mon, Jan 16, 2006 at 05:17:55PM -0500, Jason Baron wrote:
> > --- linux-2.6/kernel/sched.c.bak
> > +++ linux-2.6/kernel/sched.c
> > @@ -3824,6 +3824,10 @@ do_sched_setscheduler(pid_t pid, int pol
> >  asmlinkage long sys_sched_setscheduler(pid_t pid, int policy,
> >  				       struct sched_param __user *param)
> >  {
> > +	/* negative values for policy are not valid */
> > +	if (policy < 0)
> > +		return -EINVAL;
> 
> Classical redundant comment.

Disagree. A pointless comment would be "if policy is negative return
-EINVAL". The comment makes it clear that policy < 0 is *invalid* as a
syscall argument rather than just something not currently handled, or
being done for algorithmic reasons

