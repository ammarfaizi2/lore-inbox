Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265814AbUGBEjn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265814AbUGBEjn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jul 2004 00:39:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266364AbUGBEjn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jul 2004 00:39:43 -0400
Received: from fw.osdl.org ([65.172.181.6]:41116 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265814AbUGBEjm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jul 2004 00:39:42 -0400
Date: Thu, 1 Jul 2004 21:38:37 -0700
From: Andrew Morton <akpm@osdl.org>
To: Yichen Xie <yxie@cs.stanford.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BUGS] [CHECKER] 99 synchronization bugs and a lock summary
 database
Message-Id: <20040701213837.0b97c21e.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.44.0407011747040.4015-100000@kaki.stanford.edu>
References: <Pine.LNX.4.44.0407011747040.4015-100000@kaki.stanford.edu>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yichen Xie <yxie@cs.stanford.edu> wrote:
>
>     http://glide.stanford.edu/linux-lock/err1.html (69 errors)
>      http://glide.stanford.edu/linux-lock/err2.html (30 errors)

ugh.  Most of these look real.

AFAICT fs/sysv/itree.c:find_shared is innocent.

fs/nfsd/nfsproc.c:nfsd_proc_link is a bit obscure.  There's a bug in a
callee of nfsd_proc_link(): nfsd_link() can forget to do an fh_unlock() on
an error path (the goto out_nfserr).  Is that what the tool is referring
to?

Anyway, I've enumerated these 109 bugs and placed a couple of text files at

   ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/stanford-locking-bugs/

so we can keep track of which of these possible bugs has been fixed or
otherwise disposed of.

If people could track the bugs by those identifiers, that would help.  I
fixed err1-10 and err1-25.

If someone wants to volunteer to maintain this list, that would be nice.
