Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261856AbTCQS2l>; Mon, 17 Mar 2003 13:28:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261866AbTCQS2l>; Mon, 17 Mar 2003 13:28:41 -0500
Received: from pfaff.Stanford.EDU ([128.12.189.154]:14042 "EHLO
	pfaff.Stanford.EDU") by vger.kernel.org with ESMTP
	id <S261818AbTCQS2k>; Mon, 17 Mar 2003 13:28:40 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: Ptrace hole / Linux 2.2.25
References: <20030317161020$42ed@gated-at.bofh.it>
Reply-To: blp@cs.stanford.edu
From: Ben Pfaff <blp@cs.stanford.edu>
Date: 17 Mar 2003 10:39:31 -0800
In-Reply-To: <20030317161020$42ed@gated-at.bofh.it>
Message-ID: <87smtlbzx8.fsf@pfaff.Stanford.EDU>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@redhat.com> writes:

> A patch for Linux 2.4.20/Linux 2.4.21pre is attached. The patch also
> subtly changes the PR_SET_DUMPABLE prctl. We believe this is neccessary and 
> that it will not affect any software. The functionality change is specific 
> to unusual debugging situations.

I am concerned about this change because it will break sandboxing
software that I have written, which uses prctl() to turn
dumpability back on so that it can open a file, setuid(), and
then execve() through the open file via /proc/self/fd/#.  Without
calling prctl(), the ownership of /proc/self/fd/* becomes root,
so the process cannot exec it after it drops privileges.  It uses
prctl() in other places to get the same effect in /proc, but
that's one of the most critical.
-- 
<blp@cs.stanford.edu> <pfaffben@msu.edu> <pfaffben@debian.org> <blp@gnu.org>
  Stanford Ph.D. Student - MSU Alumnus - Debian Maintainer - GNU Developer
                              www.benpfaff.org
