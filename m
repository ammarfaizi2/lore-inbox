Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263020AbRFLTAO>; Tue, 12 Jun 2001 15:00:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263058AbRFLTAE>; Tue, 12 Jun 2001 15:00:04 -0400
Received: from ns.caldera.de ([212.34.180.1]:21643 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S263020AbRFLS7w>;
	Tue, 12 Jun 2001 14:59:52 -0400
Date: Tue, 12 Jun 2001 20:58:48 +0200
Message-Id: <200106121858.f5CIwmX05650@ns.caldera.de>
From: Christoph Hellwig <hch@ns.caldera.de>
To: <ognen@gene.pbi.nrc.ca>
Cc: linux-kernel@vger.kernel.org
Subject: Re: threading question
X-Newsgroups: caldera.lists.linux.kernel
In-Reply-To: <Pine.LNX.4.30.0106121213570.24593-100000@gene.pbi.nrc.ca>
User-Agent: tin/1.4.4-20000803 ("Vet for the Insane") (UNIX) (Linux/2.4.2 (i686))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.LNX.4.30.0106121213570.24593-100000@gene.pbi.nrc.ca> you wrote:
> On dual-CPU machines the speedups are as follows: my version
> is 1.88 faster than the sequential one on IRIX, 1.81 times on Solaris,
> 1.8 times on OSF/1, 1.43 times on Linux 2.2.x and 1.52 times on Linux 2.4
> kernel. Why are the numbers on Linux machines so much lower?

Does your measurement include the time needed to actually create the
threads or do you even frequently create and destroy threads?

The code for creating threads is _horribly_ slow in Linuxthreads due
to the way it is implemented.

> It is the
> same multi-threaded code, I am not using any tricks, the code basically
> uses PTHREAD_CREATE_DETACHED and PTHREAD_SCOPE_SYSTEM and the thread stack
> size is set to 8K (but the numbers are the same with larger/smaller stack
> sizes).
>
> Is there anything I am missing? Is this to be expected due to Linux way of
> handling threads (clone call)? I am just trying to explain the numbers and
> nothing else comes to mind....

Linuxthreads is a rather bad pthreads implementation performance-wise,
mostly due to the rather different linux-native threading model.

	Christoph

-- 
Of course it doesn't work. We've performed a software upgrade.
