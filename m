Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262198AbTJFTGP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Oct 2003 15:06:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262127AbTJFTFW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Oct 2003 15:05:22 -0400
Received: from leon.mat.uni.torun.pl ([158.75.2.17]:18358 "EHLO
	Leon.mat.uni.torun.pl") by vger.kernel.org with ESMTP
	id S262126AbTJFTEr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Oct 2003 15:04:47 -0400
Date: Mon, 6 Oct 2003 21:04:30 +0200 (CEST)
From: Krzysztof Benedyczak <golbi@mat.uni.torun.pl>
X-X-Sender: golbi@ultra60
To: Manfred Spraul <manfred@colorfullife.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Michal Wronski <wrona@mat.uni.torun.pl>
Subject: Re: POSIX message queues
In-Reply-To: <3F7FEE6F.9050601@colorfullife.com>
Message-ID: <Pine.GSO.4.58.0310062029590.20893@ultra60>
References: <Pine.GSO.4.58.0310051047560.12323@ultra60> <3F7FEE6F.9050601@colorfullife.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 5 Oct 2003, Manfred Spraul wrote:

> Krzysiek: What is MQ_IOC_CLOSE? It looks like a stale ioctl. Please
> remove such code from the patch.
It is used. If this ioctl will succeed we know that it was done on mqueue
fs file. And thanks to it we get rid of the possibility of closing
ordinary file descriptor with mq_close().

 >
> The last time I looked at your patch I noticed a race between creation
> and setting queue attributes. Did you fix that?
Yes - as Alan Cox suggested. But see below.


> I personally prefer syscalls, but that's just my personal preference.
In our opinion also - and that was the reason why we initially had done
this with syscall. But this was criticized. Mostly but Christopher Hellwig
AFAIR. So we changed it ;-) ... Anyway:

Removing ioctls has mostly advantages (maybe except checking for
permissions) and it's simply. Reusing code of msg_load/free/store - also
no problem. Third issue is filesystem. IMHO removing it from userspace is
unnecessary. It gives a lot of valuable informations (about
notifications which can't be gather with POSIX calls). It is also
convenient to rm queue to poll it.
The things I think should be changed:
mqueues should be be accessible from the module init time
touch can create queue with system limits (?)
multiple mounts of mqueue fs should show the same content.

With this functionality we will have some more convenient queues.
Is it sensible?

(
Implementing with syscalls will also solve proc/mounts dependency (which
BTW can be turned of in library configure).
)


Regards
Krzysiek
