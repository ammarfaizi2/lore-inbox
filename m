Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262543AbTD1ArT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Apr 2003 20:47:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262577AbTD1ArT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Apr 2003 20:47:19 -0400
Received: from smtp.bitmover.com ([192.132.92.12]:147 "EHLO smtp.bitmover.com")
	by vger.kernel.org with ESMTP id S262543AbTD1ArR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Apr 2003 20:47:17 -0400
Date: Sun, 27 Apr 2003 17:59:25 -0700
From: Larry McVoy <lm@bitmover.com>
To: Mark Grosberg <mark@nolab.conman.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFD] Combined fork-exec syscall.
Message-ID: <20030428005925.GC27729@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Mark Grosberg <mark@nolab.conman.org>, linux-kernel@vger.kernel.org
References: <Pine.BSO.4.44.0304272036360.23296-100000@kwalitee.nolab.conman.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.BSO.4.44.0304272036360.23296-100000@kwalitee.nolab.conman.org>
User-Agent: Mutt/1.4i
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam, SpamAssassin (score=0.5, required 4.5,
	DATE_IN_PAST_06_12)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If you do this, _please_ make it compat with NT.

On Sun, Apr 27, 2003 at 08:57:12PM -0400, Mark Grosberg wrote:
> 
> Hello all,
> 
> Is there any interest in a single system call that will perform both a
> fork() and exec()? Could this save some extra work of doing a
> copy_mm(), copy_signals(), etc?
> 
> I would think on large, multi-user systems that are spawning processes all
> day, this might improve performance if the shells on such a system were
> patched.
> 
> Perhaps a system call like:
> 
>    pid_t spawn(const char *p_path,
>                const char *argv[],
>                const char *envp[],
>                const int   filp[]);
> 
> The filp array would allow file descriptors to be redirected. It could be
> terminated by a -1 and reference the file descriptors of the current
> process (this could also potentially save some dup() syscalls).
> 
> If any of these parameters (exclusing p_path) are NULL, then the
> appropriate values are taken from the current process.
> 
> I originally was thinking of a name of fexec() for such a syscall, but
> since there are already "f" variant syscalls (fchmod, fstat, ...) that an
> fexec() would make more sense about executing an already open file, so the
> name spawn() came to mind.
> 
> I know almost all of my fork()-exec() code does almost the same thing. I
> guess vfork() was a potential solution, but this somehow seems cleaner
> (and still may be more efficient than having to issue two syscalls)...
> the downside is, of course, another syscall.
> 
> L8r,
> Mark G.
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
---
Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
