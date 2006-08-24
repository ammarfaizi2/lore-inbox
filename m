Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750932AbWHXKGU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750932AbWHXKGU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 06:06:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751009AbWHXKGU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 06:06:20 -0400
Received: from TYO202.gate.nec.co.jp ([202.32.8.206]:18678 "EHLO
	tyo202.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S1750869AbWHXKGT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 06:06:19 -0400
To: Andrew Morton <akpm@osdl.org>
Cc: Nathan Scott <nathans@sgi.com>, David Chinner <dgc@sgi.com>,
       xfs@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] Add new spin_lock for i_flags of xfs_inode [try #2]
In-reply-to: <20060823213817.16cdfe8a.akpm@osdl.org>
Message-Id: <20060824190519m-saito@mail.aom.tnes.nec.co.jp>
References: <20060823213817.16cdfe8a.akpm@osdl.org>
Mime-Version: 1.0
X-Mailer: WeMail32[2.51] ID:1K0086
From: Masayuki Saito <m-saito@tnes.nec.co.jp>
Date: Thu, 24 Aug 2006 19:05:19 +0900
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you for your comment.

Andrew Morton <akpm@osdl.org> wrote:
>On Wed, 23 Aug 2006 20:12:51 +0900
>Masayuki Saito <m-saito@tnes.nec.co.jp> wrote:
>
>> It is the problem that i_flags of xfs_inode has no consistent
>> locking protection.
>> 
>> For the reason, I define a new spin_lock(i_flags_lock) for i_flags
>> of xfs_inode.  And I add this spin_lock for appropriate places.
>
>You could simply use inode.i_lock for this.  i_lock is a general-purpose
>per-inode lock.  Its mandate is "use it for whatever you like, but it must
>always be `innermost'"
>

I think that inode.i_lock isn't appropriate for this case.
Because there is the situation that no inode is attached to an xfs_inode.


Masayuki
