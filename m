Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263516AbTETDJL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 23:09:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263528AbTETDJL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 23:09:11 -0400
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:62412 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id S263516AbTETDJJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 23:09:09 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: linux-kernel@vger.kernel.org
Date: Tue, 20 May 2003 13:22:06 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16073.40798.305573.92933@notabene.cse.unsw.edu.au>
Subject: ANNOUNCE: wiggle - a tools for applying patches with conflicts
X-Mailer: VM 7.15 under Emacs 21.3.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



I am pleased to announce the first public release of 'wiggle'.

Wiggle is a program for applying patches that 'patch' cannot
apply due to conflicting changes in the original.

Wiggle will always apply all changes in the patch to the original.
If it cannot find a way to cleanly apply a patch, it inserts it
in the original in a manner similar to 'merge', and report an
unresolvable conflict.  Such a conflict will look like:

<<<<<<<
Some text from
the original file
|||||||
Some text that the patch changes
=======
Some text that is the result of the patch
>>>>>>>

with the meaning that the "text that the patch
changes" was expected somewhere in the "text from the original 
file" and should be replaced with "the result of the patch".

wiggle analyses the file and the patch in terms of words rather than
whole lines and so is able to find matches that patch is
unable to find.  If a patch changes a word at the end of a line, and
a word at the start of that line has been modified since the patch
was made, then wiggle will have no trouble applying the patch.

wiggle has proved very useful for back-porting patches that were
generated for the development kernel, onto the stable kernel.
Sometimes it does exactly the right thing with the patch.  When it doesn't
it reports a conflict which is easy to resolve with an understanding of
what the code and the patch were trying to achieve.

Wiggle is available under the GPL and can be fetched from:

   http://www.cse.unsw.edu.au/~neilb/source/wiggle/

The name 'wiggle' was inspired by Andrew Morton's comment:

   The problem I find is that I often want to take
     (file1+patch) -> file2,
   when I don't have file1.  But merge tools want to take
     (file1|file2) -> file3.
   I haven't seen a graphical tool which helps you to wiggle a patch
   into a file.

which google can find for you:
 http://www.google.com/search?q=graphical+tool+which+helps+you+to+wiggle+a+patch

It isn't a graphical tool, but it is a good first step.

NOTES:

This release contains a 'tests' directory with a number of test cases
that have proved invaluable in developing the program and my
understanding of the subtleties of some of the issues involved.  If you
find a case where wiggle behaves sub-optimally (e.g. dumps core),
please consider sending me a test case to add to the tests directory.

This release also contains a script 'p' and accompanying 'p.help'.
This is a script that I use for patch management for my kernel patches
and it makes use of wiggle to allow me to apply patches that
'patch' cannot manage.  It is included both as an example of
how wiggle can be used, and as a tool that some might find useful.

One shortcoming I find with wiggle is that I would like to be able
to 'see' what it has done.  I would love it if someone were to write
a program that allowed the results of wiggle to be visualised.
The closest that I have come to imagining a workable UI is to
have two side-by-side windows, one of which shows the original patch,
and the other shows a "diff -u" of before and after wiggle has done it's
thing, and to have these windows automatically aligned so that when
a change is shown in one, the corresponding change appears in the other.
Maybe something like tkdiff, but that knows about patches and knows
about word-based diffs....

Wiggle is also able to perform a function similar to 'diff' and show the 
differences and similarities between two files.  It can show these differences
and similarities at a word-by-word level.  The output format is not machine
readable as the character sequences used to delimit inserted and deleted
words are not quoted in the output.  Hence this format will probably change
at some stage and should not be depended upon.

If you read the source, beware of comments: they were probably written 
while I was still trying to understand the issues myself, and so are 
probably wrong and out-of-date.  I would like to review all the code and
comments, but if I wait until I do that before releasing it, it'll never
get released!

NeilBrown
The University of New South Wales
