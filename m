Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261875AbUIIMjk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261875AbUIIMjk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 08:39:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262085AbUIIMjk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 08:39:40 -0400
Received: from gate.crashing.org ([63.228.1.57]:64199 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261875AbUIIMji (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 08:39:38 -0400
Subject: Re: vDSO for ppc64 : Preliminary release #3
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jakub Jelinek <jakub@redhat.com>
Cc: Paul Mackerras <paulus@samba.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       linuxppc64-dev <linuxppc64-dev@lists.linuxppc.org>,
       Ulrich Drepper <drepper@redhat.com>
In-Reply-To: <20040909121504.GZ31909@devserv.devel.redhat.com>
References: <1094719382.2543.62.camel@gaston>
	 <20040909091208.GY31909@devserv.devel.redhat.com>
	 <16704.15604.289019.476483@cargo.ozlabs.ibm.com>
	 <20040909121504.GZ31909@devserv.devel.redhat.com>
Content-Type: text/plain
Message-Id: <1094733490.2664.81.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 09 Sep 2004 22:38:10 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > with some toolchain or ld.so magic or something).  But the descriptors
> > are in the data section rather than the text, of course.
> 
> None of the assembly routines seem to use toc register, so if the functions
> exported from the library have special calling conventions (glibc would use
> them from inline assembly wrappers anyway), you can get away without .opd.
> vDSO is not in global search scope anyway, so applications can't call
> symbols from it anyway unless doing lots of magic.

Ok. I'm linking to the vdso directly from test apps at the moment but
that will die as soon as glibc has been adapted. Just let me know what
you prefer. I can keep the descriptors as-is and glibc would take care
of offset'ing properly when calling them, or I could try to find some
way to export different symbols like Ulrich suggested... whatever you
prefer for the glibc side.

Ben.


