Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317602AbSFNNqt>; Fri, 14 Jun 2002 09:46:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317912AbSFNNqs>; Fri, 14 Jun 2002 09:46:48 -0400
Received: from shiva.jussieu.fr ([134.157.0.129]:24843 "EHLO shiva.jussieu.fr")
	by vger.kernel.org with ESMTP id <S317602AbSFNNqr>;
	Fri, 14 Jun 2002 09:46:47 -0400
Date: Fri, 14 Jun 2002 15:46:47 +0200 (CEST)
Message-Id: <200206141346.g5EDklY65153@helium.pps.jussieu.fr>
To: linux-kernel@vger.kernel.org
Subject: Re: Very large font size crashing X Font Server and Grounding Server to a Halt (was: remote DoS in Mozilla 1.0)
From: Juliusz Chroboczek <jch@pps.jussieu.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

To answer a couple of the questions in this thread.

The Type 1 backend currently in XFree86 (originally by IBM and
Lexmark) uses static memory allocation (it was designed for embedded
systems) and does indeed have very poor error handling.  The current
plan is to replace the Type 1 backend altoghether with a unified Type
1 and TrueType backend based on the FreeType library.  This will
hopefully happen in 4.3.0.

As far as I know, nobody is currently working on fixing the (legacy)
Type 1 backend.  While patches to fix its behaviour are likely to get
accepted, I think that getting the Type 1 backend to work reasonably
is more work than it's worth now that FreeType does a decent job with
Type 1 fonts.

As to out of memory allocations: with a few exceptions, the core X
server code deals smartly with malloc returning NULL: the current
client receives a BadAlloc error (``insufficient resources''), and
other clients are not bothered.  (On the other hand, it is a rare
client that will deal gracefully with a BadAlloc; and if it's your
window manager that gets the error, all hell breaks loose.)

With current Linux kernels, this careful coding brings no benefit
whatsover, as malloc never (?) returns NULL.  What is worse, as far as
I know the kernel doesn't send advance warning of an OOM situation; it
would not be too difficult to stop allocating memory when that happens.

I suggest xpert at xfree86.org as the right list to continue this
discussion.  If you follow up on linux-kernel, please be so kind as to
CC me.

Regards,

                                        Juliusz Chroboczek

P.S. As always, none of the above represents an official position of
the XFree86 project, but merely my personal perception of the
situation.  This message may or may not have any sort of relationship
with reality.
