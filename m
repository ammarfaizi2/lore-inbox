Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268495AbTGTVjx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jul 2003 17:39:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268564AbTGTVjx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jul 2003 17:39:53 -0400
Received: from adsl-206-170-148-147.dsl.snfc21.pacbell.net ([206.170.148.147]:61188
	"EHLO gw.goop.org") by vger.kernel.org with ESMTP id S268495AbTGTVjw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jul 2003 17:39:52 -0400
Subject: Re: [2.6.0-test1-mm2] unable to mount root fs on unknown-block(0,0)
From: Jeremy Fitzhardinge <jeremy@goop.org>
To: Florian Huber <florian.huber@mnet-online.de>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20030720125547.11466aa4.florian.huber@mnet-online.de>
References: <20030720125547.11466aa4.florian.huber@mnet-online.de>
Content-Type: text/plain
Message-Id: <1058738091.5980.63.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 20 Jul 2003 14:54:52 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-07-20 at 03:55, Florian Huber wrote:
> Hello ML,
> I can't boot my 2.6.0-test1-mm2 kernel (+GCC 3.3). The kernel panics
> at bootime:
> 
> VFS: Cannot open root device "hda3" or unknown-block(0,0)
> Please append a correct "root=" boot option
> Kernel Panic: VFS: Unable to mount root fs on unknown-block(0,0)

I'm getting the same thing, with an ext3 root.  It seems that something
odd is happening in init/do_mounts.c, since from the message it looks
like ROOT_DEV isn't being initialized.  However the mm2 patch doesn't
seem to change anything significant-looking in this directory (just some
headers).  

Hm, on closer inspection, it resolves the device name by mounting sysfs,
rummaging around to see if the device exists and gets its device number
(0301 for hda1) and initializes ROOT_DEV from that.  I wonder if there's
a sysfs/block device breakage which makes the partitions not appear in
sysfs?  Setting root=0303 (in your case) might helps things along.

	J

