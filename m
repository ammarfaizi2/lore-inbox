Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265296AbUAYXJp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jan 2004 18:09:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265328AbUAYXJp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jan 2004 18:09:45 -0500
Received: from fw.osdl.org ([65.172.181.6]:10978 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265296AbUAYXJn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jan 2004 18:09:43 -0500
Date: Sun, 25 Jan 2004 15:09:14 -0800
From: Andrew Morton <akpm@osdl.org>
To: Bart Samwel <bart@samwel.tk>
Cc: felix-kernel@fefe.de, linux-kernel@vger.kernel.org
Subject: Re: Request: I/O request recording
Message-Id: <20040125150914.1583d487.akpm@osdl.org>
In-Reply-To: <40144A36.5090709@samwel.tk>
References: <20040124181026.GA22100@codeblau.de>
	<20040124153551.24e74f63.akpm@osdl.org>
	<40144A36.5090709@samwel.tk>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bart Samwel <bart@samwel.tk> wrote:
>
> When I saw this thread I've fiddled for a bit with the block_dump
>  functionality that's in the laptop_mode patch. I wanted to see if it
>  could support a similar thing completely from user space (except for the
>  block_dump code, of course). I've written a small tool to generate a
>  complete file that lists tuples (sector, size, device) from the kernel
>  output in syslog; it parses all "READ block xxx" messages since the
>  last reboot. Putting this through sort -n -u delivers a nicely sorted
>  file, ready for optimized reading.
> 
>  Unfortunately I'm now stuck within the other part, which is reading the
>  pages back in memory at the next boot. It's not working, and I was 
>  hoping someone here could take a look and tell me what I'm doing wrong.

Linux caches disk data on a per-file basis.  So if you preload pagecache
via the /dev/hda1 "file", that is of no benefit to the /etc/passwd file. 
Each one has its own unique pagecache.  When reading pages for /etc/passwd
we don't go looking for the same disk blocks in the cache of /dev/hda1.

Which is why the userspace cache preloading needs to know the pathnames of
all the relevant files - it needs to open and read each one, applying
knowledge of disk layout while doing it.


