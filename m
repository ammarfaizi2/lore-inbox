Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263123AbRFLTIh>; Tue, 12 Jun 2001 15:08:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263058AbRFLTI2>; Tue, 12 Jun 2001 15:08:28 -0400
Received: from gene.pbi.nrc.ca ([204.83.147.150]:19253 "EHLO gene.pbi.nrc.ca")
	by vger.kernel.org with ESMTP id <S263106AbRFLTIU>;
	Tue, 12 Jun 2001 15:08:20 -0400
Date: Tue, 12 Jun 2001 13:07:11 -0600 (CST)
From: <ognen@gene.pbi.nrc.ca>
To: Christoph Hellwig <hch@ns.caldera.de>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: threading question
In-Reply-To: <200106121858.f5CIwmX05650@ns.caldera.de>
Message-ID: <Pine.LNX.4.30.0106121304320.24593-100000@gene.pbi.nrc.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

due to the nature of the problem (a pairwise mutual alignment of n
sequences results in mx. n^2 alignments which can each be done in a
separate thread), I need to create and destroy the threads frequently.

I am not really comfortable with 1.4 - 1.5 speedups since the solution was
intended as a Linux one primarily and it just happenned that it works (and
now even better) on Solaris/SGI/OSF...

Best regards,
Ognen

On Tue, 12 Jun 2001, Christoph Hellwig wrote:

> In article <Pine.LNX.4.30.0106121213570.24593-100000@gene.pbi.nrc.ca> you wrote:
> > On dual-CPU machines the speedups are as follows: my version
> > is 1.88 faster than the sequential one on IRIX, 1.81 times on Solaris,
> > 1.8 times on OSF/1, 1.43 times on Linux 2.2.x and 1.52 times on Linux 2.4
> > kernel. Why are the numbers on Linux machines so much lower?
>
> Does your measurement include the time needed to actually create the
> threads or do you even frequently create and destroy threads?
>
> The code for creating threads is _horribly_ slow in Linuxthreads due
> to the way it is implemented.
>
> > It is the
> > same multi-threaded code, I am not using any tricks, the code basically
> > uses PTHREAD_CREATE_DETACHED and PTHREAD_SCOPE_SYSTEM and the thread stack
> > size is set to 8K (but the numbers are the same with larger/smaller stack
> > sizes).
> >
> > Is there anything I am missing? Is this to be expected due to Linux way of
> > handling threads (clone call)? I am just trying to explain the numbers and
> > nothing else comes to mind....
>
> Linuxthreads is a rather bad pthreads implementation performance-wise,
> mostly due to the rather different linux-native threading model.
>
> 	Christoph

