Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269506AbUINTdB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269506AbUINTdB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 15:33:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269726AbUINT3U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 15:29:20 -0400
Received: from prime.hereintown.net ([141.157.132.3]:22417 "EHLO
	prime.hereintown.net") by vger.kernel.org with ESMTP
	id S269703AbUINT2a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 15:28:30 -0400
Subject: Re: udev is too slow creating devices
From: Chris Meadors <clubneon@hereintown.net>
To: "Giacomo A. Catenazzi" <cate@debian.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <41473972.8010104@debian.org>
References: <41473972.8010104@debian.org>
Content-Type: text/plain
Message-Id: <1095189661.7483.7.camel@clubneon.priv.hereintown.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.5.6.2 
Date: Tue, 14 Sep 2004 15:21:01 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-09-14 at 20:33 +0200, Giacomo A. Catenazzi wrote:
> Hello people!
> 
> When I load a module (with modprobe) the relative device is too
> slowly created with udev, so modprobe return before the device
> is really created. Because of this my init.d script will
> fail with modular microcode + udev
> 
> test case:
> 
> udev + modular microcode:
> $ modprobe -r microcode
> $ modprobe microcode ; microcode_ctl -u
> => microcode_ctl does NOT find the device
> 
> $ modprobe -r microcode
> $ modprobe microcode ; sleep 3; microcode_ctl -u
> => microcode_ctl FIND the device
> 
> [without udev it is OK, so I assume no errors
> in modprobe]
> 
> Is it a bug of udev?
> Else what workaround I can use? (sleep is to slow for
> an already to sloow system initialitation)

I don't know of a proper fix, but a better work around would be to
use...

while [ ! -c /dev/cpu/microcode ]; do sleep 0; done

...in place of your "sleep 3".  Replacing the /dev/cpu/microcode with
the actual character device that microcode_ctl is looking for.

-- 
Chris

