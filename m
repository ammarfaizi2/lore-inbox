Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268166AbUIKPNl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268166AbUIKPNl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Sep 2004 11:13:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268167AbUIKPNl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Sep 2004 11:13:41 -0400
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34]:22676 "HELO
	smtp003.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S268166AbUIKPNi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Sep 2004 11:13:38 -0400
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
To: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] uml-patch-2.6.7-2
Date: Sat, 11 Sep 2004 16:41:15 +0200
User-Agent: KMail/1.6.1
Cc: user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <200408190301.i7J30xek004150@ccure.user-mode-linux.org> <200408251746.53523.blaisorblade_spam@yahoo.it> <200409090035.i890ZYBP016288@ccure.user-mode-linux.org>
In-Reply-To: <200409090035.i890ZYBP016288@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200409111641.15496.blaisorblade_spam@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 09 September 2004 02:35, Jeff Dike wrote:
> blaisorblade_spam@yahoo.it said:
> > * First, please do a "make clean" before releasing the patch. There
> > are some  binaries included in it! And also semaphore.c, which is a
> > symlink normally.
>
> I do.  It's just that make clean didn't catch everything.
Btw, inside patch-scripts they provide a script which rather than diffing two 
trees, calls "combinediff" (from patchutils) to merge the patches statically, 
without need of the patched files. I've been very confortable with it - 
doesn't quilt have something such?

About patchutils (quoting from Andrew Morton):

  See http://cyberelk.net/tim/patchutils/ (Don't download the
  "experimental" patchutils - it seems to only have half of the
  commands in it.  Go for "stable")

> > * About filehandle_switch: you deleted a line (probably by mistake).
> > Reread  more carefully the separate patches you get with quilt: when
> > you see the  other attached patch (uml-restore-lost-code.patch),
> > you'll agree with me.

> Yuck, I have no idea how that happened.
Btw, I'm assuming that you didn't want to drop the HPPFS compile line in 
"externfs" (since that's not documented), right?

--- um.orig/fs/Makefile 2004-08-06 15:17:22.000000000 -0400
+++ um/fs/Makefile      2004-08-06 15:17:25.000000000 -0400
@@ -91,5 +91,4 @@
 obj-$(CONFIG_XFS_FS)           += xfs/
 obj-$(CONFIG_AFS_FS)           += afs/
 obj-$(CONFIG_BEFS_FS)          += befs/
-obj-$(CONFIG_HOSTFS)           += hostfs/
-obj-$(CONFIG_HPPFS)            += hppfs/   # <---- WHY?
+obj-$(CONFIG_EXTERNFS)         += hostfs/

> > However, IMHO, since you cannot close and reopen a pipe, it's
> > braindead that  the switch_pipe[] array is an array of filehandles.

> Yeah, this is fixed in my 2.6 tree now.
Yes, I saw it, a lot after writing the message (I sent it a lot after writing 
it).

However, another thing: I think that the handling of EMFILE/ENFILE (too many 
fd's for the app or for the system) should be moved inside the os_ layer. Or 
will you create yet a filehandle wrapper for functions like 
os_connect_socket() (which calls socket(), which requests an fd)? Do you 
agree or have any arguments to support the current design?

-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729
