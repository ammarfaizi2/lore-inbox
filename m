Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312320AbSCYGza>; Mon, 25 Mar 2002 01:55:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312322AbSCYGzU>; Mon, 25 Mar 2002 01:55:20 -0500
Received: from samba.sourceforge.net ([198.186.203.85]:37636 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S312320AbSCYGzM>;
	Mon, 25 Mar 2002 01:55:12 -0500
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15518.51551.332695.125664@argo.ozlabs.ibm.com>
Date: Mon, 25 Mar 2002 17:53:19 +1100 (EST)
To: linux-kernel@vger.kernel.org
Subject: Re: xxdiff as a visual diff tool (shameless plug)
In-Reply-To: <20020321061423.HIXG2746.tomts17-srv.bellnexxia.net@there>
X-Mailer: VM 6.75 under Emacs 20.7.2
Reply-To: paulus@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Blais writes:

> I was wondering if you've tried my tool xxdiff (shameless
> plug), it has the following features:

While we're in shameless plug mode, anyone who is working with two or
more kernel trees should have a look at dirdiff.  The great thing
about dirdiff is that it compares from 2 to 5 directory trees and
shows you which files differ between the trees in a concise manner.
You can then select one of the files and display the differences for
that file between any two of the versions.  You can also select
multiple files and then copy them from one tree to another.

I use this when Linus or Marcelo puts out a new patch.  Using dirdiff
I can get a quick view of which files have been changed, added or
deleted.  I can then quickly copy over anything where I don't need to
look too closely (e.g. stuff under fs or arch/ia64, for instance) and
have a close look at what changes have been made in other areas
(e.g. under arch/ppc, arch/i386 or mm).

In fact, I find a 3-way dirdiff useful in that situation - comparing
the previous Linus/Marcelo tree, the current Linus/Marcelo tree and my
tree.  Different states of the file (such as modified in my tree and
unchanged in the Linus/Marcelo trees, unmodified in my tree and
modified in the latest Linus/Marcelo release, modified in both, etc.)
show up as different color patterns which are easily recognized.

Dirdiff displays an array of colored squares with one column per
directory tree and one line per file.  For a given file, versions that
are the same get the same color.  Each group of identical files gets
given a color ranging from green (newest) to red (oldest) based on the
most recent modification time of the files in the group.  (In fact the
only reason why dirdiff is limited to 5 trees is that I thought that
any more than 5 colors in the green - red spectrum would not be
sufficiently visually distinct.)

Dirdiff also has features to make it easy to use in conjunction with
Bitkeeper or CVS, for example you can get it to ignore differences in
BK or CVS tags when deciding whether two files go in the same group.

The differences get displayed in a separate window as a diff -u but
with different colored backgrounds instead of - or + at the beginning
of the line.  You can then do a merge; each line of difference has a
little checkbox, and if you check the checkbox, that line will be
changed in the merged file.  The merged file is brought up in a window
which allows basic editing (insert, delete, cut/copy/paste, find)
before you either save the merged file or discard the merge.

Dirdiff is available from ftp://samba.org/pub/paulus/dirdiff-1.5.tar.gz
and it's also a debian package (although I hear the debian version is
a little out of date).

Paul.
