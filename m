Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932075AbWF2Dzn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932075AbWF2Dzn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 23:55:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932135AbWF2Dzn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 23:55:43 -0400
Received: from smtp.osdl.org ([65.172.181.4]:28561 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932075AbWF2Dzn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 23:55:43 -0400
Date: Wed, 28 Jun 2006 20:55:39 -0700
From: Andrew Morton <akpm@osdl.org>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-...: looong writeouts
Message-Id: <20060628205539.f7e1c43b.akpm@osdl.org>
In-Reply-To: <20060624151531.GA7565@martell.zuzino.mipt.ru>
References: <20060624151531.GA7565@martell.zuzino.mipt.ru>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 24 Jun 2006 19:15:31 +0400
Alexey Dobriyan <adobriyan@gmail.com> wrote:

> Immediate problem: from time to time post 2.6.17 kernel [1] decides that it
> really really needs disk.
> 
> 	[kernel compilation goes as usual]
> 	  CC [M]  fs/xfs/xfs_inode.o
> 	[compilation blocks for ~10 seconds, disk LED is red]
> 	[then it continues]
> 
> Again, from time to time saving 2k file makes vi inoperational for same
> period.
> 
> Scheduler is CFQ, fs is reiserfs mounted with noatime, notail. 2.6.17-rc
> and 2.6.17 kernels were OK.
> 
> It occured only several times in 4 hours.
> 
> [1] 2.6.17-95eaa5fa8eb2c345244acd5f65b200b115ae8c65 to be precise
> 
> 
> Probably related problem below:
> 
> During 2.6.17-rc cycle CFQ subjectively became less F.
> 
> 	[   unpacking  ]
> 	[kernel tarball]
> 		.
> 		.
> 		.
> 		.
> 		.
> 		.
> 		.		[:wq on little file]
> 		.
> 		.
> 		.
> 		.
> 		.
> 		.
> 	[              ]
> 
> IIRC, on 2.6.16 that :wq took say 0.5 sec, on late 2.6.17-rc it was
> several times slower. I don't have numbers but it was psychologically
> noticeable, but not BFD.
> 

There have been quite a few CFQ changes.

It'd help if you can come up with a simple test case which others can use
to reproduce this.  Say,

while true
do
	dd if=/dev/zero of=foo bs-1M count=1000 conv=notrunc
done &

versus

time dd if=/dev/zero of=bar bs=16k count=1 conv=fsync

or something like that.

Thanks.
