Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261649AbTJMLQo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Oct 2003 07:16:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261664AbTJMLQo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Oct 2003 07:16:44 -0400
Received: from holomorphy.com ([66.224.33.161]:44421 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S261649AbTJMLQn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Oct 2003 07:16:43 -0400
Date: Mon, 13 Oct 2003 04:19:31 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>
Cc: kk@sw.ru, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Invalidate_inodes can be very slow
Message-ID: <20031013111931.GH16158@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@osdl.org>, kk@sw.ru,
	linux-kernel@vger.kernel.org
References: <200310131318.09234.kk@sw.ru> <20031013095347.GF16158@holomorphy.com> <20031013040821.19b3745e.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031013040821.19b3745e.akpm@osdl.org>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III <wli@holomorphy.com> wrote:
>> Untested brute-force forward port to 2.6.0-test7-bk4. No idea if the
>>  locking is correct or if list movement is done in all needed places.

On Mon, Oct 13, 2003 at 04:08:21AM -0700, Andrew Morton wrote:
> My preferred approach to this would be to move all the global inode lists
> into the superblock so both they and inode_lock become per-sb.
> It is a big change though.  And, amazingly, nobody has yet hit sufficient
> inode_lock contention to warrant it.
> Yes, I bet that this search will hurt like hell on a really big box which
> has thousands of auto-expiring NFS mounts.  Please test your patch and I'll
> queue it up while we think about it some more.

Generally dcache_lock stands in front of inode_lock, even with the
current hashtable RCU code. inode_lock has been seen before in unusual
situations I don't remember offhand, though generally it's not #1.
The workloads used for, say, benchmark testing don't adequately model
situations like what you just mentioned (or a number of other real-life
usage cases), so per-sb inode_lock may be worth considering on a priori
grounds, though it would probably be better to actually set something
up to test that scenario.

-- wli
