Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263001AbUIIMBY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263001AbUIIMBY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 08:01:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267283AbUIIMBY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 08:01:24 -0400
Received: from gate.crashing.org ([63.228.1.57]:43719 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S263001AbUIIMBL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 08:01:11 -0400
Subject: Re: vDSO for ppc64 : Preliminary release #3
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Cc: Jakub Jelinek <jakub@redhat.com>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       linuxppc64-dev <linuxppc64-dev@lists.linuxppc.org>,
       Ulrich Drepper <drepper@redhat.com>
In-Reply-To: <16704.15604.289019.476483@cargo.ozlabs.ibm.com>
References: <1094719382.2543.62.camel@gaston>
	 <20040909091208.GY31909@devserv.devel.redhat.com>
	 <16704.15604.289019.476483@cargo.ozlabs.ibm.com>
Content-Type: text/plain
Message-Id: <1094731188.2543.76.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 09 Sep 2004 21:59:49 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-09-09 at 21:22, Paul Mackerras wrote:
> Jakub Jelinek writes:
> 
> > That is on purpose, even if vDSO location is randomized (e.g. on IA-32),
> > no relocations should happen, so that the vDSO can be shared (unless
> > written into by the debugger, that is).  ld.so knows how to deal with
> > .dynamic section relocation of vDSOs.
> 
> On 64-bit architectures which use procedure descriptors, the
> descriptors will have to be relocated (unless you or Alan can come up
> with some toolchain or ld.so magic or something).  But the descriptors
> are in the data section rather than the text, of course.

In the case of the ppc vDSO, there is no .data section, the descriptors
are in the .opd section along with the .text, but that isn't a problem.
That means that 1 page of vDSO text will be COW'ed for the few apps that
request a different address (again, unless we want randomizing). The
vDSO also has a special data page that _has_ to be shared, but it's
separate and doesn't overlap the actual .so pages so it shouldn't be
affected by a possible relocation.

Of course, unless somebody comes up with a clever trick to avoid those
altogether...

Ben.


