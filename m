Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315806AbSGUN5E>; Sun, 21 Jul 2002 09:57:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315870AbSGUN5E>; Sun, 21 Jul 2002 09:57:04 -0400
Received: from e.kth.se ([130.237.48.5]:34311 "EHLO elixir.e.kth.se")
	by vger.kernel.org with ESMTP id <S315806AbSGUN5D>;
	Sun, 21 Jul 2002 09:57:03 -0400
To: linux-kernel@vger.kernel.org
Subject: memory leak?
From: mru@users.sourceforge.net (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Date: 21 Jul 2002 16:00:09 +0200
Message-ID: <yw1xn0sluqom.fsf@gladiusit.e.kth.se>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Channel Islands)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I noticed that doing lots or file accesses causes the used memory to
increase, *after* subtracting buffers/cache. Here is an example:

$ free
             total       used       free     shared    buffers     cached
Mem:        773776      30024     743752          0       1992      10424
-/+ buffers/cache:      17608     756168
Swap:        81904          0      81904
$ du > /dev/null
$ free
             total       used       free     shared    buffers     cached
Mem:        773776      78008     695768          0      26328      10472
-/+ buffers/cache:      41208     732568
Swap:        81904          0      81904

Here 24 MB of memory have been used up. Repeating the du seems to have
little effect. This directory has ~3200 subdirs and 13400 files.

After a few hours use about 200 MB are used, apperently for
nothing. Killing all processed and unmounting file systems doesn't
help.

Is this a memory leak? I get the same results with ext2, ext3,
reiserfs and nfs.

-- 
Måns Rullgård
mru@users.sf.net
