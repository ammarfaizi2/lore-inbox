Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262546AbTJZFss (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Oct 2003 01:48:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262834AbTJZFss
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Oct 2003 01:48:48 -0400
Received: from fw.osdl.org ([65.172.181.6]:4051 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262546AbTJZFsr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Oct 2003 01:48:47 -0400
Date: Sat, 25 Oct 2003 22:49:50 -0700
From: Andrew Morton <akpm@osdl.org>
To: arekm@pld-linux.org, linux-kernel@vger.kernel.org,
       viro@parcelfarce.linux.theplanet.co.uk, jmorris@redhat.com,
       sds@epoch.ncsc.mil
Cc: Manfred Spraul <manfred@colorfullife.com>
Subject: Re: 2.6.0-test9 and sleeping function called from invalid context
Message-Id: <20031025224950.001b4055.akpm@osdl.org>
In-Reply-To: <20031025185055.4d9273ae.akpm@osdl.org>
References: <200310260045.52094.arekm@pld-linux.org>
	<20031025185055.4d9273ae.akpm@osdl.org>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> wrote:
>
> but the wider question would be: is the SELinux
>  d_instantiate callout allowed to sleep?  A quick audit seems to indicate
>  that it's OK, but only by luck I think.

proc_pid_lookup() calls d_add->d_instantiate under task->proc_lock, so
inode_doinit_with_dentry() is called under spinlock on this path as well.

Manfred, is there any particular reason why proc_pid_lookup()'s d_add is
inside the lock?

