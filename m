Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261690AbVCNSPZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261690AbVCNSPZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 13:15:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261704AbVCNSMx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 13:12:53 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:54739 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S261670AbVCNSJW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 13:09:22 -0500
Subject: Re: [RFC][PATCH] new timeofday arch specific hooks  (v. A3)
From: john stultz <johnstul@us.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
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
In-Reply-To: <1110606733.19810.4.camel@gaston>
References: <1110590655.30498.327.camel@cog.beaverton.ibm.com>
	 <1110590710.30498.329.camel@cog.beaverton.ibm.com>
	 <1110606733.19810.4.camel@gaston>
Content-Type: text/plain
Date: Mon, 14 Mar 2005 10:09:14 -0800
Message-Id: <1110823754.30498.335.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-03-12 at 16:52 +1100, Benjamin Herrenschmidt wrote:
> On Fri, 2005-03-11 at 17:25 -0800, john stultz wrote:
> > All,
> > 	This patch implements the minimal architecture specific hooks to enable
> > the new time of day subsystem code for i386, x86-64, ia64, ppc32 and
> > ppc64. It applies on top of my linux-2.6.11_timeofday-core_A3 patch and
> > with this patch applied, you can test the new time of day subsystem. 
> > 
> > Basically it configs in the NEWTOD code and cuts alot of code out of the
> > build via #ifdefs. I know, I know, #ifdefs' are ugly and bad, and the
> > final patch will just remove the old code. For now this allows us to be
> > flexible and easily switch between the two implementations with a single
> > define.
> > 
> > New in this version:
> > o ppc32 arch code (by Darrick Wong. Many thanks to him for this code!)
> > o ia64 arch code (by Max Asbock. Many thanks to him for this code!)
> > o minor cleanups moving code between the arch and timesource patches
> > 
> > Items still on the TODO list:
> > o s390 arch port (hey Martin: nudge, nudge :)
> > o arch specific vsyscall/fsyscall interface
> > o other arch ports (volunteers wanted!)
> 
> I'm not what the impact will be with the vDSO implementation of
> gettimeofday which relies on the bits in systemcfg (tb_to_xs etc...).

Oh yea, the vDSO stuff slipped in after I last tested the ppc64 bits, so
I wouldn't be surprised if that's broken. For now I'm just disabling the
vsyscall/fsyscall/vDSO bits on the arches that support it until I get a
generic interface setup that would allow it to be consistent with the
new time infrastructure. Hopefully I'll have that done (I'm targeting
x86-64 atleast) by the next release. 

thanks
-john


