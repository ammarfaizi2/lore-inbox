Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751218AbWFBMci@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751218AbWFBMci (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 08:32:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751302AbWFBMci
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 08:32:38 -0400
Received: from tayrelbas03.tay.hp.com ([161.114.80.246]:45230 "EHLO
	tayrelbas03.tay.hp.com") by vger.kernel.org with ESMTP
	id S1751218AbWFBMci (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 08:32:38 -0400
Date: Fri, 2 Jun 2006 08:32:34 -0400
From: Amy Griffis <amy.griffis@hp.com>
To: linux-kernel@vger.kernel.org
Cc: John McCutchan <john@johnmccutchan.com>, Robert Love <rlove@rlove.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] inotify: split kernel API from userspace support
Message-ID: <20060602123234.GA6586@zk3.dec.com>
References: <20060601150702.GA2171@zk3.dec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060601150702.GA2171@zk3.dec.com>
X-Mailer: Mutt http://www.mutt.org/
X-Editor: Vim http://www.vim.org/
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is a more descriptive changelog message for this patch:

This patch introduces a kernel API for inotify, making it possible for
kernel modules to benefit from inotify's mechanism for watching
inodes.

To provide the kernel API, the current inotify code is split into two
parts: core functionality remains in inotify.c, and functionality
supporting userspace is moved to a new file inotify_user.c.  The
inotify_device struct is split into inotify_handle (idr, watch list,
inotify operations) and inotify_device (event queue for userspace).
This patch also makes struct inotify_watch public so it can be
embedded in a caller's own watch structure.

In order to separate the find/update watch and add watch operations
for the kernel API, this patch adds a second per-inotify_device mutex 
to prevent a userspace caller from adding the same watch twice.

This patch retains the original assumption that there will be more
watches per inotify_handle than watches on any given inode, and
performs the search for existing watches accordingly.

On Thu, Jun 01, 2006 at 11:07:02AM -0400, Amy Griffis wrote:
> Signed-off-by: Amy Griffis <amy.griffis@hp.com>
> 
> ---
> 
>  fs/Kconfig              |   24 +
>  fs/Makefile             |    1 
>  fs/inotify.c            |  941 +++++++++++------------------------------------
>  fs/inotify_user.c       |  717 ++++++++++++++++++++++++++++++++++++
>  include/linux/inotify.h |   76 ++++
>  include/linux/sched.h   |    2 
>  kernel/sysctl.c         |    4 
>  kernel/user.c           |    2 
>  8 files changed, 1046 insertions(+), 721 deletions(-)
>  create mode 100644 fs/inotify_user.c

