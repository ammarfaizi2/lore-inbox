Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269373AbUIIJRL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269373AbUIIJRL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 05:17:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269379AbUIIJRL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 05:17:11 -0400
Received: from mx1.redhat.com ([66.187.233.31]:33961 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S269373AbUIIJRJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 05:17:09 -0400
Date: Thu, 9 Sep 2004 05:12:08 -0400
From: Jakub Jelinek <jakub@redhat.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       linuxppc64-dev <linuxppc64-dev@lists.linuxppc.org>,
       Ulrich Drepper <drepper@redhat.com>
Subject: Re: vDSO for ppc64 : Preliminary release #3
Message-ID: <20040909091208.GY31909@devserv.devel.redhat.com>
Reply-To: Jakub Jelinek <jakub@redhat.com>
References: <1094719382.2543.62.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1094719382.2543.62.camel@gaston>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 09, 2004 at 06:43:03PM +1000, Benjamin Herrenschmidt wrote:
>  - The current glibc code for dealing with vdso's is not completely
> appropriate for ppc64 in particular since we do need relocations to be
> performed on the OPD section (thanks mprotect + COW, it actually works)
> if the library is ever mapped at a differnet address than it's native
> 0x100000 (via the new phdr for example).
> The current glibc code forces l_relocated to 1 for all vdso's (which is
> fine for archs without need to relocate function descriptors).

That is on purpose, even if vDSO location is randomized (e.g. on IA-32),
no relocations should happen, so that the vDSO can be shared (unless
written into by the debugger, that is).  ld.so knows how to deal with
.dynamic section relocation of vDSOs.

	Jakub
