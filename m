Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263790AbUGFMa6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263790AbUGFMa6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jul 2004 08:30:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263806AbUGFMa6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jul 2004 08:30:58 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:5172 "EHLO
	MTVMIME01.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S263790AbUGFMax (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jul 2004 08:30:53 -0400
Date: Tue, 6 Jul 2004 14:08:04 +0100 (BST)
From: Tigran Aivazian <tigran@aivazian.fsnet.co.uk>
X-X-Sender: tigran@localhost.localdomain
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
cc: linux-kernel@vger.kernel.org, Alan Cox <alan@redhat.com>
Subject: Re: question about /proc/<PID>/mem in 2.4
In-Reply-To: <20040706110436.GA11441@logos.cnet>
Message-ID: <Pine.LNX.4.44.0407061406200.20027-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Jul 2004, Marcelo Tosatti wrote:
> On Tue, Jul 06, 2004 at 12:14:04PM +0100, Tigran Aivazian wrote:
> > Ok, but still nobody seems to know why the super user is not allowed to
> > access /proc/<PID>/mem of any task. Any code which nobody in the world
> > knows the reason for, is broken and should be removed.
> > 
> > I will wait a few weeks to see if someone does come up with the reason for
> > that "extra secure" check in mem_read() and if nobody has objections I'll
> > send Linus a patch to relax the check to a more reasonable one, namely to
> > allow CAP_SYS_PTRACE process to bypass any other conditions imposed.
> 
> Hi Tigran, 
> 
> This code was added to stop the ptrace/kmod vulnerabilities. I do not 
> fully understand the issues around tsk->is_dumpable and the fix itself,
> but I agree on that the checks here could be relaxed for the super user.
> 
> However changing it to 
> 
>         if (!is_dumpable(task) && !capable(CAP_SYS_PTRACE))
>                 goto out;
> 
> Seems wrong because this will stop always honoring the tsk->is_dumpable flag. (?)
> 
> Alan for sure can make the picture clear - he wrote this thing.

Ok, let's see what Alan says then (if he has time to look at it).

Btw, the mem_read() code in both 2.4 and 2.6 can be cleaned up to use
get_task_mm() inline instead of doing it inline "manually".

Kind regards
Tigran


