Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263664AbUGFLiW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263664AbUGFLiW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jul 2004 07:38:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263778AbUGFLiW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jul 2004 07:38:22 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:24738 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263664AbUGFLiU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jul 2004 07:38:20 -0400
Date: Tue, 6 Jul 2004 08:04:36 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Tigran Aivazian <tigran@aivazian.fsnet.co.uk>
Cc: FabF <fabian.frederick@skynet.be>, linux-kernel@vger.kernel.org
Subject: Re: question about /proc/<PID>/mem in 2.4
Message-ID: <20040706110436.GA11441@logos.cnet>
References: <1089037523.2129.15.camel@localhost.localdomain> <Pine.LNX.4.44.0407061210190.20027-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0407061210190.20027-100000@localhost.localdomain>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 06, 2004 at 12:14:04PM +0100, Tigran Aivazian wrote:
> On Mon, 5 Jul 2004, FabF wrote:
> > > Surely, the super user (i.e. CAP_SYS_PTRACE in this context) should be 
> > > allowed to read any process' memory without having to do the 
> > > PTRACE_ATTACH/PTRACE_PEEKUSER kind of thing which strace(8) is doing?
> > 
> > FYI may_ptrace_attach plugged somewhere between 2.4.21 & 22.This one get
> > used as is (ie without MAY_PTRACE) in proc_pid_environ but dunno about
> > reason why CAP_SYS_PTRACE isn't authoritative elsewhere.
> 
> Ok, but still nobody seems to know why the super user is not allowed to
> access /proc/<PID>/mem of any task. Any code which nobody in the world
> knows the reason for, is broken and should be removed.
> 
> I will wait a few weeks to see if someone does come up with the reason for
> that "extra secure" check in mem_read() and if nobody has objections I'll
> send Linus a patch to relax the check to a more reasonable one, namely to
> allow CAP_SYS_PTRACE process to bypass any other conditions imposed.

Hi Tigran, 

This code was added to stop the ptrace/kmod vulnerabilities. I do not 
fully understand the issues around tsk->is_dumpable and the fix itself,
but I agree on that the checks here could be relaxed for the super user.

However changing it to 

        if (!is_dumpable(task) && !capable(CAP_SYS_PTRACE))
                goto out;

Seems wrong because this will stop always honoring the tsk->is_dumpable flag. (?)

Alan for sure can make the picture clear - he wrote this thing.
                                                                                                                                                                                   

