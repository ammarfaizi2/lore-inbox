Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261704AbUEKHur@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261704AbUEKHur (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 03:50:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261867AbUEKHuq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 03:50:46 -0400
Received: from fw.osdl.org ([65.172.181.6]:12490 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261704AbUEKHuX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 03:50:23 -0400
Date: Tue, 11 May 2004 00:49:56 -0700
From: Andrew Morton <akpm@osdl.org>
To: John McGowan <jmcgowan@inch.com>
Cc: linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net
Subject: Re: Kernel 2.6.6: Removing the last large file does not reset
 filesystem properties
Message-Id: <20040511004956.70f7e17d.akpm@osdl.org>
In-Reply-To: <20040511002008.GA2672@localhost.localdomain>
References: <20040511002008.GA2672@localhost.localdomain>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John McGowan <jmcgowan@inch.com> wrote:
>
>  1: For the first week, at least, after installing a new kernel, I set the
>      system to force fsck on boot (Fedora Core1, rc.local script to "touch"
>      "/forcefsck").
> 
>   2: Home system, single user. Turn off at night. Turn off when I go to eat
>      lunch. Etc. (reboot at least once each day - silly, but it is a single
>      user system and I don't want to waste electricity and it gives better
>      protection against storms and line spikes).
>      
>   3: Was using Gimp 2.0 and used a tool. Got a 6 Gig swap file in /tmp/gimp2
>      (there must be a problem with that tool). Closed gimp, got rid of the
>      swap file. Upon the next boot I got:
>        FAILED!!
>        Dropping to root command line for system maintenance
>      (such fun ... entering the root password got more error messages about
>      missing programmes such as "id" and "test" - well, I have "/usr" on
>      another partition and it was not mounted).

I think this is really an e2fsck/initscript problem.

fsck saw that there were no large files on the fs, then fixed up the
superblock to say that then returned an exit code which says "I modified
the fs".

The initscripts see that exit code and have a heart attack.

What should happen is that fsck returns an exit code which says "I modified
the fs, but everythig is OK".  And the initscripts should say "oh, cool"
and keep booting.

I don't know whether the problem lies with fsck or initscripts.

