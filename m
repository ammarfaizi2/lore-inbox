Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964927AbWDGTnl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964927AbWDGTnl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Apr 2006 15:43:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964931AbWDGTnk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Apr 2006 15:43:40 -0400
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:19841 "EHLO
	sorel.sous-sol.org") by vger.kernel.org with ESMTP id S964927AbWDGTnj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Apr 2006 15:43:39 -0400
Date: Fri, 7 Apr 2006 12:45:45 -0700
From: Chris Wright <chrisw@sous-sol.org>
To: =?iso-8859-1?B?VPZy9ms=?= Edwin <edwin@gurde.com>
Cc: linux-security-module@vger.kernel.org, James Morris <jmorris@namei.org>,
       linux-kernel@vger.kernel.org, fireflier-devel@lists.sourceforge.net,
       sds@tycho.nsa.gov
Subject: Re: [RFC][PATCH 0/7] fireflier LSM for labeling sockets based on its creator (owner)
Message-ID: <20060407194545.GA15997@sorel.sous-sol.org>
References: <200604021240.21290.edwin@gurde.com> <1144249591.25790.56.camel@moss-spartans.epoch.ncsc.mil> <200604072034.20972.edwin@gurde.com> <200604072124.24000.edwin@gurde.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200604072124.24000.edwin@gurde.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Török Edwin (edwin@gurde.com) wrote:
> The purpose of the fireflier LSM is to "label" each socket with a context, 
> where the context is a (list of) the program(s) that has/have access to it.
> 
> I've written fireflier LSM to allow filtering packets "per application". It is 
> meant to be used only when SELinux is not available (not available/disabled 
> at boot). For more details, see the initial discussion [1]

There is so much SELinux code in here, it's really not making sense to
do this as separate work.

> Summary of how fireflier LSM works:
> - each program is associated a sid, depending on its mountpoint+inode, i.e. 2 
> processes launched from the same program have the same sid

That sounds like a problem.  Ptrace can undermine that really easily.
Also bind mounts will give you a different sid for same exectuable, with
a possible way to get into interesting 'group' situation.
 
> - each socket created by a processis labeled with the process's sid
> - if 2 or more programs have access to the socket, it is labeled with a "group 
> sid". A group sid contains a list of the sids of programs having access
> - userspace, or iptables module can match packets on this "fireflier context"

How do you keep from joining the group?

> As I stated in my previous mail, I intend to write a userspace policy module 
> generator, that is to be used when selinux is enabled.
> When it is disabled, then only would the fireflier lsm be used.
> 
> I am asking for your comments/suggestions on the following issues:
> - security/correctness of the LSM (is there a way for a program to have access 
> to a socket, and escaping the labeling?)

what do you do about ptrace, /proc/[pid]/mem, fd passing, bind mounts, /proc/self/mem, etc.

> - how do I generate an SELinux policy, that does what this LSM module does?

Sounds like the best solution.

thanks,
-chris
