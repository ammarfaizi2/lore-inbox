Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262168AbVAIAuA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262168AbVAIAuA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 19:50:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262169AbVAIAuA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 19:50:00 -0500
Received: from pastinakel.tue.nl ([131.155.2.7]:17420 "EHLO pastinakel.tue.nl")
	by vger.kernel.org with ESMTP id S262168AbVAIAtz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 19:49:55 -0500
Date: Sun, 9 Jan 2005 01:49:49 +0100
From: Andries Brouwer <aebr@win.tue.nl>
To: Andreas Schwab <schwab@suse.de>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Lukasz Trabinski <lukasz@wsisiz.edu.pl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: uselib()  & 2.6.X?
Message-ID: <20050109004949.GF6052@pclin040.win.tue.nl>
References: <Pine.LNX.4.58LT.0501071648160.30645@oceanic.wsisiz.edu.pl> <20050107170712.GK29176@logos.cnet> <1105136446.7628.11.camel@localhost.localdomain> <Pine.LNX.4.58.0501071609540.2386@ppc970.osdl.org> <20050107221255.GA8749@logos.cnet> <Pine.LNX.4.58.0501081042040.2386@ppc970.osdl.org> <je8y73zl35.fsf@sykes.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <je8y73zl35.fsf@sykes.suse.de>
User-Agent: Mutt/1.4.2i
X-Spam-DCC: dmv.com: pastinakel.tue.nl 1181; Body=1 Fuz1=1 Fuz2=1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 08, 2005 at 10:07:10PM +0100, Andreas Schwab wrote:
> Linus Torvalds <torvalds@osdl.org> writes:
> 
> > Another issue is likely that we should make the whole "uselib()"
> > interfaces configurable. I don't think modern binaries use it (where
> > "modern" probably means "compiled within the last 8 years" ;).
> 
> I don't think it was ever being used for anything besides a.out so IMHO it
> should depend on BINFMT_AOUT.

Let me contribute a man page. Comments welcome (-> aeb@cwi.nl).

USELIB(2)           Linux Programmer's Manual           USELIB(2)

NAME
       uselib - load shared library

SYNOPSIS
       #include <unistd.h>

       int uselib(const char *library);

DESCRIPTION
       The  system call uselib serves to load a shared library to
       be used by the calling process.  It is given  a  pathname.
       The  address where to load is found in the library itself.
       The library can have any recognized binary format.

RETURN VALUE
       On success, zero is returned.  On error, -1  is  returned,
       and errno is set appropriately.

ERRORS
       In  addition to all of the error codes returned by open(2)
       and mmap(2), the following may also be returned:

       EACCES The library specified by library is  not  readable,
              or  the  caller does not have search permission for
              one of the directories in  the  path  prefix.  (See
              also path_resolution(2).)

       ENFILE The  system limit on the total number of open files
              has been reached.

       ENOEXEC
              The file specified by library is not executable, or
              does not have the correct magic numbers.

CONFORMING TO
       uselib() is Linux specific, and should not be used in pro-
       grams intended to be portable.

NOTES
       uselib() was used by early libc (up to libc  4.3)  startup
       code  to  load the shared libraries with names found in an
       array of names in the binary.

       Later code tries to prefix these  names  with  "/usr/lib",
       "/lib" and "" before giving up.  In libc 4.4.1 these names
       are   looked   for   in   the   directories    found    in
       LD_LIBRARY_PATH,   and   if   not  found  there,  prefixes
       "/usr/lib", "/lib" and "/" are tried.

       From libc  4.4.4  on  only  the  library  "/lib/ld.so"  is
       loaded,  so that this dynamic library can load the remain-
       ing libraries needed.  This is also the state  of  affairs
       in libc5.

       glibc2 does not use this call.

SEE ALSO
       ar(1),  gcc(1),  ld(1), ldd(1), mmap(2), open(2), capabil-
       ity(7), ld.so(8)

Linux 2.6.10                2005-01-09                  USELIB(2)
