Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262639AbTCTVnO>; Thu, 20 Mar 2003 16:43:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262641AbTCTVnO>; Thu, 20 Mar 2003 16:43:14 -0500
Received: from marc2.theaimsgroup.com ([63.238.77.172]:3591 "EHLO
	mailer.progressive-comp.com") by vger.kernel.org with ESMTP
	id <S262639AbTCTVnN>; Thu, 20 Mar 2003 16:43:13 -0500
Date: Thu, 20 Mar 2003 16:54:13 -0500
Message-Id: <200303202154.h2KLsDcT009516@marc2.theaimsgroup.com>
From: Hank Leininger <linux-kernel@progressive-comp.com>
Reply-To: Hank Leininger <hlein@progressive-comp.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Deprecating .gz format on kernel.org
X-Shameless-Plug: Check out http://marc.theaimsgroup.com/
X-Warning: This mail posted via a web gateway at marc.theaimsgroup.com
X-Warning: Report any violation of list policy to abuse@progressive-comp.com
X-Posted-By: Hank Leininger <hlein@progressive-comp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2003-03-20, Joern Engel <joern () wohnheim ! fh-wedel ! de> wrote:
> On Thu, 20 March 2003 17:39:20 +0000, Jamie Lokier wrote:
> > (b) On something as large as a .tar, decompressing a bz2 file to
> > check the signature is really quite slow, compared with checking the
> > signature of the compressed file.

> That shouldn't matter, most of the times. If you want to build the
> code, you have to [bg]unzip anyway, so there is no extra cost.
> And I have a hard time to think of a real-world application where you
> don't want to unpack but need to verify the signature.

A few come to mind:
-To verify and then use a .tar.[bg]z2?, you must gpg --verify and then
  tar -x[jz]vf, but to unpack, then verify, then use you must uncompress
  to a tempfile or pipe to gpg, then verify, then untar.  Silly waste of
  CPU and/or disk space.[*]
-Verifying downloads immediately, when they won't necessarily be needed /
  used right away; no need to unpack until it's needed, but would like to
  know the download is bad right away.
-Verifying something pulled down to one machine before scp'ing it elsewhere
  where it will actually be used.
-Verifying before [bg]unzip means you won't expose [bg]unzip to likely
  malicious data (think bugs in [bg]unzip which make them crash on bad
  compressed files).  Of course GPG/PGP is still subject to input-based 
  bugs, but they are in any case; no need for the decompression tools to
  be as well.

[*] ...Now if tar had a --sig option to chain gpg between gunzip and 
    untar... but that would just be Wrong.

--
Hank Leininger <hlein@progressive-comp.com> 
  
