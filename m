Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932398AbWGLVOG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932398AbWGLVOG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 17:14:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932429AbWGLVOG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 17:14:06 -0400
Received: from soundwarez.org ([217.160.171.123]:28560 "EHLO soundwarez.org")
	by vger.kernel.org with ESMTP id S932398AbWGLVOE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 17:14:04 -0400
Subject: Re: [x86_64] strange delays since 2.6.15 (was: Re: ohci1394:
	aborting transmission)
From: Kay Sievers <kay.sievers@vrfy.org>
To: Christian Kujau <evil@g-house.de>
Cc: kay.sievers@suse.de, linux-kernel@vger.kernel.org, gregkh@suse.de
In-Reply-To: <Pine.NEB.4.64.0607122134150.3497@vaio.testbed.de>
References: <Pine.LNX.4.64.0607100527200.10447@sheep.housecafe.de>
	 <44B203F4.1030903@s5r6.in-berlin.de>
	 <Pine.LNX.4.64.0607100852390.13858@sheep.housecafe.de>
	 <44B253CE.3030308@s5r6.in-berlin.de>
	 <Pine.NEB.4.64.0607121247410.2796@vaio.testbed.de>
	 <Pine.NEB.4.64.0607122134150.3497@vaio.testbed.de>
Content-Type: text/plain
Date: Wed, 12 Jul 2006 23:14:08 +0200
Message-Id: <1152738848.3195.32.camel@pim.off.vrfy.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-07-12 at 22:01 +0100, Christian Kujau wrote:
> Hello all,
> 
> I am still having these strange boot-delays which I reported in [0] when 
> I was under the assumption that ohci1394 was to blame, simply because 
> "ohci1394: aborting transmission" was the last message before the 
> 3minute delay during bootup happened. I've found out that the actual 
> problem started way earlier (2.6.14->2.6.15) and I have bisected my way 
> down to this patchset:
> 
> a7fd67062efc5b0fc9a61368c607fa92d1d57f9e is first bad commit
> diff-tree a7fd67062efc5b0fc9a61368c607fa92d1d57f9e (from 
> d8539d81aeee4dbdc0624a798321e822fb2df7ae)
> Author: Kay Sievers <kay.sievers@suse.de>
> Date:   Sat Oct 1 14:49:43 2005 +0200
> 
>      [PATCH] add sysfs attr to re-emit device hotplug event

Looks like a broken udev/system-init setup, which may hang until a
timeout, while it tries to coldplug devices. When you back out the
patch, coldplug will just fail, that's why the behavior is different.

I'm pretty sure, it has nothing to do with this patch itself. You may
want to look in your bootscripts where it hangs, not in the kernel.

Kay

