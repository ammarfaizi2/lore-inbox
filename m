Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264956AbTLKOLK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Dec 2003 09:11:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264960AbTLKOLK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Dec 2003 09:11:10 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:4390 "EHLO
	MTVMIME02.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S264956AbTLKOLG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Dec 2003 09:11:06 -0500
Date: Thu, 11 Dec 2003 14:11:07 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Willy Tarreau <willy@w.ods.org>
cc: dual_bereta_r0x <dual_bereta_r0x@arenanetwork.com.br>,
       <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.23 + tmpfs: where's my mem?!
In-Reply-To: <20031211133124.GA18161@alpha.home.local>
Message-ID: <Pine.LNX.4.44.0312111351520.1386-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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

That's right, and would explain why du may show 32 even if ls -alR
shows nothing at all (what does ls -alR /tmp show?).

But the strange thing is that df's Used does not match du: they should
be identical, though arrived at from different directions.  I've not
seen that, and have no idea what's going on: it's as if a subtree of
/tmp has become detached (a non-empty directory removed).

What usage led up to this?  What does /proc/meminfo show?
How many records out does "dd if=/dev/zero of=/tmp/zero bs=1k"
manage before /tmp fills up (11620 would fit df's Available,
the remaining 16k being metadata).

Hugh

