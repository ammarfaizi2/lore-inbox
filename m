Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267686AbUJCDVp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267686AbUJCDVp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Oct 2004 23:21:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267696AbUJCDVp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Oct 2004 23:21:45 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:49550 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S267686AbUJCDVn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Oct 2004 23:21:43 -0400
Date: Sat, 2 Oct 2004 20:19:33 -0700
From: Paul Jackson <pj@sgi.com>
To: Peter Williams <pwil3058@bigpond.net.au>
Cc: frankeh@watson.ibm.com, dipankar@in.ibm.com, akpm@osdl.org,
       ckrm-tech@lists.sourceforge.net, efocht@hpce.nec.com,
       mbligh@aracnet.com, lse-tech@lists.sourceforge.net, hch@infradead.org,
       steiner@sgi.com, jbarnes@sgi.com, sylvain.jeaugey@bull.net, djh@sgi.com,
       linux-kernel@vger.kernel.org, colpatch@us.ibm.com, Simon.Derr@bull.net,
       ak@suse.de, sivanich@sgi.com
Subject: Re: [Lse-tech] [PATCH] cpusets - big numa cpu and memory placement
Message-Id: <20041002201933.41e4cdc4.pj@sgi.com>
In-Reply-To: <415F37F9.6060002@bigpond.net.au>
References: <20040805100901.3740.99823.84118@sam.engr.sgi.com>
	<20040805190500.3c8fb361.pj@sgi.com>
	<247790000.1091762644@[10.10.2.4]>
	<200408061730.06175.efocht@hpce.nec.com>
	<20040806231013.2b6c44df.pj@sgi.com>
	<411685D6.5040405@watson.ibm.com>
	<20041001164118.45b75e17.akpm@osdl.org>
	<20041001230644.39b551af.pj@sgi.com>
	<20041002145521.GA8868@in.ibm.com>
	<415ED3E3.6050008@watson.ibm.com>
	<415F37F9.6060002@bigpond.net.au>
Organization: SGI
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter writes:
> 
> The way I see it you just replace the task's affinity mask with a 
> pointer to its "CPU set" which contains the affinity mask shared by 
> tasks belonging to that set ...

I too like this suggestion.  The current duplication of cpus_allowed and
mems_allowed between task and cpuset is a fragile design, forced on us
by incremental feature addition and the need to maintain backwards
compatibility.


> A possible problem is that there may be users whose use of the current 
> affinity mechanism would be broken by such a change.  A compile time 
> choice between the current mechanism and a set based mechanism would be 
> a possible solution.

Do you mean kernel or application compile time?  The current affinity
mechanisms have enough field penetration that the kernel will have to
support or emulate these calls for a long period of deprecation at best.

So I guess you mean application compile time.  However, the current user
level support, in glibc and other libraries, for these calls is
sufficiently confused, at least in my view, that rather than have that
same API mean two things, depending on a compile time switch, I'd rather
explore (1) emulating the existing calls, just as they are, (2) adding
new calls that are try these API's again, in line with our kernel
changes, and (3) eventually deprecate and remove the old calls, over a
multi-year period.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
