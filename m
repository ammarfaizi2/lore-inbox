Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262448AbTCIHD3>; Sun, 9 Mar 2003 02:03:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262450AbTCIHD3>; Sun, 9 Mar 2003 02:03:29 -0500
Received: from adsl-206-170-148-147.dsl.snfc21.pacbell.net ([206.170.148.147]:26888
	"EHLO gw.goop.org") by vger.kernel.org with ESMTP
	id <S262448AbTCIHD2>; Sun, 9 Mar 2003 02:03:28 -0500
Subject: Still getting some NFS htree strangeness
From: Jeremy Fitzhardinge <jeremy@goop.org>
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>,
       Ext2 devel <ext2-devel@lists.sourceforge.net>
In-Reply-To: <E18re9F-00086y-00@think.thunk.org>
References: <E18re9F-00086y-00@think.thunk.org>
Content-Type: text/plain
Organization: 
Message-Id: <1047194045.8991.71.camel@ixodes.goop.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 08 Mar 2003 23:14:05 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-03-08 at 05:13, Theodore Ts'o wrote:
> I've backported all of the bugfixes to the 2.5 dxdir/htree patches to
> 2.4, and have created a new set of patches for Linux 2.4.21rc5.  At this
> point it *looks* like we've fixed all of the htree bugs that people have
> reported, including the brelse bug, the memory leak bugs, and the NFS
> compatibility problems.

I'm still getting odd results from programs doing readdir over NFS.  I
haven't really nailed down what's happening yet, but I'm getting readdir
failing with EOVERFLOW.  Strace doesn't show any syscalls failing, and
an inspection of the glibc source of readdir() shows that it can return
EOVERFLOW, but I don't really understand the code yet.  It may be that
it assumes that the getdents "offset" is really a file offset rather
than a random number.  

I'm inclined to suspect that it is a glibc bug, but I'm not willing to
say so until I've worked out what's really going on.  Also, even if it
were, it would be worth working around if possible (otherwise htree+nfs
is still effectively useless).

I'll see if I can get something more concrete showing what's going on.

	J

