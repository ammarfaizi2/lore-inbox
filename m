Return-Path: <linux-kernel-owner+w=401wt.eu-S932382AbXAIWfi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932382AbXAIWfi (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 17:35:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932271AbXAIWfi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 17:35:38 -0500
Received: from smtp.osdl.org ([65.172.181.24]:49127 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932382AbXAIWfh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 17:35:37 -0500
Date: Tue, 9 Jan 2007 14:31:15 -0800
From: Andrew Morton <akpm@osdl.org>
To: Michael Halcrow <mhalcrow@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, tshighla@us.ibm.com, theotso@us.ibm.com
Subject: Re: [PATCH 2/3] eCryptfs: Generalize metadata read/write
Message-Id: <20070109143115.b264f825.akpm@osdl.org>
In-Reply-To: <20070109222255.GE16578@us.ibm.com>
References: <20070109222107.GC16578@us.ibm.com>
	<20070109222255.GE16578@us.ibm.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Jan 2007 16:22:55 -0600
Michael Halcrow <mhalcrow@us.ibm.com> wrote:

> +		lower_file->f_op->write(lower_file, (char __user *)page_virt,
> +					PAGE_CACHE_SIZE, &lower_file->f_pos);

hm.  sys_write() takes a local copy of f_pos and writes that back into the
struct file.  It does this so that two concurrent write() callers don't
make a mess of f_pos, and of the file contents.

Perhaps ecryptfs should be calling vfs_write()?

That way we'd also get the fsnotify notifications, which ecryptfs presently
appears to have subverted.

