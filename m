Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264683AbUEKNBI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264683AbUEKNBI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 09:01:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264724AbUEKNBI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 09:01:08 -0400
Received: from shellutil.inch.com ([216.223.208.53]:49668 "EHLO util.inch.com")
	by vger.kernel.org with ESMTP id S264683AbUEKNA4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 09:00:56 -0400
Date: Tue, 11 May 2004 09:00:33 -0400 (EDT)
From: John McGowan <jmcgowan@inch.com>
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net
Subject: Re: Kernel 2.6.6: Removing the last large file does not reset
 filesystem properties
In-Reply-To: <20040511004956.70f7e17d.akpm@osdl.org>
Message-ID: <20040511084510.J33555@shell.inch.com>
References: <20040511002008.GA2672@localhost.localdomain>
 <20040511004956.70f7e17d.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 May 2004, Andrew Morton wrote:

> John McGowan <jmcgowan@inch.com> wrote:
>
> I think this is really an e2fsck/initscript problem.
>
> fsck saw that there were no large files on the fs, then fixed up the
> superblock to say that then returned an exit code which says "I modified
> the fs".
>
> The initscripts see that exit code and have a heart attack.

Yes. But why did it have to modify the file system/superblock/properties?
Should the file system have had to be modified (relying upon
fsck to fix the "largefile" property when next it is run)?

> What should happen is that fsck returns an exit code which says "I modified
> the fs, but everythig is OK".  And the initscripts should say "oh, cool"
> and keep booting.

Actually, they do, if it isn't the root partition (if I create/delay the
large file from another partition it gives a message and continues - but
for the root partition, the initscript, with an exit code greater than 1
drops one to a root prompt for "maintenance" - and with my /usr on a
different partition and seeing a bunch of "id not found"
"test not found" messages ... for a few minutes I was a bit flustered.
It is easy enough to modify the init script to do a reboot on exit
code 2).

(Fedora Core1 initscript on mounting the root partition:

  # A return of 2 or higher means there were serious problems.
  echo $"*** An error occurred during the file system check."
  echo $"*** Dropping you to a shell; the system will reboot"
  echo $"*** when you leave the shell."
  str=$"(Repair filesystem)"
  PS1="$str \# # "; export PS1
  sulogin

(the sulogin login message is:
  "Give root password for maintenance")

> I don't know whether the problem lies with fsck or initscripts.

fsck does fix it. Or should the removal of the last large file have
resulted in the change without the mismatch between the "largefile"
property being set with no large files?

It's a small annoyance (no damage to the file system itself), no more.

I know what's happening and how to patch the initscript to get an
automatic reboot on exit code 2. Is that the proper way to handle it?

Regards from:

    John McGowan  |  jmcgowan@inch.com                [Internet Channel]
                  |  jmcgowan@coin.org                [COIN]
    --------------+-----------------------------------------------------
