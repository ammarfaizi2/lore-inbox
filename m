Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269122AbUIXUcL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269122AbUIXUcL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 16:32:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269117AbUIXUcL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 16:32:11 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:13469 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S269122AbUIXUbI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 16:31:08 -0400
Subject: Re: mlock(1)
From: Lee Revell <rlrevell@joe-job.com>
To: Neil Horman <nhorman@redhat.com>
Cc: Jeff Garzik <jgarzik@pobox.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <4154805D.8030904@redhat.com>
References: <41547C16.4070301@pobox.com>  <4154805D.8030904@redhat.com>
Content-Type: text/plain
Message-Id: <1096057867.11589.19.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 24 Sep 2004 16:31:07 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-09-24 at 16:15, Neil Horman wrote:
> Jeff Garzik wrote:
> > 
> > How feasible is it to create an mlock(1) utility, that would allow 
> > priveleged users to execute a daemon such that none of the memory the 
> > daemon allocates will ever be swapped out?
> > 
> > ntp daemon does mlock(2) internally, for example, but IMHO this is 
> > really a policy decision that could be moved out of the app.
> > 
> > Unfortunately I am VM-ignorant as always ;-)
> > 
> 
> I think it would be pretty easy to do.  Since mlock(2) operates on the 
> calling processes vma tree you'd need an interface to the kernel that 
> let you specify a child process and an address range to lock.  Then in 
> the kernel you'd need to translate the pid into task struct and 
> replicate the functionality of sys_mlock without the assumption that 
> current points to the task that you're modifying.  Sounds like something 
> you could do pretty easy with a proc file in fact.
> 

Is this really a good idea?  I suspect it would be abused.  For example,
people would mlock mozilla or openoffice to keep it from being paged out
overnight when updatedb runs, where the real solution is to fix the
problem with the VM that causes updatedb to force other apps to swap
out. 

Making it harder to use mlock ensures that only apps that REALLY need it
will use it, time-critical stuff like ntpd and jackd.

Lee

