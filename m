Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269833AbRHDIPj>; Sat, 4 Aug 2001 04:15:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269836AbRHDIPb>; Sat, 4 Aug 2001 04:15:31 -0400
Received: from krusty.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:52489 "HELO
	krusty.e-technik.uni-dortmund.de") by vger.kernel.org with SMTP
	id <S269837AbRHDIPW>; Sat, 4 Aug 2001 04:15:22 -0400
Date: Sat, 4 Aug 2001 06:29:27 +0200
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: "Patrick J. LoPresti" <patl@cag.lcs.mit.edu>
Cc: Matthias Andree <matthias.andree@stud.uni-dortmund.de>,
        linux-kernel@vger.kernel.org
Subject: Re: ext3-2.4-0.9.4
Message-ID: <20010804062927.K16516@emma1.emma.line.org>
Mail-Followup-To: "Patrick J. LoPresti" <patl@cag.lcs.mit.edu>,
	linux-kernel@vger.kernel.org
In-Reply-To: <01080317471707.01827@starship> <20010803121638.A28194@cs.cmu.edu> <0108031854120A.01827@starship> <Pine.LNX.4.33L.0107301320370.11893-100000@imladris.rielhome.conectiva> <s5gvgkacqlm.fsf@egghead.curl.com> <200107301711.f6UHBWHE001945@acap-dev.nas.cmu.edu> <20010803132457.A30127@cs.cmu.edu> <s5g3d78261g.fsf@egghead.curl.com> <20010804051320.B16516@emma1.emma.line.org> <s5gr8usmqkg.fsf@egghead.curl.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <s5gr8usmqkg.fsf@egghead.curl.com>
User-Agent: Mutt/1.3.19i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 03 Aug 2001, Patrick J. LoPresti wrote:

> To avoid this, Postfix *must* do fsync() or fdatasync() after the
> write() and before the fchmod()+fsync(); that will insure that the
> execute bit implies valid ("committed") data in the file.  I was
> unable to find any such call to fsync() or fdatasync(), but as I
> mentioned, I am probably simply misreading the code.

Thanks for clarifying, I'm asking Wietse to figure if Postfix's
queue file format is sufficient to check integrity.

> > It looks so to me. After the MTA behaviour has been dug up, the
> > dirsync option could be even weaker if fsync() behaved like FFS +
> > softupdates: sync the directory entries, including those of link and
> > rename, as well.
> 
> Ideally, this would be an option you could set per-application (as
> opposed to per-directory or per-mountpoint), because we are really
> talking about allowing Linux to support applications written for BSD
> file system semantics.  It is not obvious to me what the best
> implementation for that would be, though.  Maybe just a compile-time
> option to choose the appropriate open/link/rename/etc. operations.

To add to that confusion and alternatvies:
HAVE: async, sync
SUGGEST: 1. BSD dirsync, 2. "weak" unlink/symlink dirsync and have
fsync() track and sync pending link/rename as well, 3. make just symlink
dirsync, 4. be confused of all the options.

Where this could be set: directory inode flag, mount option, process
flag (like umask), include file.


Seriously, if fsync() syncs the effects of link and rename as well,
there's no need to make them synchronous unconditionally except if one
wants to offer a "traditional BSD synchronous directory semantics" mode. 

-- 
Matthias Andree
