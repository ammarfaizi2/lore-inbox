Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266501AbUGBIQx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266501AbUGBIQx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jul 2004 04:16:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266511AbUGBIQx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jul 2004 04:16:53 -0400
Received: from fw.osdl.org ([65.172.181.6]:13260 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266501AbUGBIQ2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jul 2004 04:16:28 -0400
Date: Fri, 2 Jul 2004 01:15:25 -0700
From: Andrew Morton <akpm@osdl.org>
To: Yichen Xie <yxie@cs.stanford.edu>
Cc: linux-kernel@vger.kernel.org, Manfred Spraul <manfred@colorfullife.com>
Subject: Re: [BUGS] [CHECKER] 99 synchronization bugs and a lock summary
 database
Message-Id: <20040702011525.1f0d0829.akpm@osdl.org>
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

ipc/sem.c:find_undo() seems to be a false positive.  That function calls
sem_revalidate() which may or may not require a sem_unlock() afterwards,
depending on what value it returned.

I'm not sure it's worth teaching the tool about this - I'd refer to
strangle the IPC code.
