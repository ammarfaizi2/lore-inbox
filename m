Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290599AbSBFPN5>; Wed, 6 Feb 2002 10:13:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290605AbSBFPNi>; Wed, 6 Feb 2002 10:13:38 -0500
Received: from nat-pool-meridian.redhat.com ([12.107.208.200]:41878 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S290599AbSBFPNe>; Wed, 6 Feb 2002 10:13:34 -0500
Date: Wed, 6 Feb 2002 10:12:31 -0500
From: Jakub Jelinek <jakub@redhat.com>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: kernel: ldt allocation failed
Message-ID: <20020206101231.X21624@devserv.devel.redhat.com>
Reply-To: Jakub Jelinek <jakub@redhat.com>
In-Reply-To: <Pine.LNX.4.21.0112070057480.20196-100000@tombigbee.pixar.com.suse.lists.linux.kernel> <200202061258.g16CwGt31197@Port.imtp.ilyichevsk.odessa.ua.suse.lists.linux.kernel> <p73ofj2lpdg.fsf@oldwotan.suse.de> <200202061402.g16E2Nt32223@Port.imtp.ilyichevsk.odessa.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200202061402.g16E2Nt32223@Port.imtp.ilyichevsk.odessa.ua>; from vda@port.imtp.ilyichevsk.odessa.ua on Wed, Feb 06, 2002 at 04:02:25PM -0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 06, 2002 at 04:02:25PM -0200, Denis Vlasenko wrote:
> On 6 February 2002 11:19, Andi Kleen wrote:
> > Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua> writes:
> > > I am ignorant on the subject, but why LDT is used in Linux at all?
> > > LDT register can be set to 0, this can speed up task switch time and save
> > > some memory used for LDT.
> >
> > glibc thread local data uses an LDT for the segment register.
> >
> > glibc 2.3 seems to plan to use segment register based thread local data for
> > even non threaded programs, so it would be a good idea to optimize LDT
> > allocation a bit (= not allocate 64K of vmalloc space every time
> > sys_modify_ldt is called - there is only 8MB of it)
> 
> What do they use on arches without LDT or equivalent?

Most sane architectures reserve a thread pointer register (%g6 resp. %g7 on
sparc, tp on ia64, ppc will use %r2, alpha uses a fast pall call as thread
"register", s390 uses user access register 0 (and s390x uar 0 and 1), etc.).
On register starved ia32 there aren't too many spare registers, so %gs is
used instead.

	Jakub
