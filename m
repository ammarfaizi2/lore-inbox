Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268812AbRG0JyA>; Fri, 27 Jul 2001 05:54:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268811AbRG0Jxu>; Fri, 27 Jul 2001 05:53:50 -0400
Received: from mailhost.tue.nl ([131.155.2.5]:27210 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id <S268814AbRG0Jxk>;
	Fri, 27 Jul 2001 05:53:40 -0400
Message-ID: <20010727115350.A9407@win.tue.nl>
Date: Fri, 27 Jul 2001 11:53:50 +0200
From: Guest section DW <dwguest@win.tue.nl>
To: "J . A . Magallon" <jamagallon@able.es>,
        Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: mount-2.11e bug ?
In-Reply-To: <20010727013138.A4186@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <20010727013138.A4186@werewolf.able.es>; from J . A . Magallon on Fri, Jul 27, 2001 at 01:31:38AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Fri, Jul 27, 2001 at 01:31:38AM +0200, J . A . Magallon wrote:

> Can anybody tell me if there was a bug in mount from util-linux-2.11e that could
> do things like this with new kernels:
> 
> /etc/fstab:
> ...
> tmpfs /dev/shm tmpfs defaults,size=128M 0 0
> ...
> 
> werewolf:~/soft/util/util-linux-2.11e/mount# df
> Filesystem           1k-blocks      Used Available Use% Mounted on
> /dev/sda1               248895     83086    152959  36% /
> /dev/sda2              3099292   2092872    848984  72% /usr
> /dev/sda3              4095488   1603796   2283652  42% /home
> /dev/sda5              1027768         8    975552   1% /toast
> /home/soft/util/util-linux-2.11e/mount/tmpfs
>                         131072         0    131072   0% /dev/shm
> 
> 2.11h works ok.

Yes, there was.

Mount does a canonicalize() on the path names of device and mount point.
Thus, tmpfs when your current directory is ~/soft/util/util-linux-2.11e/mount
becomes /home/soft/util/util-linux-2.11e/mount/tmpfs.

However, this only happens when the thus obtained pathname points at an
actual file. In a few mount versions the realpath() routine also did this
when there is no such file.

Andries
