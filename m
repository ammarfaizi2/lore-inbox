Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261576AbVCLF6m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261576AbVCLF6m (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Mar 2005 00:58:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261881AbVCLF6l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Mar 2005 00:58:41 -0500
Received: from gate.crashing.org ([63.228.1.57]:43750 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261576AbVCLF5j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Mar 2005 00:57:39 -0500
Subject: Re: [RFC][PATCH] new timeofday arch specific hooks  (v. A3)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: john stultz <johnstul@us.ibm.com>
Cc: lkml <linux-kernel@vger.kernel.org>,
       Tim Schmielau <tim@physik3.uni-rostock.de>,
       George Anzinger <george@mvista.com>, albert@users.sourceforge.net,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>,
       Christoph Lameter <clameter@sgi.com>,
       Dominik Brodowski <linux@dominikbrodowski.de>,
       David Mosberger <davidm@hpl.hp.com>, Andi Kleen <ak@suse.de>,
       Paul Mackerras <paulus@samba.org>, schwidefsky@de.ibm.com,
       keith maanthey <kmannth@us.ibm.com>, Patricia Gaughen <gone@us.ibm.com>,
       Chris McDermott <lcm@us.ibm.com>, Max Asbock <masbock@us.ibm.com>,
       mahuja@us.ibm.com, Nishanth Aravamudan <nacc@us.ibm.com>,
       Darren Hart <darren@dvhart.com>, "Darrick J. Wong" <djwong@us.ibm.com>,
       Anton Blanchard <anton@samba.org>, donf@us.ibm.com
In-Reply-To: <1110590710.30498.329.camel@cog.beaverton.ibm.com>
References: <1110590655.30498.327.camel@cog.beaverton.ibm.com>
	 <1110590710.30498.329.camel@cog.beaverton.ibm.com>
Content-Type: text/plain
Date: Sat, 12 Mar 2005 16:52:13 +1100
Message-Id: <1110606733.19810.4.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-03-11 at 17:25 -0800, john stultz wrote:
> All,
> 	This patch implements the minimal architecture specific hooks to enable
> the new time of day subsystem code for i386, x86-64, ia64, ppc32 and
> ppc64. It applies on top of my linux-2.6.11_timeofday-core_A3 patch and
> with this patch applied, you can test the new time of day subsystem. 
> 
> Basically it configs in the NEWTOD code and cuts alot of code out of the
> build via #ifdefs. I know, I know, #ifdefs' are ugly and bad, and the
> final patch will just remove the old code. For now this allows us to be
> flexible and easily switch between the two implementations with a single
> define.
> 
> New in this version:
> o ppc32 arch code (by Darrick Wong. Many thanks to him for this code!)
> o ia64 arch code (by Max Asbock. Many thanks to him for this code!)
> o minor cleanups moving code between the arch and timesource patches
> 
> Items still on the TODO list:
> o s390 arch port (hey Martin: nudge, nudge :)
> o arch specific vsyscall/fsyscall interface
> o other arch ports (volunteers wanted!)

I'm not what the impact will be with the vDSO implementation of
gettimeofday which relies on the bits in systemcfg (tb_to_xs etc...).

Currently, the userland code uses the exact same bits as the kernel
code, and thus, we have a garantee of getting the same results from
both. Also, our "special" ppc_adjtimex will also update our offset and
scale factor (with appropriate barriers) in a way that applies to both
the kernel/syscall gettimeofday and the vDSO implementation. I'm not
sure this is still true with your patch.

I suppose I'll have to dig into the details sometime next week..

Ben

