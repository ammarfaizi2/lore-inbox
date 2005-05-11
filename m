Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261995AbVEKRHo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261995AbVEKRHo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 May 2005 13:07:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262001AbVEKRHn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 May 2005 13:07:43 -0400
Received: from mail.shareable.org ([81.29.64.88]:20944 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S261995AbVEKRHg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 May 2005 13:07:36 -0400
Date: Wed, 11 May 2005 18:07:00 +0100
From: Jamie Lokier <jamie@shareable.org>
To: "Bodo Eggert <harvested.in.lkml@posting.7eggert.dyndns.org>" 
	<7eggert@gmx.de>
Cc: Miklos Szeredi <miklos@szeredi.hu>, ericvh@gmail.com,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       smfrench@austin.rr.com, hch@infradead.org
Subject: Re: [RCF] [PATCH] unprivileged mount/umount
Message-ID: <20050511170700.GC2141@mail.shareable.org>
References: <406SQ-5P9-5@gated-at.bofh.it> <40rNB-6p8-3@gated-at.bofh.it> <40t37-7ol-5@gated-at.bofh.it> <42VeB-8hG-3@gated-at.bofh.it> <42WNo-1eJ-17@gated-at.bofh.it> <E1DVuHG-0006YJ-Q7@be1.7eggert.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1DVuHG-0006YJ-Q7@be1.7eggert.dyndns.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bodo Eggert <harvested.in.lkml@posting.7eggert.dyndns.org> wrote:
> > How about a new clone option "CLONE_NOSUID"?
> 
> IMO, the clone call ist the wrong place to create namespaces. It should be
> deprecated by a mkdir/chdir-like interface.

And the mkdir/chdir interface already exists, see "cd /proc/NNN/root".

There are some small quirks to fix, should we decide that's the way to
go.  But it's basically there.

File descriptors keep track of the namespace (actually vfsmnt) where
they were opened.  Today, if you pass a directory file descriptor from
one process to another, you're granting access to see the other's
namespace.

That's why /proc/NNN/root works (with small fixes) in much the way
you'd expect.

-- Jamie
