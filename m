Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263366AbRFREU4>; Mon, 18 Jun 2001 00:20:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263449AbRFREUq>; Mon, 18 Jun 2001 00:20:46 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:28687 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S263366AbRFREU3>;
	Mon, 18 Jun 2001 00:20:29 -0400
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15149.33136.248930.796754@cargo.ozlabs.ibm.com>
Date: Mon, 18 Jun 2001 14:20:00 +1000 (EST)
To: Ivan Vadovic <pivo@pobox.sk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: any good diff merging utility?
In-Reply-To: <20010618014547.B1063@ivan.doma>
In-Reply-To: <20010618014547.B1063@ivan.doma>
X-Mailer: VM 6.75 under Emacs 20.7.2
Reply-To: paulus@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ivan Vadovic writes:

> Well, are there any utilities to merge diffs? I couldn't find any on freshmeat.
> So what are you using to stack many patches onto the kernel tree? Just manualy
> modify the diff? I'll try to write something more automatic if nothing comes up.

Try dirdiff - ftp://ftp.samba.org/pub/paulus/dirdiff-1.2.tar.gz.  I
use it all the time for merging in changes between Linus' official
tree, my own development tree, and the PPC/Linux bitkeeper trees.

Dirdiff is a tcl/tk-based utility for graphically displaying the
difference between directory trees.  It can handle from 2 to 5 trees.
It displays a main window where it shows which files are different.
You can select a file and get it to show the diffs between that file
in any two of the directory trees.  This comes up in another window
in a format like a unified diff but with the background of the line
colored according to which file it comes from.  You can also copy
files between trees with a menu item - in fact you can select whole
groups of files to be copied.  And you can use it to generate patches
too. :)

Once you have the differences between two versions of a file
displayed, you can do a merge between the two versions.  Each line of
differences has a little check box beside it.  If you check the box it
means you want to make that change (right-click or shift-click selects
a whole group of boxes).  When you have checked all the boxes you want
you select an item from the merge menu to say which tree you want to
update.  The new version of the file comes up in an edit window and
you can check it, make any further changes you want, etc.  Then you
can either save the result or close the window (discarding the merge).

It's hard to explain in words everything about how it works and how
you use it.  It isn't really a utility to merge diffs but it is very
useful in tracking and merging changes between several large source
trees.  I find it particularly useful because I am usually interested
only in a subset of the files (i.e. particularly arch/ppc and
include/asm-ppc).  So when Linus releases a new pre-patch, I update my
"official Linus source" tree and do another dirdiff.  If there are
changes to files under fs/ for instance, I just select all of them and
copy them over to my tree without looking at the diffs.  If there are
changes in arch/i386 for instance, I look at the diff to see if I am
going to need to make a similar change in arch/ppc.

Regards,
Paul.
