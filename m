Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281200AbRKTST1>; Tue, 20 Nov 2001 13:19:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281196AbRKTSTS>; Tue, 20 Nov 2001 13:19:18 -0500
Received: from schroeder.cs.wisc.edu ([128.105.6.11]:26385 "EHLO
	schroeder.cs.wisc.edu") by vger.kernel.org with ESMTP
	id <S281214AbRKTSTL>; Tue, 20 Nov 2001 13:19:11 -0500
Message-Id: <200111201819.fAKIJ1t31774@schroeder.cs.wisc.edu>
Content-Type: text/plain;
  charset="iso-8859-1"
From: Nick LeRoy <nleroy@cs.wisc.edu>
Organization: UW Condor
To: =?iso-8859-1?q?Lu=EDs=20Henriques?= 
	<lhenriques@criticalsoftware.com>,
        Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: copy to suer space
Date: Tue, 20 Nov 2001 12:18:02 -0600
X-Mailer: KMail [version 1.3.1]
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <5.1.0.14.2.20011120165440.00a745b0@pop.cus.cam.ac.uk> <5.1.0.14.2.20011120173309.0262fd10@pop.cus.cam.ac.uk> <200111201759.fAKHx9289954@criticalsoftware.com>
In-Reply-To: <200111201759.fAKHx9289954@criticalsoftware.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 20 November 2001 11:53, Luís Henriques wrote:
> > There is a time window in which it might get paged out in the mean time
> > but it's admittedly a very small window. But that is irrelevant as
> > copy_to_user would take care of the page out case by faulting the page
> > back in (that is at least my understanding of it).
> >
> > But that is not the problem I was talking about: Imagine you do
> > successfully modify the user space code and AFTER THAT the kernel pages
> > out the code and pages it back in later. Your change is then lost without
> > trace.
> >
> > That can easily crash your program depending on what modifications you do
> > to it...
> >
> > Anton
>
> I don't understand... this means that the paging does not save the a code
> segment in memory? (sorry, this question is being done by a newbie...) When
> a page is back to memory, what happens? Is read again from the binary file
> (executable)?
>
> Well... I don't think this will have much impact in my module because what
> it does is:
>
>  - change the code in a process
>  - return to the process
>  - next time the process is scheduled, the code will be stored again in the
> CS
>
> So, I don't think that the paging will really became a problem as this
> shall be quiet fast! The idea of changing the code is just to insert a
> delay in a process, but leaving the process «burning» CPU time...
>
> The point is: I'm not changing the code because of an obscure (to me...)
> reason. You told me that the code segment may be protected and I'm
> investigating on that but I would like to be sure that the kernel has no
> acess to a user CS...

Linux executables are "demand paged".  What this means is that they are 
loaded as they are "page faulted" in.  If low on memory, the kernel may, at 
it's discression, discard text pages at any time.  When a discarded page is 
referenced, a page fault occurs, and the page is re-loaded from the 
executable.  They are *never* written out to swap space.  The kernel fully 
expects the text file and the text memory pages to not be modified during 
execution.

-Nick
