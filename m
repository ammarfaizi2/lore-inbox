Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285273AbSACKMf>; Thu, 3 Jan 2002 05:12:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285269AbSACKM0>; Thu, 3 Jan 2002 05:12:26 -0500
Received: from samba.sourceforge.net ([198.186.203.85]:3338 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S285273AbSACKMN>;
	Thu, 3 Jan 2002 05:12:13 -0500
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15412.11822.811712.207946@argo.ozlabs.ibm.com>
Date: Thu, 3 Jan 2002 21:10:54 +1100 (EST)
To: Richard Henderson <rth@redhat.com>
Cc: Tom Rini <trini@kernel.crashing.org>, jtv <jtv@xs4all.nl>,
        Momchil Velikov <velco@fadata.bg>, linux-kernel@vger.kernel.org,
        gcc@gcc.gnu.org, linuxppc-dev@lists.linuxppc.org,
        Franz Sirl <Franz.Sirl-kernel@lauterbach.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Corey Minyard <minyard@acm.org>
Subject: Re: [PATCH] C undefined behavior fix
In-Reply-To: <20020103003240.A10838@redhat.com>
In-Reply-To: <87g05py8qq.fsf@fadata.bg>
	<20020102190910.GG1803@cpe-24-221-152-185.az.sprintbbd.net>
	<20020102133632.C10362@redhat.com>
	<20020102220548.GL1803@cpe-24-221-152-185.az.sprintbbd.net>
	<20020102232320.A19933@xs4all.nl>
	<20020102231243.GO1803@cpe-24-221-152-185.az.sprintbbd.net>
	<20020103004514.B19933@xs4all.nl>
	<20020103000118.GR1803@cpe-24-221-152-185.az.sprintbbd.net>
	<20020102160739.A10659@redhat.com>
	<15411.49911.958835.299377@argo.ozlabs.ibm.com>
	<20020103003240.A10838@redhat.com>
X-Mailer: VM 6.75 under Emacs 20.7.2
Reply-To: paulus@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard Henderson writes:

> On Thu, Jan 03, 2002 at 01:33:27PM +1100, Paul Mackerras wrote:
> > I look forward to seeing your patch to remove all uses of
> > virt_to_phys, phys_to_virt, __pa, __va, etc. from arch/alpha... :)
> 
> I don't dereference them either, do I?

Does that matter?  To quote your earlier message:

> No.  You still have the problem of using pointer arithmetic past
> one past the end of the object.
> 
> C99 6.5.6/8:
> 
>    If both the pointer operand and the result point to elements of the
>    same array object, or one past the last element of the array object,
>    the evaluation shall not produce an overflow; otherwise, the behavior
>    is undefined.

I don't have a copy of the C standard handy, but that sounds to me
like the result of (unsigned long)(&x) - KERNELBASE is undefined.

Also, what does the standard say about casting pointers to integral
types?  IIRC you aren't entitled to assume that a pointer will fit in
any integral type, or anything about the bit patterns that you get.

My point is that the kernel makes some assumptions about how pointers
are represented, which are eminently reasonable assumptions, but which
"portable" C programs are not entitled to make according to the C
standard.

Paul.
