Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751359AbWECVjr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751359AbWECVjr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 May 2006 17:39:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751363AbWECVjr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 May 2006 17:39:47 -0400
Received: from 66.239.25.20.ptr.us.xo.net ([66.239.25.20]:12432 "EHLO
	zoot.lnxi.com") by vger.kernel.org with ESMTP id S1751361AbWECVjr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 May 2006 17:39:47 -0400
Message-Id: <4458CEB40200003600006134@zoot.lnxi.com>
X-Mailer: Novell GroupWise Internet Agent 7.0.1 Beta 
Date: Wed, 03 May 2006 15:39:32 -0600
From: "Doug Thompson" <dthompson@lnxi.com>
To: <mark.gross@intel.com>
Cc: <tim@buttersideup.com>, <soo.keong.ong@intel.com>,
       <steven.carbonari@intel.com>, <zhenyu.z.wang@intel.com>,
       <bluesmoke-devel@lists.sourceforge.net>, <alan@lxorguk.ukuu.org.uk>,
       <linux-kernel@vger.kernel.org>
Subject: RE: Problems with EDAC coexisting with BIOS
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-05-03 at 20:49 +0000, "Gross, Mark"  wrote:
> 
> >-----Original Message-----
> >From: Tim Small [mailto:tim@buttersideup.com]
> >Sent: Wednesday, May 03, 2006 1:25 PM
> >To: Alan Cox
> >Cc: Ong, Soo Keong; Gross, Mark;
bluesmoke-devel@lists.sourceforge.net;
> >LKML; Carbonari, Steven; Wang, Zhenyu Z
> >Subject: Re: Problems with EDAC coexisting with BIOS
> >
> >Alan Cox wrote:
> >
> >>On Llu, 2006-04-24 at 22:15 +0800, Ong, Soo Keong wrote:
> >>
> >>
> >>>To me, periodical is not a good design for error handling, it
wastes
> >>>transaction bandwidth that should be used for other more productive
> >>>purposes.
> >>>
> >>>
> >>
> >>The periodical choice is mostly down to the brain damaged choice of
> NMI
> >>as the viable alternative, which is as good as 'not usable'
> >>
> >>
> >Hi,
> >
> >As I believe that the majority of the bluesmoke/EDAC developers are
> >(were) operating under the assumption that it would be possible to do
> >something with NMI-signalled errors, I was wondering what the
problems
> >with using NMI-signalled ECC errors were?

Dave Peterson created the NMI patch for bluesmoke that is currently
operational in the bluesmoke project.  When bluesmoke was submitted, the
advice we received was to defer until later to apply that NMI patch
after we had gotten EDAC into the kernel and more stable.

Since Dave has stepped down, that leaves me to refactor that patch for
EDAC release. It is on my TODO list, but not yet risen to the top.

Once concern I had yet to research is:  Do all motherboards route the
NMI signal properly? Is that a function of the BIOS? etc, etc


> 
> Soo Keong or Steve, can you answer this one?
> 
> >
> >Are there some systems states in which an incoming NMI throws a
spanner
> >in to the works in an unrecoverable way?  If this is the case, is it
so
> >on all x86/x86-64 systems, or just a subset, and is there no way to
> >implement some sort of top half / bottom half style NMI handler
> >cleanly?  As I am certainly not an x86 architecture expert, I would
> >appreciate any input from the resident gurus ;o).
> 
> I don't think NMI's are so much the problem as those blasted SMI's. 
And
> SMI's are not for sharing :(
> 
> These problems are BIOS specific, Your Mileage Will Vary from one bios
> to the next.
> 
> >
> >Quickly returning to the original problem - I know this isn't a
proper
> >API by any stretch of the imagination, and would require changes to
> >existing BIOSs, but the EDAC module could reprogram the chipset
> >error-signalling registers, so that an ECC error no longer triggers
an
> >SMI.  The BIOS SMI handler could then read the signalling registers,
> and
> >leave the ECC registers well alone if ECC errors are not set to
> generate
> >an SMI.
> 
> It's not the SMI from ECC events that are the problem.  It's the BIOS
> assuming no one else would want to use those registers on Dev0:Fun1,
and
> the fact that you still end up with a race between the OS and the BIOS
> SMI to handle the events.

exactly and for that reason we might have a tar baby to wash and clean
up somehow

doug t


