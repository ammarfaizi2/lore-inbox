Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263250AbRFRAxQ>; Sun, 17 Jun 2001 20:53:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263246AbRFRAxG>; Sun, 17 Jun 2001 20:53:06 -0400
Received: from [204.94.214.10] ([204.94.214.10]:63009 "EHLO
	deliverator.sgi.com") by vger.kernel.org with ESMTP
	id <S263250AbRFRAwq>; Sun, 17 Jun 2001 20:52:46 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Ivan Vadovic <pivo@pobox.sk>
cc: linux-kernel@vger.kernel.org
Subject: Re: any good diff merging utility? 
In-Reply-To: Your message of "Mon, 18 Jun 2001 01:45:47 +0200."
             <20010618014547.B1063@ivan.doma> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 18 Jun 2001 10:51:58 +1000
Message-ID: <4319.992825518@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Jun 2001 01:45:47 +0200, 
Ivan Vadovic <pivo@pobox.sk> wrote:
>Well, are there any utilities to merge diffs? I couldn't find any on freshmeat.
>So what are you using to stack many patches onto the kernel tree? Just manualy
>modify the diff? I'll try to write something more automatic if nothing comes up.

Use any source repository tool that understands both change sets and
multiple branches.  Change sets treat all related patches as one
change, unlike CVS which treats each change to a file separately.  A
repository that recognises multiple branches and has decent support for
merging between branches makes life so much easier.  There are several
candidates, pick one that you feel comfortable with.

I use PRCS (http://www.xcf.berkeley.edu/~jmacd/prcs.html) to control my
local kernel source changes.  My linux-2.4 repository is 200Mb, that
contains all of Linus's patch sets (including -pre patches), all of
Alan Cox's patch sets, all my work on kdb (both i386 and ia64), XFS
changes, my 2.5 Makefile rewrite plus various other patches I have
worked on, both i386 and ia64, for a total of 307 patch sets over 5
major branches and lots of minor branches.  Not bad when a single 2.4
source tree is 125Mb.

PRCS merge between two branches identifies unchanged files, files
changed in branch 1 but not branch 2, files changed in branch 2 but not
branch 1, deleted files in either branch and files changed in both
branches.  Normally only the last category is a problem, with two sets
of patches to the same file.  PRCS uses diff3 to work out if the
patches overlap or not, if they do not overlap then there is usually no
problem, if they do overlap then PRCS creates a merged file with both
sets of patches and wraps conflict markers around them.  It is then up
to you to manually correct the conflict.

Using PRCS, I can upgrade to a new Linus or AC patch, merge the
previous kdb patch for that major branch and check if I need to issue a
new kdb patch.  All within 15 minutes.

There is also http://cvs.bofh.asn.au/mergetrees/ which does not use a
repository.

