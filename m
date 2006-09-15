Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932342AbWIOWwT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932342AbWIOWwT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 18:52:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932346AbWIOWwT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 18:52:19 -0400
Received: from nef2.ens.fr ([129.199.96.40]:3849 "EHLO nef2.ens.fr")
	by vger.kernel.org with ESMTP id S932345AbWIOWwS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 18:52:18 -0400
Date: Sat, 16 Sep 2006 00:52:13 +0200
From: David Madore <david.madore@ens.fr>
To: Linux Kernel mailing-list <linux-kernel@vger.kernel.org>,
       LSM mailing-list <linux-security-module@vger.kernel.org>
Cc: Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: capabilities patch: trying a more "consensual" approach
Message-ID: <20060915225213.GA15173@clipper.ens.fr>
References: <20060911212826.GA9606@clipper.ens.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060911212826.GA9606@clipper.ens.fr>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.5.10 (nef2.ens.fr [129.199.96.32]); Sat, 16 Sep 2006 00:52:14 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Linux and LSM experts,

I would like to request some advice on how best to create an LSM for
creating underprivileged processes in a way that will seem acceptable
also to those Linux users and kernel hackers who don't want to hear
about it (i.e., my patch should not mess more than necessary with the
rest of the kernel).

In a nutshell, the goal is to do this: when the module is loaded, each
task should have a "cuppabilities" variable, which is initially blank
and, when certain bits are added to it (or removed, depending on your
point of view), prevents certain system calls from succeeding.  This
variable should be inherited across fork() and exec(), and some
interface should be provided to add more cuppabilities (i.e., make a
process less-than-normally privileged).

Now, if I understand correctly, the various alloc_security() LSM hooks
do not stack well: if I want my module to be stackable after SElinux
(and I do), I can't hook task_alloc_security() to create my variable,
so I need to store these "cuppabilities" in a globally visible task
field.  Do I understand correctly?  How acceptable is this?  (We can
assume that 32 bits will be wide enough, so I'm not talking about
adding huge amounts of data to the task struct.)

Second, what would be the cleanest and most acceptable way to provide
an interface to these new "cuppabilities"?  For example, should I add
a new, dedicated, system call?  If so, should I provide new hooks to
it in struct security_operations?  Or is, perhaps, prctl() a better
path (then I would have to request a hook on that in SElinux)?  How
can I best avoid breaking causing any disruption to the rest of the
kernel?

Any advice is welcome.

Happy hacking,

-- 
     David A. Madore
    (david.madore@ens.fr,
     http://www.madore.org/~david/ )
