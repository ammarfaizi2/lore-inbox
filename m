Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262116AbREaSyG>; Thu, 31 May 2001 14:54:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263159AbREaSx4>; Thu, 31 May 2001 14:53:56 -0400
Received: from comverse-in.com ([38.150.222.2]:5836 "EHLO
	eagle.comverse-in.com") by vger.kernel.org with ESMTP
	id <S262116AbREaSxo>; Thu, 31 May 2001 14:53:44 -0400
Message-ID: <6B1DF6EEBA51D31182F200902740436802678F0D@mail-in.comverse-in.com>
From: "Khachaturov, Vassilii" <Vassilii.Khachaturov@comverse.com>
To: "'Mark Frazer'" <mark@somanetworks.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: RE: Makefile patch for cscope and saner Ctags
Date: Thu, 31 May 2001 14:52:52 -0400
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Mark Frazer [mailto:mark@somanetworks.com]
> Khachaturov, Vassilii <Vassilii.Khachaturov@comverse.com> 
> > Great stuff. May I suggest adding -k to the cscope cmdline:
> >   +	cscope -b -k -I include
> 
> The cscope on my RH7.0 box didn't take -k!
> [root@mjftest linux-2.4.5]# cscope -b -k -I include
> cscope: unknown option: -k
> [root@mjftest linux-2.4.5]# rpm -qf /usr/bin/cscope
> cscope-13.0-6
> 
> weird, as man cscope documents -k's existence

Don't forget to bug RH package maintainer on that. Whatever 
version they ship (I don't know, maybe 13 indeed didn't have -k) 
the mans and the binaries must be consistent. 

I use source-built cscope v.15.1, and -k works for me here, 
atop RH70 too. You can download it 
at http://cscope.sourceforge.net And, the cscope project
guys are very responsive and willing to fix/implement things
in their product. 

(BTW, anyone here knows how to submit
a cvsweb patch/bug and get an answer? cvsweb at sourceforge
seems dead, as well as cvsweb.org :-( )

You definitely want -k in the kernel Makefile to avoid 
irrelevant things from /usr/include!!!

> I didn't see a way to add >>'ing the file to cscope.files 
> without greping
> for it's entrance there already.  So I've left the find ... method of
> creating cscope.files.

Sorry for being unclear. I meant: output the new find results into smth like
.cscope.files, then compare (cmp -s) it to the current cscope.files,
and replace the latter with it ONLY if there were diffs:
> > The new .files should be created  in a different file, and the old file
> > shouldn't be replaced if there's no change.

> cscope.out is now built by a shell command which does the checking
> against the age of the files in cscope.files

WHY?! Isn't it better to put $(shell cat cscope.files) on the list of
cscope.out
dependencies? Or, maybe better yet,

cscope.make: cscope.files
	echo -n 'cscope.out: ' > .$@
	cat $< >> .$@	
	mv .$@ $@

include cscope.make

(or should it be `-include' here?)

> Backout the old patch and try this one.

[patch mostly snipped]
> +.PHONY: scsope
[patch mostly snipped]

s/scs/csc/
