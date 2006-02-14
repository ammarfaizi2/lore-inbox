Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030342AbWBNEKF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030342AbWBNEKF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 23:10:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030346AbWBNEKE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 23:10:04 -0500
Received: from smtp.osdl.org ([65.172.181.4]:8097 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030342AbWBNEKC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 23:10:02 -0500
Date: Mon, 13 Feb 2006 20:09:05 -0800
From: Andrew Morton <akpm@osdl.org>
To: Joshua Hudson <joshudson@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: sb_bread & bforget
Message-Id: <20060213200905.5706dc33.akpm@osdl.org>
In-Reply-To: <bda6d13a0602131503n14650120gaa39eda9a38aefbf@mail.gmail.com>
References: <bda6d13a0602131503n14650120gaa39eda9a38aefbf@mail.gmail.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joshua Hudson <joshudson@gmail.com> wrote:
>
> New filesystem is using BTrees for directories. An update will touch
> multiple blocks, loaded into buffer_head structures with sb_bread.
> 
> If update fails (only possible causes are read error & disk full), is it
> kosher to call bforget on all modified buffer_head structures, or
> does that have some unintended consequences?

It's probably wrong.  bforget() will clear the dirty bit, so you'd lose
anything else which had been written to that buffer but not written back.

bforget() is used for truncate, where we know the data is being tosed away.
