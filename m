Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262331AbVGWEaW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262331AbVGWEaW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Jul 2005 00:30:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262334AbVGWEaW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Jul 2005 00:30:22 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:22155 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262331AbVGWEaU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Jul 2005 00:30:20 -0400
Subject: Re: [ckrm-tech] Re: 2.6.13-rc3-mm1 (ckrm)
From: Matthew Helsley <matthltc@us.ibm.com>
To: Mark Hahn <hahn@physics.mcmaster.ca>
Cc: LKML <linux-kernel@vger.kernel.org>,
       CKRM-Tech <ckrm-tech@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.44.0507221830350.29479-100000@coffee.psychology.mcmaster.ca>
References: <Pine.LNX.4.44.0507221830350.29479-100000@coffee.psychology.mcmaster.ca>
Content-Type: text/plain
Date: Fri, 22 Jul 2005 21:19:57 -0700
Message-Id: <1122092398.5242.326.camel@stark>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-07-22 at 20:23 -0400, Mark Hahn wrote:
> > > actually, let me also say that CKRM is on a continuum that includes 
> > > current (global) /proc tuning for various subsystems, ulimits, and 
> > > at the other end, Xen/VMM's.  it's conceivable that CKRM could wind up
> > > being useful and fast enough to subsume the current global and per-proc
> > > tunables.  after all, there are MANY places where the kernel tries to 
> > > maintain some sort of context to allow it to tune/throttle/readahead
> > > based on some process-linked context.  "embracing and extending"
> > > those could make CKRM attractive to people outside the mainframe market.
> > 
> > 	Seems like an excellent suggestion to me! Yeah, it may be possible to
> > maintain the context the kernel keeps on a per-class basis instead of
> > globally or per-process. 
> 
> right, but are the CKRM people ready to take this on?  for instance,
> I just grepped 'throttle' in kernel/mm and found a per-task RM in 
> page-writeback.c.  it even has a vaguely class-oriented logic, since
> it exempts RT tasks.  if CKRM can become a way to make this stuff 
> cleaner and more effective (again, for normal tasks), then great.
> but bolting on a big new different, intrusive mechanism that slows
> down all normal jobs by 3% just so someone can run 10K mostly-idle
> guests on a giant Power box, well, that's gross.
> 
> > The real question is what constitutes a useful
> > "extension" :).
> 
> if CKRM is just extensions, I think it should be an external patch.
> if it provides a path towards unifying the many disparate RM mechanisms
> already in the kernel, great!

OK, so if it provides a path towards unifying these, what should happen
to the old interfaces when they conflict with those offered by CKRM?

For instance, I'm considering how a per-class (re)nice setting would
work. What should happen when the user (re)nices a process to a
different value than the nice of the process' class? Should CKRM:

a) disable the old interface by
	i) removing it
	ii) return an error when CKRM is active
	iii) return an error when CKRM has specified a nice value for the
process via membership in a class
	iv) return an error when the (re)nice value is inconsistent with the
nice value assigned to the class

b) trust the user, ignore the class nice value, and allow the new nice
value

	I'd be tempted to do a.iv but it would require some modifications to a
system call. b probably wouldn't require any modifications to non-CKRM
files/dirs. 

	This sort of question would probably come up for any other CKRM
"embraced-and-extended" tunables. Should they use the answer to this
one, or would it go on a case-by-case basis?

Thanks,
	-Matt Helsley

