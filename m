Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261155AbVF0L5W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261155AbVF0L5W (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 07:57:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261157AbVF0L5W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 07:57:22 -0400
Received: from unthought.net ([212.97.129.88]:29371 "EHLO unthought.net")
	by vger.kernel.org with ESMTP id S261155AbVF0L5R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 07:57:17 -0400
Date: Mon, 27 Jun 2005 13:57:16 +0200
From: Jakob Oestergaard <jakob@unthought.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: dm-mirror/kmirrord oops
Message-ID: <20050627115716.GH422@unthought.net>
Mail-Followup-To: Jakob Oestergaard <jakob@unthought.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20050627070709.GA9169@adren.mine.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050627070709.GA9169@adren.mine.nu>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 27, 2005 at 09:07:09AM +0200, Cyril Chaboisseau wrote:
> I just had a big problem lately when I wanted to migrate my PV from one
> disk to another
> 
> to do so, I first created a LVM partition on my second disk,
> 
> then I initialized the partition (pvcreate)
> # pvcreate /dev/sdb1
> 
> I extended my vg to the newly PV
> # vgextend vg /dev/sdb1
> 
> and then I tried to move the data from the old PV to the newly created
> # pvmove -v /dev/sda4 /dev/sdb1
> 
> everything went fine for maybe half an hour, but at 21% it froze

Is your root filesystem mounted on an LV in 'vg' ?

As far as I know, this is a known problem - you cannot pvmove your root
filesystem.

But on another note; you should not have your root (or at least /etc)
filesystem on LVM - because the LVM backup/recovery files are written
there, and if LVM screws up completely, you'll then have no way of
recovering (since the recovery files you need to get LVM going are
stored via. LVM).

I always create a partition for / and keep /boot, /sbin, /lib and /etc
there.

Then, I create another partition and make it a PV, put /var, /usr and
everything else on LVM.

That way I can pvmove anything without running into the bug you
(probably) saw, and I will be able to recover the LVM in case it screws
up (which I haven't seen yet).

-- 

 / jakob

