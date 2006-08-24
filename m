Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030279AbWHXEij@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030279AbWHXEij (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 00:38:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030280AbWHXEij
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 00:38:39 -0400
Received: from smtp.osdl.org ([65.172.181.4]:33462 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030279AbWHXEii (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 00:38:38 -0400
Date: Wed, 23 Aug 2006 21:38:17 -0700
From: Andrew Morton <akpm@osdl.org>
To: Masayuki Saito <m-saito@tnes.nec.co.jp>
Cc: Nathan Scott <nathans@sgi.com>, David Chinner <dgc@sgi.com>,
       xfs@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] Add new spin_lock for i_flags of xfs_inode [try #2]
Message-Id: <20060823213817.16cdfe8a.akpm@osdl.org>
In-Reply-To: <20060823201251m-saito@mail.aom.tnes.nec.co.jp>
References: <20060823201251m-saito@mail.aom.tnes.nec.co.jp>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Aug 2006 20:12:51 +0900
Masayuki Saito <m-saito@tnes.nec.co.jp> wrote:

> It is the problem that i_flags of xfs_inode has no consistent
> locking protection.
> 
> For the reason, I define a new spin_lock(i_flags_lock) for i_flags
> of xfs_inode.  And I add this spin_lock for appropriate places.

You could simply use inode.i_lock for this.  i_lock is a general-purpose
per-inode lock.  Its mandate is "use it for whatever you like, but it must
always be `innermost'"
