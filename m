Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262036AbTCRAZo>; Mon, 17 Mar 2003 19:25:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262043AbTCRAZo>; Mon, 17 Mar 2003 19:25:44 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:60903
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262036AbTCRAZn>; Mon, 17 Mar 2003 19:25:43 -0500
Subject: Re: Ptrace hole / Linux 2.2.25
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: blp@cs.stanford.edu
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <87smtlbzx8.fsf@pfaff.Stanford.EDU>
References: <20030317161020$42ed@gated-at.bofh.it>
	 <87smtlbzx8.fsf@pfaff.Stanford.EDU>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1047952000.25577.5.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 18 Mar 2003 01:46:41 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-03-17 at 18:39, Ben Pfaff wrote:
> I am concerned about this change because it will break sandboxing
> software that I have written, which uses prctl() to turn
> dumpability back on so that it can open a file, setuid(), and
> then execve() through the open file via /proc/self/fd/#.  Without
> calling prctl(), the ownership of /proc/self/fd/* becomes root,
> so the process cannot exec it after it drops privileges.  It uses
> prctl() in other places to get the same effect in /proc, but
> that's one of the most critical.

The dumpability is per mm, which means that you have to consider
all the cases of a thread being created in parallel to dumpability
being enabled.

So consider a three threaded process. Thread one triggers kernel thread
creation, thread two turns dumpability back on, thread three ptraces
the new kernel thread.

Proving that is safe is non trivial so the current patch chooses not
to attempt it. For 2.4.21 proper someone can sit down and do the needed
verification if they wish

