Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267194AbUHWAaV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267194AbUHWAaV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Aug 2004 20:30:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267264AbUHWAaV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Aug 2004 20:30:21 -0400
Received: from mail.ocs.com.au ([202.147.117.210]:40644 "EHLO mail.ocs.com.au")
	by vger.kernel.org with ESMTP id S267194AbUHWAaR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Aug 2004 20:30:17 -0400
X-Mailer: exmh version 2.6.3_20040314 03/14/2004 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>,
       William Lee Irwin III <wli@holomorphy.com>
Subject: Re: [PATCH][1/4] Completely out of line spinlocks / i386 
In-reply-to: Your message of "Sun, 22 Aug 2004 17:53:29 -0400."
             <Pine.LNX.4.58.0408221740090.27390@montezuma.fsmlabs.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 23 Aug 2004 10:29:48 +1000
Message-ID: <22241.1093220988@ocs3.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 22 Aug 2004 17:53:29 -0400 (EDT), 
Zwane Mwaikambo <zwane@linuxpower.ca> wrote:
>With the readprofile and oprofile changes it's still not that easy to
>determine which locks are being contended as the samples generally are
>being charged to the function the lock is being contended in. So some
>investigation has to be done when looking at profiles. This could be
>remedied by making the valid PC range include data or, preferably, moving
>spinlock variables into a special section. That way we can simply
>report back the lock word during sampling.

kdb attempts to decode the lock address on ia64.  A lot of the time,
the lock is dynamically allocated (think inodes) so symbol lookup is no
good.  I find that the decoding the lock is useful but not required,
the function that contended on the lock is more interesting.

