Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261685AbUE3ExV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261685AbUE3ExV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 May 2004 00:53:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261712AbUE3ExV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 May 2004 00:53:21 -0400
Received: from fw.osdl.org ([65.172.181.6]:4582 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261685AbUE3ExT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 May 2004 00:53:19 -0400
Date: Sat, 29 May 2004 21:52:26 -0700
From: Andrew Morton <akpm@osdl.org>
To: Doug Ledford <dledford@redhat.com>
Cc: antlarr@tedial.com, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
Subject: Re: iowait problems on 2.6, not on 2.4
Message-Id: <20040529215226.68605319.akpm@osdl.org>
In-Reply-To: <1085877991.18642.336.camel@compaq.xsintricity.com>
References: <200405261743.28111.antlarr@tedial.com>
	<20040526205225.7a0866aa.akpm@osdl.org>
	<200405281516.41901.antlarr@tedial.com>
	<20040528154525.6ed5f7b9.akpm@osdl.org>
	<1085877991.18642.336.camel@compaq.xsintricity.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Doug Ledford <dledford@redhat.com> wrote:
>
> But, I could be wrong.  Give it a try and see what happens.  In the 2.4
>  kernels I would tell you to tweak /proc/sys/vm/{min,max}-readahead,
>  don't know if those two knobs still exist in 2.6 and if they have the
>  same effect.  Andrew?

blockdev --setra N /dev/sda 			(N is in 512 byte units)

echo N > /sys/block/sda/queue/read_ahead_kb	(N is in kilobytes)

Also there was breakage (recently fixed) in which /dev/sdaN's readahead
setting was being inherited from the blockdev on which /dev resides.  But
reading regular files is OK.

