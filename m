Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316477AbSFEWUD>; Wed, 5 Jun 2002 18:20:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316484AbSFEWUD>; Wed, 5 Jun 2002 18:20:03 -0400
Received: from tolkor.sgi.com ([192.48.180.13]:7143 "EHLO tolkor.sgi.com")
	by vger.kernel.org with ESMTP id <S316477AbSFEWUC>;
	Wed, 5 Jun 2002 18:20:02 -0400
Subject: Re: [RFC] 4KB stack + irq stack for x86
From: Steve Lord <lord@sgi.com>
To: Benjamin LaHaise <bcrl@redhat.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>
In-Reply-To: <20020604225539.F9111@redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 05 Jun 2002 17:15:23 -0500
Message-Id: <1023315323.17160.522.camel@jen.americas.sgi.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-06-04 at 21:55, Benjamin LaHaise wrote:
> Hey folks,
> 
>
> 
> I had been playing with 2.5KB stacks (4KB page minus 1.5K for task_struct), 
> and it is possible given a few fixes for massive (>1KB) stack allocation 
> in the pci layer and a few others.  So far 4KB hasn't overflowed on any 
> of the tasks I normally run (checked using a stack overflow checker that 
> follows).
> 

Ben,

Just what are the tasks you normally run - and how many code
paths do you think there are out there which you do not run. XFS
might get a bit stack hungry in places, we try to keep it down,
but when you get into file system land things can stack up quickly:

	NFS server -> file system -> block layer -> device driver

With possibly some form of volume management out there too.

I am pounding away on xfs with your code in there including the
checker, and so far it is surviving. But I only have a plain old
scsi drive underneath, and no NFS on top.

Steve

-- 

Steve Lord                                      voice: +1-651-683-3511
Principal Engineer, Filesystem Software         email: lord@sgi.com
