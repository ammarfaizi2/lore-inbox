Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261953AbUJYPPY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261953AbUJYPPY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 11:15:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261951AbUJYPOz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 11:14:55 -0400
Received: from phoenix.infradead.org ([81.187.226.98]:59148 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S261922AbUJYPOF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 11:14:05 -0400
Date: Mon, 25 Oct 2004 16:14:05 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Mike Waychison <michael.waychison@sun.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       raven@themaw.net
Subject: Re: [PATCH 25/28] VFS: statfs(64) shouldn't follow last component symlink
Message-ID: <20041025151405.GA1740@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Mike Waychison <michael.waychison@sun.com>,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	raven@themaw.net
References: <10987158413464@sun.com> <10987158711277@sun.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10987158711277@sun.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 25, 2004 at 10:51:11AM -0400, Mike Waychison wrote:
> Mount-related userspace tools will require the ability to detect whether what
> looks like a regular directory is actually a autofs trigger.  To handle this,
> tools can statfs a given directory and check to see if statfs->f_type ==
> AUTOFSNG_SUPER_MAGIC before walking into the directory (and causing the a
> filesystem to automount).
> 
> To make this happen, we cannot allow statfs to follow_link.
> 
> NOTE: This may break any userspace that assumes it can statfs across a
> last-component symlink.  I can't think of any real world breakage however, as
> mount(8) will drop the real path in /etc/mtab and /proc/mounts will always
> show the true path.

Which means it's vetoed.  It's a big change in syscall semantics.  And
propabably breaks SuS (for statvfs(3) which requires full symlink
resolution when it just refers to a path on the filesystem.

