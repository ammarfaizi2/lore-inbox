Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135597AbRDSIyT>; Thu, 19 Apr 2001 04:54:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135599AbRDSIyK>; Thu, 19 Apr 2001 04:54:10 -0400
Received: from smtp2.libero.it ([193.70.192.52]:8149 "EHLO smtp2.libero.it")
	by vger.kernel.org with ESMTP id <S135597AbRDSIx6>;
	Thu, 19 Apr 2001 04:53:58 -0400
Message-ID: <3ADEA746.D3A44511@alsa-project.org>
Date: Thu, 19 Apr 2001 10:52:22 +0200
From: Abramo Bagnara <abramo@alsa-project.org>
Organization: Opera Unica
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.19 i586)
X-Accept-Language: it, en
MIME-Version: 1.0
To: Alon Ziv <alonz@nolaviz.org>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mike Kravetz <mkravetz@sequent.com>,
        Ulrich Drepper <drepper@cygnus.com>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: light weight user level semaphores
In-Reply-To: <Pine.LNX.4.31.0104171200220.933-100000@penguin.transmeta.com> <m33db680h8.fsf@otr.mynet.cygnus.com> <023c01c0c8a9$a4bb9940$910201c0@zapper>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alon Ziv wrote:
> 
> Hmm...
> I already started (long ago, and abandoned since due to lack of time :-( )
> down another path; I'd like to resurrect it...
> 
> My lightweight-semaphores were actually even simpler in userspace:
> * the userspace struct was just a signed count and a file handle.
> * Uncontended case is exactly like Linus' version (i.e., down() is decl +
> js, up() is incl()).
> * The contention syscall was (in my implementation) an ioctl on the FH; the
> FH was a special one, from a private syscall (although with the new VFS I'd
> have written it as just another specialized FS, or even referred into the
> SysVsem FS).
> 
> So, there is no chance for user corruption of kernel data (as it just ain't
> there...); and the contended-case cost is probably equivalent (VFS cost vs.
> validation).

This would also permit:
- to have poll()
- to use mmap() to obtain the userspace area

It would become something very near to sacred Unix dogmas ;-)

-- 
Abramo Bagnara                       mailto:abramo@alsa-project.org

Opera Unica                          Phone: +39.546.656023
Via Emilia Interna, 140
48014 Castel Bolognese (RA) - Italy

ALSA project               http://www.alsa-project.org
It sounds good!
