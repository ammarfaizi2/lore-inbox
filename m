Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261468AbUKVPAF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261468AbUKVPAF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 10:00:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261463AbUKVO7J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 09:59:09 -0500
Received: from hermine.aitel.hist.no ([158.38.50.15]:22020 "HELO
	hermine.aitel.hist.no") by vger.kernel.org with SMTP
	id S261451AbUKVO5o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 09:57:44 -0500
Message-ID: <41A1FFFC.70507@hist.no>
Date: Mon, 22 Nov 2004 16:04:28 +0100
From: Helge Hafting <helge.hafting@hist.no>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041116)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Amit Gud <amitgud1@gmail.com>
CC: linux-kernel@vger.kernel.org, reiserfs-list@namesys.com
Subject: Re: file as a directory
References: <2c59f00304112205546349e88e@mail.gmail.com>
In-Reply-To: <2c59f00304112205546349e88e@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Amit Gud wrote:

>Hi people,
>
> A straight forward question. Wouldn't adding a "file as a directory"
>mechanism more logical in VFS itself, rather than having each fs (like
>reiser4) to implement it seperately? My vision is to give archive-file
>  
>
Such support may happen for a few fs'es - people who
want this will then use those fses.  Those who don't
like the ideas will use others.

>(.tar, .tar.gz, ...) support in the VFS itself, and of course
>transparent to any fs and any user-land application. There are many
>archive FSs around, but how feasible would it be to implement the
>archive file support in the VFS at dentry-level? I'd be happy to share
>my proposal.
>
>  
>
You won't get .tar or .tar.gz support in the VFS, for a few simple reasons:
1. .tar and .tar.gz are complicated formats, and are therefore better
   left to userland.  You can get some of the same effect by using a shared
   library that redefines fopen() and fread() though.  It'll work fine for
   the vast majority of apps that happens to use the C library.

   It is hard to make a guaranteed bug-free decompressor that
   is efficient and works with a finite amount of memory.  The kernel
   needs all that - userland doesn't.

2. Both .tar and .gz  file formats may improve with time.  Getting a new
    version of tar og gunzip is easy enough - getting another compression
    algorithm into the kernel won't be that easy.

3. Writing into a tar.gz file is surprisingly difficult from the kernel 
side.
    Userland may create a new temp file when you add to a .tar.gz.
    Userland may assume that other processes aren't reading or writing
    the .tar.gz as it isupdated.  The kernel have no such luxuries.

I recommend looking at archived threads about file as directory,
you'll find many more arguments.  Currently there is one kind
of support for archive files - loop mounts over files containing
filesystem images.  These are not compressed though.

Helge Hafting
