Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129460AbRC2Xtf>; Thu, 29 Mar 2001 18:49:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129466AbRC2XtZ>; Thu, 29 Mar 2001 18:49:25 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:58636 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129460AbRC2XtQ>; Thu, 29 Mar 2001 18:49:16 -0500
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: Memory leak in the ramfs file system
Date: 29 Mar 2001 15:48:30 -0800
Organization: Transmeta Corporation
Message-ID: <9a0hke$p9m$1@penguin.transmeta.com>
In-Reply-To: <200103292206.f2TM6sJ10808@zero.monsters.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <200103292206.f2TM6sJ10808@zero.monsters.org>,
Stephen L Johnson  <sjohnson@monsters.org> wrote:
>
>A group of us from the handhelds.org site think that we have found a memory 
>leak in the ramfs file system. After a long period of create and deleting 
>small files in a mounted ramfs partition we have substantially less freemem.  
>The problem has been confirmed on 2.4.2 on an i386 and StormARM ports.

What does /proc/slabinfo say? The most likely leak is a dentry leak or
an inode leak, and both of those should be fairly easy to see in the
slab info (dentry_cache and inode_cache respectively).

Obviously, it could be a data page leak too, but such a leak should be
easy to see by creating a few big files and deleting them..

		Linus
