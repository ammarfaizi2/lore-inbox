Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965038AbVHSRLg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965038AbVHSRLg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Aug 2005 13:11:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932683AbVHSRLg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Aug 2005 13:11:36 -0400
Received: from mx1.redhat.com ([66.187.233.31]:4315 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932678AbVHSRLf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Aug 2005 13:11:35 -0400
Date: Fri, 19 Aug 2005 13:11:17 -0400 (EDT)
From: Elliot Lee <sopwith@redhat.com>
X-X-Sender: sopwith@devserv.devel.redhat.com
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: e8607062@student.tuwien.ac.at, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.6.13-rc6 1/2] New Syscall: get rlimits of any process
 (update)
In-Reply-To: <1124387342.16072.13.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.58.0508181929010.32738@devserv.devel.redhat.com>
References: <1124326652.8359.3.camel@w2>  <p7364u40zld.fsf@verdi.suse.de> 
 <1124381951.6251.14.camel@w2> <1124387342.16072.13.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Aug 2005, Alan Cox wrote:

> > Also some documention for specific services show that there is a need to
> > adjust rlimits per process at runtime, e.g.:
> > http://www.squid-cache.org/Doc/FAQ/FAQ-11.html#ss11.4
> > http://slacksite.com/apache/logging.html
> > http://staff.in2.hr/denis/oracle/10g1install_fedora3_en.html#n2
> 
> Perhaps those application authors should provide a management interface
> to do so within the soft limit range at least. Its not clear to me that
> growing the fd array on a process is even safe. Some programs do size
> arrays at startup after querying the rlimit data.

This is getting hung up on one particular example, while missing the
bigger picture.

Being able to set rlimits for other processes is useful in general, just
as things like nice() and sched_setscheduler() are. Maybe it is reducing
max RSS on certain processes and increasing it on other processes, so that
the memory tends to be used for higher-priority processes. Maybe it is 
setting max cpu time to T+5 minutes, so that if a seemingly stuck process 
has not exited in five minutes, it will die. Maybe it is limiting  the 
number of processes that a daemon can spawn.

In addition, it's not always practical to have application authors provide 
a management interface.

You're right that there can be potential problems with adjusting rlimits 
on the fly, but that doesn't seem like a sufficient reason to avoid 
including the feature.

Best,
-- Elliot
Pioneers get the Arrows. Settlers get the Land.
