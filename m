Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131505AbRDWQMN>; Mon, 23 Apr 2001 12:12:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132616AbRDWQME>; Mon, 23 Apr 2001 12:12:04 -0400
Received: from theseus.mathematik.uni-ulm.de ([134.60.166.2]:43142 "HELO
	theseus.mathematik.uni-ulm.de") by vger.kernel.org with SMTP
	id <S131505AbRDWQLv>; Mon, 23 Apr 2001 12:11:51 -0400
Message-ID: <20010423161148.6465.qmail@theseus.mathematik.uni-ulm.de>
From: "Christian Ehrhardt" <ehrhardt@mathematik.uni-ulm.de>
Date: Mon, 23 Apr 2001 18:11:48 +0200
To: Victor Zandy <zandy@cs.wisc.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: BUG: Global FPU corruption in 2.2
In-Reply-To: <cpx7l0g3mfk.fsf@goat.cs.wisc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <cpx7l0g3mfk.fsf@goat.cs.wisc.edu>; from zandy@cs.wisc.edu on Thu, Apr 19, 2001 at 11:05:03AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 19, 2001 at 11:05:03AM -0500, Victor Zandy wrote:
> 
> We have found that one of our programs can cause system-wide
> corruption of the x86 FPU under 2.2.16 and 2.2.17.  That is, after we
> run this program, the FPU gives bad results to all subsequent
> processes.

A few comments, not sure if they will help very much:

1.) If I'm not mistaken switch_to changes current->flags without
atomic operations and without any locks and sys_ptrace changes
child->flags only protected by the big kernel lock.
I could imagine that this causes local corruption on an SMP machine
and this is something that changed in 2.4 kernels, but I don't see
how this can corrupt FPU state globally. Maybe there is something else.

2.) I guess a single finit (as proposed by someone else in this thread)
won't assure that both FPUs are in a sane state.

3.) It might be interesting to know if the problem can be triggered:
a) If pi doesn't fork, i.e. just one process calculating pi and
another one doing the attach/detach.
b) If pi doesn't do FPU Operations, i.e. only the children call do_pi.

    regards    Christian

-- 
THAT'S ALL FOLKS!
