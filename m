Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264359AbTLKGTE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Dec 2003 01:19:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264360AbTLKGTE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Dec 2003 01:19:04 -0500
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:57064
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S264359AbTLKGTB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Dec 2003 01:19:01 -0500
From: Rob Landley <rob@landley.net>
Reply-To: rob@landley.net
To: <hzhong@cisco.com>, <linux-kernel@vger.kernel.org>
Subject: Re: Is there a "make hole" (truncate in middle) syscall?
Date: Thu, 11 Dec 2003 00:19:28 -0600
User-Agent: KMail/1.5
References: <011e01c3bfa5$8fb5a0e0$d43147ab@amer.cisco.com>
In-Reply-To: <011e01c3bfa5$8fb5a0e0$d43147ab@amer.cisco.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312110019.29080.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 10 December 2003 23:13, Hua Zhong wrote:
> Sorry for digging out this old discussion.
>
> This would be a tremendous enhancement to Linux filesystems, and one of
> my current projects actually needs this capability badly.
>
> The project is a lightweight user-space library which implements a
> file-based database. Each database has several files. The files are all
> block-based, and each block is always a multiple of 512 byte (and we
> could make it a multiple of 4K, in case this feature existed).
>
> Blocks are organized as a B+ tree, so we have a root block, which points
> to its child blocks, and in turn they point to the next level. There is
> a free block list too.
>
> The problem is with a lot of add/delete, there are a lot of free blocks
> inside the file. So essentially we'd have to manually shrink these files
> when it grows too big and eats up too much space. If we could just "dig
> a hole", it would be trivial to return those blocks to the filesystem
> without doing an expensive defragmentation.

It could be worse.  Java didn't have a "truncate file" command at all until I 
yelled at Sun about it.  (It was too late to get it into 1.1, but they added 
it to 1.2.  Of course, that was back when I cared about Java... :)

Al Viro mentioned that making hole creation play nice with mmap would be evil.  
I suspect that having the "punch hole" call simply fail if any part of the 
range you're trying to zap is currently mmaped is probably good enough for a 
first pass.  (Maybe some fallback code could write zeroes into the range so 
the behavior was sort of similar in the failure case...)  But I haven't 
looked at the code enough to even know what the issues are, and I certainly 
won't have time this week...

Rob
