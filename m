Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030292AbWBNAxG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030292AbWBNAxG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 19:53:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030313AbWBNAxG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 19:53:06 -0500
Received: from smtp.osdl.org ([65.172.181.4]:45264 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030292AbWBNAxF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 19:53:05 -0500
Date: Mon, 13 Feb 2006 16:51:59 -0800
From: Andrew Morton <akpm@osdl.org>
To: Alexandre Buisse <nattfodd@gentoo.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-rc2-mm1
Message-Id: <20060213165159.28710ebf.akpm@osdl.org>
In-Reply-To: <20060214005701.GA26814@ubik>
References: <20060207220627.345107c3.akpm@osdl.org>
	<20060214005701.GA26814@ubik>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexandre Buisse <nattfodd@gentoo.org> wrote:
>
> On Tue, Feb 14, 2006 at 00:47:15 +0100, Andrew Morton wrote:
> 
> > 
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16-rc2/2.6.16-rc2-mm1/
> > 
> 
> Hi,
> 
> I have been using 2.6.16-rc2-mm1 for a couple of days on my laptop and
> tonight it was particularly slow. After shutting down firefox, X and
> pretty much every user application, free was still saying:
> 
> ubik:~> free -l
>              total       used       free     shared    buffers
>              cached
>              Mem:        508592     502948       5644          0
>              7056      25084
>              Low:        508592     502948       5644
>              High:            0          0          0
>              -/+ buffers/cache:     470808      37784
>              Swap:       506512      86260     420252
> 
> 
> ps is almost empty, but /proc/slabinfo (see attached file for the
> complete output) has some weird lines:
> 
> sock_inode_cache  644184 644202    448    9    1 : tunables   54   27 0 : slabdata  71578  71578      0
> 
> inode_cache         1216   1232    360   11    1 : tunables   54   27 0 : slabdata    112    112      0 : shrinker stat 2103424 2101400
> dentry_cache      647419 649830    128   30    1 : tunables  120   60 0 : slabdata  21661  21661      0 : shrinker stat 5027712 2374200
> 
> 

Well it _could_ be caused by an errant application.  But if it just started
happening, it's more likely the kernel.  There are related changes in
Dave's tree.

You could try `echo 3 > /proc/sys/vm/drop_caches' to see if they're
reclaimable.

