Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261298AbTK0UuJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Nov 2003 15:50:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261305AbTK0UuI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Nov 2003 15:50:08 -0500
Received: from ssa8.serverconfig.com ([209.51.129.179]:62122 "EHLO
	ssa8.serverconfig.com") by vger.kernel.org with ESMTP
	id S261298AbTK0Ut4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Nov 2003 15:49:56 -0500
From: "Joseph D. Wagner" <theman@josephdwagner.info>
To: Jamie Lokier <jamie@shareable.org>, Nikita Danilov <Nikita@Namesys.COM>
Subject: Re: [PATCH] fs/locks.c fcntl_setlease did not check if a file was opened for writing before granting a read lease
Date: Thu, 27 Nov 2003 14:49:51 +0600
User-Agent: KMail/1.5.4
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       "'Matthew Wilcox'" <willy@debian.org>
References: <000301c3b504$689afbf0$0201a8c0@joe> <16326.14408.365320.326423@laputa.namesys.com> <20031127180329.GC19669@mail.shareable.org>
In-Reply-To: <20031127180329.GC19669@mail.shareable.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200311271449.51696.theman@josephdwagner.info>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - ssa8.serverconfig.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - josephdwagner.info
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> But I THINK this is how a patch would fix the problem, in theory.

> Sorry, it won't.
...
> To detect if anyone has the file open for writing, you'll a new count
> field which keeps track of writer references.  Something like this:
>
>        if ((arg == F_RDLCK)
>            && ((atomic_read(&inode->i_writer_count) != 0)))
>
> You'll also need to modify all the places where that needs to be
> maintained.

Well, dang it all.  Why didn't they guy who implemented leasing in the first 
place bother to do it right the first time?

I don't have the time or technical expertise in kernel development to go 
through all that.  Somebody else is going to have to pick up his slack.

Joseph D. Wagner

