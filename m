Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266646AbUIIS3y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266646AbUIIS3y (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 14:29:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266569AbUIIS1x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 14:27:53 -0400
Received: from holomorphy.com ([207.189.100.168]:15794 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S266650AbUIISSy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 14:18:54 -0400
Date: Thu, 9 Sep 2004 11:18:18 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>
Cc: torvalds@osdl.org, dev@sw.ru, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] adding per sb inode list to make invalidate_inodes() faster
Message-ID: <20040909181818.GF3106@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@osdl.org>, torvalds@osdl.org, dev@sw.ru,
	linux-kernel@vger.kernel.org
References: <4140791F.8050207@sw.ru> <Pine.LNX.4.58.0409090844410.5912@ppc970.osdl.org> <20040909171927.GU3106@holomorphy.com> <20040909110622.78028ae6.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040909110622.78028ae6.akpm@osdl.org>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III <wli@holomorphy.com> wrote:
>> I've not reviewed this version of the patch for differences with the -mm
>> code. It would probably be best to look at the -mm bits as they've had
>> sustained exposure for quite some time.

On Thu, Sep 09, 2004 at 11:06:22AM -0700, Andrew Morton wrote:
> Yes.
> I have not merged it up because it seems rather dopey to add eight bytes to
> the inode to speed up something as rare as umount.
> Is there a convincing reason for proceeding with the change?

The only motive I'm aware of is for latency in the presence of things
such as autofs. It's also worth noting that in the presence of things
such as removable media umount is also much more common. I personally
find this sufficiently compelling. Kirill may have additional ammunition.

Also, the additional sizeof(struct list_head) is only a requirement
while the global inode LRU is maintained. I believed it would have
been beneficial to have localized the LRU to the sb also, which would
have maintained sizeof(struct inode0 at parity with current mainline.


-- wli
