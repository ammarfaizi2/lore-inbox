Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271333AbRIOTRl>; Sat, 15 Sep 2001 15:17:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272519AbRIOTRc>; Sat, 15 Sep 2001 15:17:32 -0400
Received: from smtp6.mindspring.com ([207.69.200.110]:20798 "EHLO
	smtp6.mindspring.com") by vger.kernel.org with ESMTP
	id <S272518AbRIOTRR>; Sat, 15 Sep 2001 15:17:17 -0400
Subject: Re: Feedback on preemptible kernel patch
From: Robert Love <rml@tech9.net>
To: phillips@bonn-fries.net
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.13.99+cvs.2001.09.14.18.39 (Preview Release)
Date: 15 Sep 2001 15:18:16 -0400
Message-Id: <1000581501.32705.46.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2001-09-09 at 23:24, Daniel Phillips wrote:
> This may not be your fault.  It's a GFP_NOFS recursive allocation - this
> comes either from grow_buffers or ReiserFS, probably the former.  In
> either case, it means we ran completely out of free pages, even though
> the caller is willing to wait.  Hmm.  It smells like a loophole in vm
> scanning.

Hi, Daniel.  If you remember, a few users of the preemption patch
reported instability and/or syslog messages such as:

Sep  9 23:08:02 sjoerd kernel: __alloc_pages: 0-order allocation failed (gfp=0x70/1).
Sep  9 23:08:02 sjoerd last message repeated 93 times
Sep  9 23:08:02 sjoerd kernel: cation failed (gfp=0x70/1).
Sep  9 23:08:02 sjoerd kernel: __alloc_pages: 0-order allocation failed (gfp=0x70/1).
Sep  9 23:08:02 sjoerd last message repeated 281 times

It now seems that all of them are indeed using ReiserFS.  There are no
other reported problems with the preemption patch, except from those
users...

I am beginning to muse over the source, looking at when kmalloc is
called with GFP_NOFS in ReiserFS, and then the path that code takes in
the VM source.

I assume the kernel VM code has a hole somewhere, and the request is
falling through?  It should wait, even if no pages were free so, right? 

Where should I begin looking?  How does it relate to ReiserFS?  How is
preemption related?

Thank you very much,

-- 
Robert M. Love
rml at ufl.edu
rml at tech9.net

