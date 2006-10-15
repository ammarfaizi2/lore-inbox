Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030228AbWJOTMW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030228AbWJOTMW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Oct 2006 15:12:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030231AbWJOTMW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Oct 2006 15:12:22 -0400
Received: from smtp.osdl.org ([65.172.181.4]:4580 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030228AbWJOTMV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Oct 2006 15:12:21 -0400
Date: Sun, 15 Oct 2006 12:12:02 -0700
From: Andrew Morton <akpm@osdl.org>
To: bijwaard@gmail.com
Cc: "Dennis J.A. Bijwaard" <dennis@h8922032063.dsl.speedlinq.nl>,
       sct@redhat.com, adilger@clusterfs.com, linux-kernel@vger.kernel.org
Subject: Re: BUG: soft lockup detected on CPU#0! in sys_close and ext3
Message-Id: <20061015121202.378bdd41.akpm@osdl.org>
In-Reply-To: <20061015175640.GA3673@jumbo.lan>
References: <20061015175640.GA3673@jumbo.lan>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 15 Oct 2006 19:56:40 +0200
"Dennis J.A. Bijwaard" <dennis@h8922032063.dsl.speedlinq.nl> wrote:

> I got two soft lockups on one of the CPUs just now. I'm unsure if this
> problem is in ext3, sys_close, or general kernel, so I've CC'd the
> kernel list.
> 
> [1.] One line summary of the problem:
> 
> BUG: soft lockup detected on CPU#0! in sys_close/fput and ext3 journaling

Both warnings occurred when the kernel was tearing down large amounts of
pagecache via invalidate_inode_pages().  One instances was a blockdev
(probably the final close on the dvd) and the other was a regular file
(perhaps a large dvd image?)

The CPU is slow: 500MHz pIII.  How much memory does it have?

So the kernel was doing a lot of work, on a slow CPU.  Perhaps that simply
exceeded the softlockup timeout.  If that's true then the machine should
have recovered.  Once it did, and once it didn't.  I don't know why it
didn't.


