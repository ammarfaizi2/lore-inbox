Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278805AbRKAMVm>; Thu, 1 Nov 2001 07:21:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278867AbRKAMVc>; Thu, 1 Nov 2001 07:21:32 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:41489 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S278358AbRKAMVT>;
	Thu, 1 Nov 2001 07:21:19 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: David Howells <dhowells@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kbuild-2.5 
In-Reply-To: Your message of "Thu, 01 Nov 2001 11:19:02 -0000."
             <22644.1004613542@warthog.cambridge.redhat.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 01 Nov 2001 23:21:07 +1100
Message-ID: <30762.1004617267@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 01 Nov 2001 11:19:02 +0000, 
David Howells <dhowells@redhat.com> wrote:
>Okay... for users of emacs, here's an elisp function that looks to see if it's
>in a subdirectory of a kernel tree (and if so whether it's kbuild or
>traditional), and if so invents an appropriate command line for compiling just
>in that subdir:-) Otherwise it just falls back to the usual compile function.
>(defun kernel-compile ()
>....
>	  (if (and
>	       (file-readable-p (concat curdir "/COPYING"))

Won't work with separate source and object trees in kbuild 2.5.

  export KBUILD_SRCTREE_000=/build/kaos/2.4.13-kbuild-2.5
  export KBUILD_OBJTREE=/build/kaos/object-2.4.13
  cd /anywhere/you/like
  make -f $KBUILD_SRCTREE_000/Makefile-2.5

If you define the kbuild tree variables then you can be in any
directory when you issue the make command.  If you are using shadow
trees then you can be in a sparse source tree which only contains of
the files.

>	      ;; determine whether using kbuild or not
>	      (if (file-readable-p (concat curdir "/scripts/shadow.pl"))

grep CONFIG_KBUILD_2_5 .config is better, you can still build using
kbuild 2.4 even after applying the 2.5 patch.  The presence of a kbuild
2.5 file is not definitive.  Of course the .config is in $KBUILD_OBJTREE
which might not be the current directory.

