Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265116AbTLKPcC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Dec 2003 10:32:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265125AbTLKPcC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Dec 2003 10:32:02 -0500
Received: from 101.24.177.216.inaddr.g4.Net ([216.177.24.101]:32698 "EHLO
	sparrow.stearns.org") by vger.kernel.org with ESMTP id S265116AbTLKPby
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Dec 2003 10:31:54 -0500
Date: Thu, 11 Dec 2003 10:31:43 -0500 (EST)
From: William Stearns <wstearns@pobox.com>
X-X-Sender: wstearns@sparrow
Reply-To: William Stearns <wstearns@pobox.com>
To: Willy Tarreau <willy@w.ods.org>
cc: dual_bereta_r0x <dual_bereta_r0x@arenanetwork.com.br>,
       ML-linux-kernel <linux-kernel@vger.kernel.org>,
       William Stearns <wstearns@pobox.com>
Subject: Re: 2.4.23 + tmpfs: where's my mem?!
In-Reply-To: <20031211133124.GA18161@alpha.home.local>
Message-ID: <Pine.LNX.4.44.0312111027300.23867-100000@sparrow>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Good morning, Alexandre,

On Thu, 11 Dec 2003, Willy Tarreau wrote:

> On Thu, Dec 11, 2003 at 10:54:28AM -0200, dual_bereta_r0x wrote:
> > root@hquest:/tmp# cat /etc/slackware-version
> > Slackware 9.1.0
> > root@hquest:/tmp# uname -a
> > Linux hquest 2.4.23 #6 Sat Nov 29 22:47:03 PST 2003 i686 unknown unknown 
> > GNU/Linux
> > root@hquest:/tmp# df /tmp
> > Filesystem           1K-blocks      Used Available Use% Mounted on
> > tmpfs                   124024    112388     11636  91% /tmp
> > root@hquest:/tmp# du -s .
> > 32      .
> > root@hquest:/tmp# _
> 
> maybe you have a process which creates a temporary file in /tmp, and deletes
> the entry while keeping the fd open. vmware 1.2 did that, and probably more
> recent ones still do. It's a very clever way to automatically remove temp
> files when the process terminates.

	Agreed - very likely.  User-Mode Linux does the same for its UML 
memory images.
	To see what process is doing this, try looking at:

ls -Al /proc/[0-9]*/fd/* | grep ' /tmp/'

	Which will show you all open files in /tmp, deleted or not.

lr-x------    1 wstearns wstearns       64 Dec 11 10:23 /proc/10370/fd/6 -> /tmp/sfs8eEBBc (deleted)

	The pid following /proc/ (10370 in this case) is the process 
holding this file open.
	Cheers,
	- Bill

---------------------------------------------------------------------------
	"Any sufficiently advanced technology is indistinguishable from
magic." 
	-- Arthur C. Clark (?)
--------------------------------------------------------------------------
William Stearns (wstearns@pobox.com).  Mason, Buildkernel, freedups, p0f,
rsync-backup, ssh-keyinstall, dns-check, more at:   http://www.stearns.org
Linux articles at:                         http://www.opensourcedigest.com
--------------------------------------------------------------------------

