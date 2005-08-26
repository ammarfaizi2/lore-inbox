Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750771AbVHZCtp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750771AbVHZCtp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 22:49:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751116AbVHZCtp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 22:49:45 -0400
Received: from pop.gmx.net ([213.165.64.20]:55680 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750771AbVHZCtp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 22:49:45 -0400
X-Authenticated: #20526576
Message-ID: <430E83D8.4050509@gmx.de>
Date: Fri, 26 Aug 2005 04:52:08 +0200
From: Andreas Baer <andreas_baer@gmx.de>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050823)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Memory-Mapping with LFS
X-Enigmail-Version: 0.92.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Who is the memory mapping expert? :)

What are the current file size limits for memory mapping via glibc's
mmap() function on linux:

- for a native 32-Bit System not using LFS?
- for a native 32-Bit System using LFS?
- for a native 64-Bit System?

(linux-kernel >2.6, of course)

It would be nice if someone could tell me what I have to consider if I
want to use memory mapping for files. I'm currently a little bit
confused about it (information overflow :)). Personal opinions about
speed (maybe increase or decrease for large files) are also welcome.

--------------------------

The glibc documentation says:
"Since mmapped pages can be stored back to their file when physical
memory is low, it is possible to mmap files orders of magnitude larger
than both the physical memory and swap space. The only limit is address
space. The theoretical limit is 4GB on a 32-bit machine - however, the
actual limit will be smaller since some areas will be reserved for other
purposes. If the LFS interface is used the file size on 32-bit systems
is not limited to 2GB (offsets are signed which reduces the addressable
area of 4GB by half); the full 64-bit are available."

- I doubt that the full 64-Bit (something within Exabyte) are available
in practical use. Right or wrong?


I've also found an old kernel-list e-mail from 2004 that says:
"There is a limit per process in the kernel vm that prevent from
mmapping more than 512GB of data."

- Is this still true for the current kernel?


An example:

Let's presume the following case. I have an 8 GB file, 1 GB physical
memory and I want to use memory mapping for that file using LFS on a
32-Bit machine.

- Is it possible?

If yes, let's presume that I have 2 or more pointers, that are
frequently pointing to completely different places and switch the data
they are pointing to.

- How is it managed (by the kernel)? Through the pages, that are
mentioned in the glibc documentation above? Are these page operations
really faster than normal random file access (lseek etc)?

