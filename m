Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311710AbSCUQbM>; Thu, 21 Mar 2002 11:31:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311858AbSCUQbC>; Thu, 21 Mar 2002 11:31:02 -0500
Received: from NEVYN.RES.CMU.EDU ([128.2.145.6]:39590 "EHLO nevyn.them.org")
	by vger.kernel.org with ESMTP id <S311710AbSCUQa4>;
	Thu, 21 Mar 2002 11:30:56 -0500
Date: Thu, 21 Mar 2002 11:27:22 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: "Vamsi Krishna S ." <vamsi@in.ibm.com>
Cc: Mark Gross <mgross@unix-os.sc.intel.com>, Pavel Machek <pavel@suse.cz>,
        linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk,
        marcelo@conectiva.com.br, tachino@jp.fujitsu.com, jefreyr@pacbell.net,
        vamsi_krishna@in.ibm.com, richardj_moore@uk.ibm.com,
        hanharat@us.ibm.com, bsuparna@in.ibm.com, bharata@in.ibm.com,
        asit.k.mallick@intel.com, david.p.howell@intel.com,
        tony.luck@intel.com, sunil.saxena@intel.com
Subject: Re: [PATCH] multithreaded coredumps for elf exeecutables
Message-ID: <20020321112722.A31634@nevyn.them.org>
Mail-Followup-To: "Vamsi Krishna S ." <vamsi@in.ibm.com>,
	Mark Gross <mgross@unix-os.sc.intel.com>,
	Pavel Machek <pavel@suse.cz>, linux-kernel@vger.kernel.org,
	alan@lxorguk.ukuu.org.uk, marcelo@conectiva.com.br,
	tachino@jp.fujitsu.com, jefreyr@pacbell.net,
	vamsi_krishna@in.ibm.com, richardj_moore@uk.ibm.com,
	hanharat@us.ibm.com, bsuparna@in.ibm.com, bharata@in.ibm.com,
	asit.k.mallick@intel.com, david.p.howell@intel.com,
	tony.luck@intel.com, sunil.saxena@intel.com
In-Reply-To: <20020315170726.A3405@in.ibm.com> <20020319152959.C55@toy.ucw.cz> <200203192147.g2JLl3W01070@unix-os.sc.intel.com> <20020320113630.A6882@in.ibm.com> <20020320133709.A10958@nevyn.them.org> <20020321154650.A1435@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 21, 2002 at 03:46:50PM +0530, Vamsi Krishna S . wrote:
> Dan,
> 
> Thanks for pointing this out. I see that this change has now gone into
> 2.4.18 as well as 2.5.4. We would ensure that the down_write happens
> only after the registers of all threads are collected.

Yes, your other patch for this looks OK.

> Coming back to the original point raised by Pavel, indeed there is 
> nothing preventing external code (any other kernel modules) modifying
> the cpus_allowed field from under us. This could get worse in 2.5.x
> where a user could change cpu affinity (through proc or a syscall, 
> though I don't think the patches providing this are accepted as yet).

We really need a non-signal-based way to tell the scheduler that a task
can not be scheduled.  A lot of the machinery is all there, but private to
sched.c; the rest is pretty straightforward.

-- 
Daniel Jacobowitz                           Carnegie Mellon University
MontaVista Software                         Debian GNU/Linux Developer
