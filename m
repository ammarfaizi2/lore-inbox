Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317852AbSFSLcf>; Wed, 19 Jun 2002 07:32:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317853AbSFSLce>; Wed, 19 Jun 2002 07:32:34 -0400
Received: from mailhost.tue.nl ([131.155.2.5]:63352 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id <S317852AbSFSLce>;
	Wed, 19 Jun 2002 07:32:34 -0400
Date: Wed, 19 Jun 2002 13:32:33 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Dave Jones <davej@suse.de>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: /proc/partitions broken in 2.5.23
Message-ID: <20020619113233.GA15730@win.tue.nl>
References: <20020619090248.GA8681@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020619090248.GA8681@suse.de>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 19, 2002 at 10:02:48AM +0100, Dave Jones wrote:

> I got a bug report about an issue with LVM in 2.5.22-dj1, which turns
> out to be caused by broken /proc/partitions in mainline.
> 
> (davej@mesh:davej)$ cat /proc/partitions 
> major minor  #blocks  name
> 
>    8     0          0 sda
>   22     0 1515870810 hdc
>   22    64 1515870810 hdd
>    3     0   29316672 hda
>    3     1     117400 hda1
>    3     2          1 hda2
>    3     5     999904 hda5
>    3     6    1499872 hda6
>    3     7     683392 hda7
>    3     8   26015944 hda8
>    3    64 1515870810 hdb
> 
> Note the huge numbers in hex are 0x5a5a5a5a, so something
> seems to be getting poisoned somewhere.
> 
> Also, should partitions with 0 blocks be showing up ?
> I don't recall that happening with the old-style 2.4 code.

I changed something here a few weeks ago. The idea was to avoid
listing partitions of size 0 but do list full devices, regardless
of size. Especially in case of removable media that is useful.
For example, a
	blockdev --rereadpt /dev/sda
might show that there is something there now.

Will look at what might cause your strange numbers. Unfortunately
recent 2.5 kernels do not boot for me.

Andries
