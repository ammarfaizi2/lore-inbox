Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261400AbUDCBsy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Apr 2004 20:48:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261366AbUDCBsy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Apr 2004 20:48:54 -0500
Received: from fw.osdl.org ([65.172.181.6]:16822 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261400AbUDCBsw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Apr 2004 20:48:52 -0500
Date: Fri, 2 Apr 2004 17:50:49 -0800
From: Andrew Morton <akpm@osdl.org>
To: Mingming Cao <cmm@us.ibm.com>
Cc: tytso@mit.edu, pbadari@us.ibm.com, linux-kernel@vger.kernel.org,
       cmm@us.ibm.com, ext2-devel@lists.sourceforge.net
Subject: Re: [Ext2-devel] Re: [RFC, PATCH] Reservation based ext3
 preallocation
Message-Id: <20040402175049.20b10864.akpm@osdl.org>
In-Reply-To: <1080956712.15980.6505.camel@localhost.localdomain>
References: <200403190846.56955.pbadari@us.ibm.com>
	<20040321015746.14b3c0dc.akpm@osdl.org>
	<1080636930.3548.4549.camel@localhost.localdomain>
	<20040330014523.6a368a69.akpm@osdl.org>
	<1080956712.15980.6505.camel@localhost.localdomain>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mingming Cao <cmm@us.ibm.com> wrote:
>
> Hi Andrew,
> Here is the second version of the ext3, mostly bug fixes and made the
> changes you have suggested last time.  

Great, thanks.

> Besides enable/disable the
> reservation feature, I am thinking to enable the feature that could set
> the the default reservation window size(in blocks) when the fs is
> mounted.   just one single mount option:"prealloc_window=n". When n=0,
> it means turns off, when n>0, it means on, and the ext3 default
> reservation window size for each file is n blocks(or 8 blocks, if 0< n <
> 8).

hm, maybe.  We should probably also provide a per-file ext3-specific ioctl
to allow specialised apps to manipulate the reservation size.

And we should grow the reservation size dynamically.  I've suggested that
we double its size each time it is exhausted, up to some limit.  There may
be better algorithms though.

This work doesn't help us with the slowly-growing logfile or mailbox file
problem.  I guess that would require on-disk reservations, or a new
`chattr' hint or such.

