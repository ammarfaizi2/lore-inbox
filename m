Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261989AbUEJXpm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261989AbUEJXpm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 May 2004 19:45:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262050AbUEJXpO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 May 2004 19:45:14 -0400
Received: from x35.xmailserver.org ([69.30.125.51]:64916 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S262035AbUEJXmk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 May 2004 19:42:40 -0400
X-AuthUser: davidel@xmailserver.org
Date: Mon, 10 May 2004 16:42:39 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mdolabs.com
To: Valdis.Kletnieks@vt.edu
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC/PATCH] inotify -- a dnotify replacement 
In-Reply-To: <200405102310.i4ANA7Eh022394@turing-police.cc.vt.edu>
Message-ID: <Pine.LNX.4.58.0405101630180.1156@bigblue.dev.mdolabs.com>
References: <1084152941.22837.21.camel@vertex> <20040510021141.GA10760@taniwha.stupidest.org>
 <1084227460.28663.8.camel@vertex> <Pine.LNX.4.58.0405101521280.1156@bigblue.dev.mdolabs.com>
 <1084228900.28903.2.camel@vertex>            <Pine.LNX.4.58.0405101548230.1156@bigblue.dev.mdolabs.com>
 <200405102310.i4ANA7Eh022394@turing-police.cc.vt.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 May 2004 Valdis.Kletnieks@vt.edu wrote:

> On Mon, 10 May 2004 15:52:58 PDT, Davide Libenzi said:
> 
> > And it should not even be that much hard to do, since you can just 
> > backtrace the the point where the change happened to see if there are 
> > watchers on the parent directories.
> 
> Umm.. can you?  That sounds suspiciously like "given an inode, how
> do I find the pathname?".

It'd be from a file* not from an inode* (where you have a dentry and a 
vfsmount). So *one* path can be found.



> How do you handle the case of a file that's hard-linked into 2 different
> directories a "long way" apart in the heirarchy?  It's easy enough to
> backtrack and find *A* path - the problem is if the watcher was on
> some *other* directory:
> 
> mkdir -p /tmp/a/foo/bar/baz
> mkdir -p /tmp/b/que/er/ty
> touch /tmp/a/foo/bar/baz/flag
> ln /tmp/a/foo/bar/baz/flag /tmp/b/qu/er/ty/flag
> 
> If you modify 'flag' again, how do you ensure that you find a watcher on
> /tmp/a/foo or /tmp/b/qu, given that either or both might be there?

Yep, links are a problem to be implemented right. OTOH I don't think that 
an rmap-fs can be asked only to solve such problem ;)



- Davide

