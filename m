Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264503AbUIIToN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264503AbUIIToN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 15:44:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266835AbUIITmn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 15:42:43 -0400
Received: from holomorphy.com ([207.189.100.168]:53170 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S264503AbUIITfz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 15:35:55 -0400
Date: Thu, 9 Sep 2004 12:35:21 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>
Cc: torvalds@osdl.org, dev@sw.ru, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] adding per sb inode list to make invalidate_inodes() faster
Message-ID: <20040909193521.GL3106@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@osdl.org>, torvalds@osdl.org, dev@sw.ru,
	linux-kernel@vger.kernel.org
References: <4140791F.8050207@sw.ru> <Pine.LNX.4.58.0409090844410.5912@ppc970.osdl.org> <20040909171927.GU3106@holomorphy.com> <20040909110622.78028ae6.akpm@osdl.org> <20040909181818.GF3106@holomorphy.com> <20040909120818.7f127d14.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040909120818.7f127d14.akpm@osdl.org>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III <wli@holomorphy.com> wrote:
>>  The only motive I'm aware of is for latency in the presence of things
>>  such as autofs. It's also worth noting that in the presence of things
>>  such as removable media umount is also much more common. I personally
>>  find this sufficiently compelling. Kirill may have additional ammunition.

On Thu, Sep 09, 2004 at 12:08:18PM -0700, Andrew Morton wrote:
> Well.  That's why I'm keeping the patch alive-but-unmerged.  Waiting to see
> who wants it.
> There are people who have large machines which are automounting hundreds of
> different NFS servers.  I'd certainly expect such a machine to experience
> ongoing umount glitches.  But no reports have yet been sighted by this
> little black duck.

Unfortunately all the scenarios I'm aware of where this is an ongoing
issue involve extremely downrev and vendor-centric kernel versions along
with the usual ultraconservative system administration, so this specific
concern is somewhat downplayed as other ongoing functional concerns
(e.g. direct IO on nfs breaking, deadlocks, getting zillions of fs's to
mount at all, etc.) have far higher priority than performance concerns.


William Lee Irwin III <wli@holomorphy.com> wrote:
>>  Also, the additional sizeof(struct list_head) is only a requirement
>>  while the global inode LRU is maintained. I believed it would have
>>  been beneficial to have localized the LRU to the sb also, which would
>>  have maintained sizeof(struct inode0 at parity with current mainline.

On Thu, Sep 09, 2004 at 12:08:18PM -0700, Andrew Morton wrote:
> Could be.  We would give each superblock its own shrinker callback and
> everything should balance out nicely (hah).

Hmm. My first leaning and implementation was to hierarchically LRU
inodes within sb's, but I suppose that's plausible. Let me know if you
want the shrinker callbacks or something else in particular done.


-- wli
