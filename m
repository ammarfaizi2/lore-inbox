Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261870AbUCVLJm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Mar 2004 06:09:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261874AbUCVLJm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Mar 2004 06:09:42 -0500
Received: from fw.osdl.org ([65.172.181.6]:58080 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261870AbUCVLJl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Mar 2004 06:09:41 -0500
Date: Mon, 22 Mar 2004 03:09:39 -0800
From: Andrew Morton <akpm@osdl.org>
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org, mason@suse.com
Subject: Re: [PATCH] barrier patch set
Message-Id: <20040322030939.6243c1c2.akpm@osdl.org>
In-Reply-To: <20040319153554.GC2933@suse.de>
References: <20040319153554.GC2933@suse.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe <axboe@suse.de> wrote:
>
>  A first release of a collected barrier patchset for 2.6.5-rc1-mm2.

The tagging of BIOs with set_buffer_ordered() or WRITE_BARRIER is a little
awkward.

Take the case of an ext2 fsync() or even an ext3 fsync() which frequently
will not trigger a commit.  If we must perform the barrier by tagging the
final BIO, that will be tricky to implement.  I could set some new field in
struct writeback_control and rework the mpage code, but working out "this
is the final BIO for this operation" is a fairly hard thing to do. 
sys_sync() would require even more VFS surgery.

Generally, it would be much preferable to use the blkdev_issue_flush() API.
What is the status of that?

