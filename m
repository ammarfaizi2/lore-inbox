Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131361AbRCWVpg>; Fri, 23 Mar 2001 16:45:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131461AbRCWVpQ>; Fri, 23 Mar 2001 16:45:16 -0500
Received: from medusa.sparta.lu.se ([194.47.250.193]:47210 "EHLO
	medusa.sparta.lu.se") by vger.kernel.org with ESMTP
	id <S131361AbRCWVpO>; Fri, 23 Mar 2001 16:45:14 -0500
Date: Fri, 23 Mar 2001 21:25:59 +0100 (MET)
From: Bjorn Wesen <bjorn@sparta.lu.se>
To: David Woodhouse <dwmw2@infradead.org>
cc: Amit D Chaudhary <amit@muppetlabs.com>, linux-kernel@vger.kernel.org
Subject: Re: CRAMFS 
In-Reply-To: <Pine.LNX.4.30.0103231853280.2898-100000@imladris.demon.co.uk>
Message-ID: <Pine.LNX.3.96.1010323194500.14171C-100000@medusa.sparta.lu.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Mar 2001, David Woodhouse wrote:
> > 1. RAMFS is just more stable in terms of less complexity, less bugs reported 
> > over the time, etc.
> > 2. RAMFS is a fairly robust filesystem and all features required as far as I can 
> > tell.

Ok, ramfs is really simple, but heck, cramfs is not much more complex :)
It's as simple a flash-filesystem as you can get.

I don't know why the comparision is made though, they are used for two
completely different things... ramfs is for temporary file storage, cramfs
is for immutable files stored on flash. Each by itself is quite optimal
for what it's designed for, isn't it ?

> I'm not aware of any bugs being found in cramfs recently - unless you 
> wanted to use it on Alpha (or anything else where PAGE_SIZE != the 
> hard-coded 4096 in mkcramfs.c).

I committed a patch that disappeared that added the choice of page size
(trivial yes :), we have PAGE_SIZE == 8192 on our systems. Works fine.

> I wouldn't avoid it for those reasons - although if you're _really_ short 
> of flash space, the same argument applies as for JFFS2 - a single 
> compression stream (tar.gz) will be smaller than compressing individual 
> pages like JFFS2 and cramfs do.

Here are some results from a quite mixed filesystem:

[bjornw@godzilla linux]$ ls -l cram*
-rw-r--r--   1 bjornw   users     1179648 Mar 23 22:38 cram32768
-rw-r--r--   1 bjornw   users     1282048 Mar 23 22:38 cram4096
-rw-r--r--   1 bjornw   users     1220608 Mar 23 22:38 cram8192

(the numbers correspond to blocksize)

There's not any big difference here. 

With bigger files though, the difference get larger. YMMV.

Notice that you can change cramfs so it uses a blocksize that is bigger
than PAGE_SIZE, of course, if it really is necessary. You'll get worse
performance at run-time though since you need to cache the page and hope
for read-ahead or similar (you can stuff the pages in the page-cache even
if they are not requested for example).

-BW


