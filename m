Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284015AbRLAJMA>; Sat, 1 Dec 2001 04:12:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284016AbRLAJLv>; Sat, 1 Dec 2001 04:11:51 -0500
Received: from web20502.mail.yahoo.com ([216.136.226.137]:34375 "HELO
	web20502.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S284015AbRLAJLl>; Sat, 1 Dec 2001 04:11:41 -0500
Message-ID: <20011201091140.62223.qmail@web20502.mail.yahoo.com>
Date: Sat, 1 Dec 2001 10:11:40 +0100 (CET)
From: =?iso-8859-1?q?willy=20tarreau?= <wtarreau@yahoo.fr>
Subject: Re: Did someone try to boot 2.4.16 on a 386 ? [SOLVED] 
To: Keith Owens <kaos@ocs.com.au>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <11661.1007177721@ocs3.intra.ocs.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> A perfect example of why having the same tree for
> source and generated files and using cp -al is a
> bad idea.  cp -al picks up both source and
> objects and you have to hope that anything that is
> overwritten is hard link safe (I can tell you now
> that it is not).

well, at least I only duplicate clean sources before
applying a patch. So there is absolutely no shared
object. It's just that when I try patches, I have
about 20 source trees and it's cool to have the
ability to navigate through versions without having
to store 3 GB. Moreover, diff -urN is much faster
this way. But it true that this is a "use at your own
risk".

> kbuild 2.5 allows multiple builds from the same
> source tree into separate object trees
> with different configs and is safe.

Interesting, I think I'll definitely take a look at
it.
 
> >I'll check around to see if there are other parts
> >which risk to modify a file on disk without
> previously
> >unlink it.
> 
> Any Makefile that does "some_command > target_file"
> or runs a utility that does open(O_TRUNC) instead
> of unlink(), open(O_EXCL).

there was such an example in the past with aicasm.
Anyway, I think that any tool, script or Makefile
that modifies the source tree and which results in
a diff between the two trees after a "make distclean"
is at risk because it can induce diffs between some
files that can't always apply to another clean tree.

> BTW, cp -al of a pristine source tree to multiple
> source trees followed by multiple compiles in
> parallel is not safe either. make dep relies on
> changing time stamps for include files, because
> the include files are hard linked, a change in
> one compile affects the other trees, with
> undefined results.  Also fixed in kbuild 2.5.

Never needed to do that yet.

Regards,
Willy


___________________________________________________________
Do You Yahoo!? -- Une adresse @yahoo.fr gratuite et en français !
Yahoo! Courrier : http://courrier.yahoo.fr
