Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264925AbUFLVpA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264925AbUFLVpA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jun 2004 17:45:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264928AbUFLVpA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jun 2004 17:45:00 -0400
Received: from fw.osdl.org ([65.172.181.6]:8680 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264925AbUFLVo6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jun 2004 17:44:58 -0400
Date: Sat, 12 Jun 2004 14:44:37 -0700
From: Chris Wright <chrisw@osdl.org>
To: Kyle Moffett <mrmacman_g4@mac.com>
Cc: Chris Wright <chrisw@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: In-kernel Authentication Tokens (PAGs)
Message-ID: <20040612144437.V21045@build.pdx.osdl.net>
References: <772741DF-BC19-11D8-888F-000393ACC76E@mac.com> <20040611201523.X22989@build.pdx.osdl.net> <C636D44C-BC2B-11D8-888F-000393ACC76E@mac.com> <20040612135302.Y22989@build.pdx.osdl.net> <ADFD1FB4-BCB5-11D8-888F-000393ACC76E@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <ADFD1FB4-BCB5-11D8-888F-000393ACC76E@mac.com>; from mrmacman_g4@mac.com on Sat, Jun 12, 2004 at 05:15:50PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Kyle Moffett (mrmacman_g4@mac.com) wrote:
> On Jun 12, 2004, at 16:53, Chris Wright wrote:
> > Actually that's not the case.  The UID is currently insufficient to
> > describe the security domain that a process is running in.  The whole
> > of the LSM infrastructure is designed with this in mind.  So somehting
> > like SELinux may enforce a security domain change (w/out a UID change)
> > across an execve() of pagsh.  I was simply trying to ascertain if you
> > were storing this within task->user which I think would be wrong.
> 
> Ahh, ok, I myself have no experience with LSM, so there will likely be 
> some
> need to change my implementation.  Currently the only field that I add 
> to
> existing structures in the kernel is a pag field in the task_struct.  
> PAG
> structures themselves need some way of determining if the calling task
> is in the same "grouping" as a stored "grouping" within the PAG.  My
> implementation uses UIDs, but I would be very glad if you could tell me
> what I should use instead.  I need some kind of structure or pointer 
> that I
> can embed within a PAG and a token, and some kind of equality test.

Typically, objects that LSM cares about include a pointer to opaque
data (security blob) which describes the security domain for the object.
See task->security as an example.  It's not clear to me if task->security
is sufficient and you only need a back pointer to the task or if each
PAG needs it's own security blob.

> The other thing that needs to be implemented is some kind of limit that
> restricts how many PAGs/tokens and how much memory can be allocated
> in the kernel per user and per process.  Do you have any information on
> where would be the best place to store that information?

Sounds like an extension to rlimits.  The counters could be stored in
->user to limit the userwide number of tokens.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
