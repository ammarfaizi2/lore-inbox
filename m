Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262799AbUKRRbP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262799AbUKRRbP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 12:31:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262810AbUKRR3u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 12:29:50 -0500
Received: from mail.euroweb.hu ([193.226.220.4]:29366 "HELO mail.euroweb.hu")
	by vger.kernel.org with SMTP id S262802AbUKRR2j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 12:28:39 -0500
To: hbryan@us.ibm.com
CC: akpm@osdl.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       pavel@ucw.cz, torvalds@osdl.org
In-reply-to: <OF28252066.81A6726A-ON88256F50.005D917A-88256F50.005EA7D9@us.ibm.com>
	(message from Bryan Henderson on Thu, 18 Nov 2004 09:12:59 -0800)
Subject: Re: [PATCH] [Request for inclusion] Filesystem in Userspace
References: <OF28252066.81A6726A-ON88256F50.005D917A-88256F50.005EA7D9@us.ibm.com>
Message-Id: <E1CUq57-00043P-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 18 Nov 2004 18:28:29 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> A normal write is a VFS write() call, I assume.  While they're going 
> through the page cache, the pages are dirty, right?  Is it possible that 
> FUSE needs more real memory after dirtying those pages in order to finish 
> cleaning them?

It's possible, but I don't see why that's a problem.  If it can get
more memory it's OK.  If allocation fails, then the write() will fail
with ENOMEM, if OOM killer get's to work and kills the FUSE process,
then write will return with ENOTCONN or something like that.

> What about the 3rd case: private writable mapping?  How does that work?

That only reads pages and never writes them.  It's just like malloc,
but prefilled with the file contents.

Miklos
