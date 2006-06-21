Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750936AbWFUOmT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750936AbWFUOmT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 10:42:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751582AbWFUOmT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 10:42:19 -0400
Received: from gw.openss7.com ([142.179.199.224]:34736 "EHLO gw.openss7.com")
	by vger.kernel.org with ESMTP id S1750936AbWFUOmS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 10:42:18 -0400
Date: Wed, 21 Jun 2006 08:42:17 -0600
From: "Brian F. G. Bidulock" <bidulock@openss7.org>
To: Theodore Tso <tytso@thunk.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] [PATCH 0/8] Inode diet v2
Message-ID: <20060621084217.B7834@openss7.org>
Reply-To: bidulock@openss7.org
Mail-Followup-To: Theodore Tso <tytso@thunk.org>,
	linux-kernel@vger.kernel.org
References: <20060621125146.508341000@candygram.thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20060621125146.508341000@candygram.thunk.org>; from tytso@thunk.org on Wed, Jun 21, 2006 at 08:51:46AM -0400
Organization: http://www.openss7.org/
Dsn-Notification-To: <bidulock@openss7.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Theodore,

On Wed, 21 Jun 2006, Theodore Tso wrote:

> Unfortunately, since these structures are used by a large amount of
> kernel code, some of the patches are quite involved, and/or will
> require a lot of auditing and code review, for "only" 4 or 8 bytes at
> a time (maybe more on 64-bit platforms).  However, since there are
> many, many copies of struct inode all over the kernel, even a small
> reduction in size can have a large beneficial result, and as the old
> Chinese saying goes, a journey of thousand miles begins with a single
> step....

Can you grep inode_cache /proc/slabinfo to see whether you saved any
memory at all?

You need to save 48 bytes per inode to fit one more into a slab with
a 32 byte L1 cache slot; 120 bytes per inode, 64 byte L1 cache slot.
And that's just a generic inode_cache object.  Something that is really
used, like ext3_inode_cache or nfs_inode_cache is going to take more
doing.  Moving a field from the generic inode to the filesystem specific
inode acheives nothing.

