Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269682AbUJGEJt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269682AbUJGEJt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 00:09:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269681AbUJGEJt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 00:09:49 -0400
Received: from zimbo.cs.wm.edu ([128.239.2.64]:5573 "EHLO zimbo.cs.wm.edu")
	by vger.kernel.org with ESMTP id S269682AbUJGEJS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 00:09:18 -0400
Date: Thu, 7 Oct 2004 00:08:59 -0400
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: chrisw@osdl.org, linux-kernel@vger.kernel.org, serue@us.ibm.com
Subject: Re: [patch 1/3] lsm: add bsdjail module
Message-ID: <20041007040859.GA17774@escher.cs.wm.edu>
References: <1097094103.6939.5.camel@serge.austin.ibm.com> <1097094270.6939.9.camel@serge.austin.ibm.com> <20041006162620.4c378320.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041006162620.4c378320.akpm@osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you for the feedback.  I have implemented these changes, but
want to run a few tests tomorrow before I send them out to make
sure I didn't break anything...

Quoting Andrew Morton (akpm@osdl.org):
> Serge Hallyn <serue@us.ibm.com> wrote:
> >
> > 
> > Attached is a patch against the security Kconfig and Makefile to support
> > bsdjail, as well as the bsdjail.c file itself. bsdjail offers
> > functionality similar to (but more limited than) the vserver patch.
> 
> I don't recall anyone requesting this feature.  Tell me why we should add
> it to Linux?

Because it gives Linux a functionality like FreeBSD's jail and Solaris'
zones in an unobtrusive manner, without impacting users who don't wish
to use it  (except for the extra security_task_lookup function calls).
It allows me (for instance) to compartmentalize apache and sendmail by
running them in different jails.  Or offer family members, customers,
or whoever, ssh accounts into seemingly distinct boxes, which are simply
sshd's under different jails at different network aliases.  Each would
see their own private filesystems and network, have their own usage
limits, and (mostly) not see processes outside their respective jails.
They can't {un,}load modules, ptrace unjailed processes or send signals
to them, create devices, mount, or umount.  It is functionality which
otherwise would have to be achieved by running vmware or uml, but far
more lightweight, since no new OS needs to be run.  (Once read-only bind
mounts are implemented, it will become even more lightweight, as large
pieces of filesystem trees will be shareable readonly between jails.)

thanks,
-serge
