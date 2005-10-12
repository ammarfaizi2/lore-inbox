Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932129AbVJLIax@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932129AbVJLIax (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Oct 2005 04:30:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932396AbVJLIax
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Oct 2005 04:30:53 -0400
Received: from mail6.hitachi.co.jp ([133.145.228.41]:32500 "EHLO
	mail6.hitachi.co.jp") by vger.kernel.org with ESMTP id S932129AbVJLIaw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Oct 2005 04:30:52 -0400
Date: Wed, 12 Oct 2005 17:30:43 +0900 (JST)
Message-Id: <20051012.173043.41629248.noboru.obata.ar@hitachi.com>
To: hyoshiok@miraclelinux.com, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux Kernel Dump Summit 2005
From: OBATA Noboru <noboru.obata.ar@hitachi.com>
In-Reply-To: <20051011.134103.02441615.hyoshiok@miraclelinux.com>
References: <20051011.134103.02441615.hyoshiok@miraclelinux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Oct 2005, Hiro Yoshioka wrote:
> 
> The reasons are
> 1) They have to maintain the dump tools and support their users.
>    Many users are still using 2.4 kernels so merging kdump into 2.6
>    kernel does not help them.
> 2) Commercial Linux Distros (Red Hat/Suse/MIRACLE(Asianux)/Turbo etc) use
>    LKCD/diskdump/netdump etc.
>    Almost no users use a vanilla kernel so kdump does not have users yet.

Agreed.

I am testing (or tasting ;-) kdump myself, and find it really
impressive and promising.  Thank you all who have worked on.

In term of users, however, the majority of commercial users
still use 2.4 kernels of commercial Linux distributions.  This
is especially true for careful users who have large systems
because switching to 2.6 kernels without regression is not an
easy task.  So merging kdump into the mainline kernel does not
directly mean that these users start using it now.

Rather, merging kdump has much meaning for commercial Linux
distributors, who should be planning how and when to include
kdump in their distros.

> > Is that a correct impression?  If so, what shortcoming(s) in kdump are
> > causing people to be reluctant to use it?
> 
> I think the way to go is the kdump however it may take time.

Agreed.

I'd say commercial users are not reluctant to use kdump, but
they are just waiting for kdump-ready distros.  So in turn, we
still have some time left for improving kdump further before
kdump-ready distros are shipped to users, and I would like to be
involved in such improvement hereafter.

Thinking about the requirements in enterprise systems,
challenges of kdump will be:

  - Reliability
    + Hardware-related issues

  - Manageability
    + Easy configuration
    + Automated dump-capture and restart
    + Time and space for capturing dump
    + Handling two kernels

  - Flexibility
    + Hook points before booting the 2nd kernel

My short impressions follow.  I understand that kdump/kexec
developers are already discussing and working on some issues
above, and I am grateful if someone tell me about the current
status, or point me to the past lkml threads.


Reliability
-----------

In terms of reliability, hardware-related issues, such as a
device reinitialization problem, an ongoing DMA problem, and
possibly a pending interrupts problem, must be carefully
resolved.

Manageability
-------------

As for manageability, it is nice if a user can easily setup
kdump just by writing DEVICE=/dev/sdc6 to one's
/etc/sysconfig/kdump and start the kdump service, for example.
It is also desirable that an action taken after capturing a dump
(halt, reboot, or poweroff) is configurable.  I believe these are
userspace tasks.

Time and space problem in capturing huge crash dump is raised
already.  The partial dump and dump compress technology must be
explored.

One of my worries is that the current kdump requires distinct
two kernels (one for normal use, and one for capturing dumps) to
work.  And I'm not fully convinced whether a use of two kernels
is the only solution or not.  Well, I heard that this decision
better solves the ongoing DMA problem (please correct me if
other reasons are prominent), but from a pure management point
of view handing one kernel is happier than two kernels.

Flexibility
-----------

To minimize the downtime, a crashed kernel would want to
communicate with clustering software/firmware to help it detect
the failure quickly.  This can be generalized by making
appropriate hook points (or notifier lists) in kdump.

Perhaps these hooks can be used to try reseting devices when
reinitialization of devices in the 2nd kernel tends to fail.


Sorry if I'm bringing up the already discussed issues again, but
I believe that addressing above issues will help the commercial
users in the future, and so I would like to discuss them again
how these issues can be addressed.

Regards,

-- 
OBATA Noboru (noboru.obata.ar@hitachi.com)

