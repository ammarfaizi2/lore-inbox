Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261610AbUIIMU2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261610AbUIIMU2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 08:20:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261602AbUIIMU2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 08:20:28 -0400
Received: from mx1.redhat.com ([66.187.233.31]:4537 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261610AbUIIMUS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 08:20:18 -0400
Date: Thu, 9 Sep 2004 08:15:04 -0400
From: Jakub Jelinek <jakub@redhat.com>
To: Paul Mackerras <paulus@samba.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       linuxppc64-dev <linuxppc64-dev@lists.linuxppc.org>,
       Ulrich Drepper <drepper@redhat.com>
Subject: Re: vDSO for ppc64 : Preliminary release #3
Message-ID: <20040909121504.GZ31909@devserv.devel.redhat.com>
Reply-To: Jakub Jelinek <jakub@redhat.com>
References: <1094719382.2543.62.camel@gaston> <20040909091208.GY31909@devserv.devel.redhat.com> <16704.15604.289019.476483@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16704.15604.289019.476483@cargo.ozlabs.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 09, 2004 at 09:22:28PM +1000, Paul Mackerras wrote:
> Jakub Jelinek writes:
> 
> > That is on purpose, even if vDSO location is randomized (e.g. on IA-32),
> > no relocations should happen, so that the vDSO can be shared (unless
> > written into by the debugger, that is).  ld.so knows how to deal with
> > .dynamic section relocation of vDSOs.
> 
> On 64-bit architectures which use procedure descriptors, the
> descriptors will have to be relocated (unless you or Alan can come up

s/64-bit architectures which use procedure descriptors/ppc64/
(IA-64 and I guess hppa64 as well certainly don't need that).

> with some toolchain or ld.so magic or something).  But the descriptors
> are in the data section rather than the text, of course.

None of the assembly routines seem to use toc register, so if the functions
exported from the library have special calling conventions (glibc would use
them from inline assembly wrappers anyway), you can get away without .opd.
vDSO is not in global search scope anyway, so applications can't call
symbols from it anyway unless doing lots of magic.

	Jakub
