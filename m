Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964992AbWEOT6E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964992AbWEOT6E (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 15:58:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965181AbWEOT6E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 15:58:04 -0400
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:41135
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S964992AbWEOT6B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 15:58:01 -0400
From: Rob Landley <rob@landley.net>
To: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: Which process context does /sbin/hotplug run in?
Date: Mon, 15 May 2006 15:59:09 -0400
User-Agent: KMail/1.8.3
Cc: linux-kernel@vger.kernel.org
References: <200605121421.00044.rob@landley.net> <200605142008.39420.rob@landley.net> <6BCF90AC-FF8B-48BC-8659-DBE0DD00E270@mac.com>
In-Reply-To: <6BCF90AC-FF8B-48BC-8659-DBE0DD00E270@mac.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605151559.09504.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 15 May 2006 12:17 am, Kyle Moffett wrote:
> > I can CD into them endlessly, and both "ls -lR" and "find ." report
> > cycles in the tree, which surprised me that they had a specific
> > error message for that, actually.  Good enough for me. :)
>
> Odd, I'm unable to replicate that behavior here.  If I run "ls /var/
> sub2/sub2" I don't get any entries.  Find and ls -lR have error
> messages of that because it can occasionally be triggered with
> symlinks and such.

Perhaps I copied it down wrong.  I did this in a 2.6.16 UML instance...

sh-3.00# mount -t tmpfs /tmp /tmp
sh-3.00# cd /tmp
sh-3.00# mkdir woot
sh-3.00# mount --bind woot /var
sh-3.00# cd /var
sh-3.00# mkdir sub
sh-3.00# mount --move /tmp sub
sh-3.00# ls -lR
.:
total 0
drwxrwxrwt  3 root root 60 May 15 15:57 sub

./sub:
total 0
drwxr-xr-x  3 root root 60 May 15 15:57 woot
ls: not listing already-listed directory: ./sub/woot
sh-3.00# find .
.
./sub
find: Filesystem loop detected; `./sub/woot' has the same device number and 
inode as a directory which is 2 levels higher in the filesystem hierarchy.
./sub/woot
sh-3.00#

Works for me. :)

> --
> Simple things should be simple and complex things should be possible
>    -- Alan Kay

And crazy things fun. :)

Rob
-- 
Never bet against the cheap plastic solution.
