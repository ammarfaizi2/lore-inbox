Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132925AbRDEPfB>; Thu, 5 Apr 2001 11:35:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132928AbRDEPev>; Thu, 5 Apr 2001 11:34:51 -0400
Received: from medusa.sparta.lu.se ([194.47.250.193]:40536 "EHLO
	medusa.sparta.lu.se") by vger.kernel.org with ESMTP
	id <S132925AbRDEPek>; Thu, 5 Apr 2001 11:34:40 -0400
Date: Thu, 5 Apr 2001 16:16:57 +0200 (MET DST)
From: Bjorn Wesen <bjorn@sparta.lu.se>
To: Jani Monoses <jani@virtualro.ic.ro>
cc: linux-kernel@vger.kernel.org
Subject: Re: ERESTARTSYS question.
In-Reply-To: <Pine.LNX.4.10.10104051801410.29033-100000@virtualro.ic.ro>
Message-ID: <Pine.LNX.3.96.1010405161227.30281C-100000@medusa.sparta.lu.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Apr 2001, Jani Monoses wrote:
> although the comments in errno.h say that ERESTARTSYS should not be seen
> by userland,many drivers seam to return it from their
> file_operations.Should glibc convert this errno so that the user program
> sees something meaningful?Because it does not.Is EINTR not a better errno 
> to return from the drivers?

ERESTARTSYS is a part of the api between the driver and the
signal-handling code in the kernel. It does not reach user-space (provided
of course that it's used appropriately in the drivers :) 

When a driver needs to wait, and get awoken by a signal (as opposed to
what it's really waiting for) the driver should in most cases abort the
system call so the signal handler can be run (like, you push ctrl-c while
running somethinig that's stuck in a wait for an interrupt). The kernel
uses the ERESTARTSYS as a "magic" value saying it's ok to restart the
system call automagically after the signal handling is done. The actual
return-code is switched to EINTR if the system call could not be
restarted.

-Bjorn

