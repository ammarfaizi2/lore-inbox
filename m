Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265435AbUAZAc3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jan 2004 19:32:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265437AbUAZAc3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jan 2004 19:32:29 -0500
Received: from fw.osdl.org ([65.172.181.6]:54436 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265435AbUAZAc2 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jan 2004 19:32:28 -0500
Date: Sun, 25 Jan 2004 16:32:05 -0800
From: Andrew Morton <akpm@osdl.org>
To: Diego Calleja =?ISO-8859-1?B?R2FyY+1h?= <aradorlinux@yahoo.es>
Cc: bart@samwel.tk, felix-kernel@fefe.de, linux-kernel@vger.kernel.org
Subject: Re: Request: I/O request recording
Message-Id: <20040125163205.10a958aa.akpm@osdl.org>
In-Reply-To: <20040126012356.3a21ae18.aradorlinux@yahoo.es>
References: <20040124181026.GA22100@codeblau.de>
	<20040124153551.24e74f63.akpm@osdl.org>
	<40144A36.5090709@samwel.tk>
	<20040125150914.1583d487.akpm@osdl.org>
	<4014516D.5070409@samwel.tk>
	<20040125153803.4d7e1015.akpm@osdl.org>
	<20040126012356.3a21ae18.aradorlinux@yahoo.es>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Diego Calleja García <aradorlinux@yahoo.es> wrote:
>
> El Sun, 25 Jan 2004 15:38:03 -0800 Andrew Morton <akpm@osdl.org> escribió:
> 
> > Unfortunately you cannot determine a directory's blocks in this way. 
> > Ext3's directories live in the /dev/hda1 pagecache anyway.  ext2's
> > directories each have their own pagecache.
> 
> It would be possible to "hijack" the syscalls at libc level and look at what
> the program is doing?

That would work.  It misses out on pagefaults, which are kind of syscalls
in disguise.  So for any files which were mmapped you'd have to either
assume that all of the file's pages are required, or use mincore() to poke
around and find out which pages were really faulted in.
