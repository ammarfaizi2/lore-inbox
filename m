Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262112AbUCVQxy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Mar 2004 11:53:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262113AbUCVQxy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Mar 2004 11:53:54 -0500
Received: from gamemakers.de ([217.160.141.117]:50133 "EHLO www.gamemakers.de")
	by vger.kernel.org with ESMTP id S262112AbUCVQxv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Mar 2004 11:53:51 -0500
Message-ID: <405F1A83.5030807@gamemakers.de>
Date: Mon, 22 Mar 2004 17:55:31 +0100
From: =?ISO-8859-1?Q?R=FCdiger_Klaehn?= <rudi@gamemakers.de>
Reply-To: rudi@lambda-computing.de
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Mike Waychison <Michael.Waychison@Sun.COM>
Cc: linux-kernel@vger.kernel.org
Subject: Re: File change notification (enhanced dnotify)
References: <200403221500.i2MF0EI7003024@eeyore.valparaiso.cl> <200403221500.i2MF0EI7003024@eeyore.valparaiso.cl> <405F0DFD.2070801@gamemakers.de> <405F174A.3090706@sun.com>
In-Reply-To: <405F174A.3090706@sun.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Waychison wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Rüdiger Klaehn wrote:
> 
> |
> | My original approach assumed that inode numbers were unique, and it
> | would have worked with hard links. But I think it is much more important
> | to have a mechanism that works for all file systems than to solve the
> | problem of hard links.
> |
> 
> Inode numbers are guaranteed to be unique on a given filesystem other
> than for hard links..  Where is this assumption broken otherwise?
> 
To quote jan harkes, who repiled to my original proposal:

"Inode number are not necessarily unique per filesystem. Any filesystem
that uses iget4 can have several objects that have the same inode
number. For instance, Coda uses 128-bit file-identifiers and the i_ino
number is a simple hash that is 'typically' unique. There are also
filesystems that invent inode numbers whenever inodes are brought into
the cache, but which have no persistency when the inode_cache is pruned.
So the next time you see the same object, it could have a different
(unique) inode number."

But I think the current approach is much better anyway since it does 
work for a single directory and its subdirectories instead of globally 
like my initial attempt. If you want to catch hard link issues you will 
have to watch the root of the file system, but that is still not that 
expensive. And on "sane" file systems that use unique inode numbers in 
userspace to solve the hard link problem.

best regards,

Rüdiger
