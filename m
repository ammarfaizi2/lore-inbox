Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261321AbSLHMSY>; Sun, 8 Dec 2002 07:18:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261448AbSLHMSY>; Sun, 8 Dec 2002 07:18:24 -0500
Received: from max.fiasco.org.il ([192.117.122.39]:9488 "HELO
	latenight.fiasco.org.il") by vger.kernel.org with SMTP
	id <S261321AbSLHMSY>; Sun, 8 Dec 2002 07:18:24 -0500
Subject: Re: Detecting threads vs processes with ps or /proc
From: Gilad Ben-Yossef <gilad@benyossef.com>
To: Nick LeRoy <nleroy@cs.wisc.edu>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200212060924.02162.nleroy@cs.wisc.edu>
References: <200212060924.02162.nleroy@cs.wisc.edu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 08 Dec 2002 14:24:42 +0200
Message-Id: <1039350288.15058.23.camel@klendathu.telaviv.sgi.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-12-06 at 17:24, Nick LeRoy wrote:

> 
> Our software (Condor) and some related software (Globus) is running on a 
> number of systems around the world.  Condor attempts to monitor the RAM usage 
> of it's "user" (maybe "client" is a better word here) processes.  If the 
> client forks, we need to monitor the client and all of it's children, which 
> really isn't difficult.  The _problem_ is that if the client creates threads, 
> it's impossible, from what we can tell, to tell the difference between 
> separate threads and processes.
> 
> So my question, I guess, is this.  How can you tell, from user space, whether 
> a group of processes are related as threads or through a "normal" child / 
> parent relationship?  The systems that we're running on currently are 2.2.19 
> and 2.4.18/19.

There is another approach save for the one already discussed here, which
I have no idea how applicable it is in your case, but will produce 100%
reliable results without additional kernel support - track the processes
forks.

There are several ways you can go about it - there's the expensive (in
terms of CPU cycles) approach of using ptrace(2), the relativly painless
way of overriding the "default" calls to fork and friends via ld.so(8)
magical LD_PRELOAD  that nevertheless requires you control the execution
of the "client" programs and even using a system call tracking module
such as syscall-tracker (http://syscalltrack.sf.net) which might not be
quite ready for use on a production system as of yet.

Hope this helps,
Gilad

-- 
 Gilad Ben-Yossef <gilad@benyossef.com> 
 http://benyossef.com 
 "Denial really is a river in Eygept."

