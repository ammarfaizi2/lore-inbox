Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266290AbRGLWki>; Thu, 12 Jul 2001 18:40:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266400AbRGLWk2>; Thu, 12 Jul 2001 18:40:28 -0400
Received: from vti01.vertis.nl ([145.66.4.26]:28691 "EHLO vti01.vertis.nl")
	by vger.kernel.org with ESMTP id <S266290AbRGLWkO>;
	Thu, 12 Jul 2001 18:40:14 -0400
Message-ID: <938F7F15145BD311AECE00508B7152DB034C48C0@vts007.vertis.nl>
From: Rolf Fokkens <FokkensR@vertis.nl>
To: "'Mark Hahn'" <hahn@coffee.psychology.mcmaster.ca>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: Kernel 2.4.6: Why doesn't mprotect () check ulimit/rlim?
Date: Fri, 13 Jul 2001 00:39:23 +0200
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'd expect the same and strace may have missed the preceding mmap. However
/proc/<PID>/maps shows all the mprotect results. Before the mprotect call
the memory doesn't show up in /proc/<PID>/maps which makes me the think
there hasen't been a prior mmap, brk or whatever.

-----Original Message-----
From: Mark Hahn [mailto:hahn@coffee.psychology.mcmaster.ca]
Sent: Friday, July 13, 2001 12:14 AM
To: Rolf Fokkens
Subject: Re: Kernel 2.4.6: Why doesn't mprotect () check ulimit/rlim?


> While trying to restrict Oracle's memory claims I tried a strace while
> making Oracle claim huge amounts of memory. It appears that Oracle claims
> all it's memory by calling mprotect, which (unlike brk ()) doesn't check
> rlim.

afaik, mprotect only modifies page protection; it doesn't allocate.
it's the preceeding mmap that should check limits.
