Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264246AbUIDWlE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264246AbUIDWlE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Sep 2004 18:41:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264261AbUIDWlE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Sep 2004 18:41:04 -0400
Received: from fw.osdl.org ([65.172.181.6]:34993 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264246AbUIDWlB convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Sep 2004 18:41:01 -0400
Date: Sat, 4 Sep 2004 15:39:02 -0700
From: Andrew Morton <akpm@osdl.org>
To: =?ISO-8859-1?B?SvZybg==?= Engel <joern@wohnheim.fh-wedel.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] copyfile: generic_sendpage
Message-Id: <20040904153902.6ac075ea.akpm@osdl.org>
In-Reply-To: <20040904165733.GC8579@wohnheim.fh-wedel.de>
References: <20040904165733.GC8579@wohnheim.fh-wedel.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jörn Engel <joern@wohnheim.fh-wedel.de> wrote:
>
> o Add sendfile() support for file targets to normal mm/filemap.c.

This comes up fairly regularly.  See, for example,
http://lwn.net/Articles/88751/ for what appears to be a much simpler
implementation.

I discussed file->file sendfile with Linus a while back and he said

> I think it was about doing a 2GB file-file sendfile, and see your system
> grind to a halt without being able to kill it.
> 
> That said, we have some of the same problems with just regular read/write 
> too. sendfile just makes it easier.
> 
> We should probably make read/write be interruptible by _fatal_ signals.  
> It would require a new task state, though (TASK_KILLABLE or something, and
> it would show up as a normal 'D' state).

I don't know how much of a problem this is in practice - there are all
sorts of nasty things which unprivileged apps can do to the system by
overloading filesystems.  Although most of them can be killed off by the
sysadmin.

(My infamous bash-shared-mappings stresstest can spend ten or more minutes
within a single write() call, but you have to try hard to do this).

