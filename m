Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272282AbTG3Vaf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 17:30:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272260AbTG3V2D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 17:28:03 -0400
Received: from numenor.qualcomm.com ([129.46.51.58]:32477 "EHLO
	numenor.qualcomm.com") by vger.kernel.org with ESMTP
	id S272276AbTG3V0l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 17:26:41 -0400
Message-Id: <5.1.0.14.2.20030730140614.01ce0a98@unixmail.qualcomm.com>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Wed, 30 Jul 2003 14:25:49 -0700
To: "Dave O" <cxreg@pobox.com>, linux-kernel@vger.kernel.org
From: Max Krasnyansky <maxk@qualcomm.com>
Subject: Re: Oops from tun module
In-Reply-To: <34018.204.17.42.117.1059505497.squirrel@www.genericorp.net
 >
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 12:04 PM 7/29/2003, Dave O wrote:
>I added a tun/tap interface using tunctl(8) from the user-mode-linux
>project under 2.6.0-test1, which created a device tap0, owned by user 1000
>(tunctl -u 1000).  In doing so, the tun module was automatically loaded,
>but showed a refcount of 0 in lsmod.  I was able to successfully "rmmod
>tun", but after doing this every program that tried to open /proc/net/dev
>(including ifconfig) immediately segfaults and causes an Oops.  I was able
>to modprobe tun.o back in and that restored sane behavior.  I imagine the
>module should have had it's refcount incremented when the device is
>created.

TUN/TAP driver relies on the network core to do module reference counting. 
It doesn't really do any cleanup in module_exit(). Module refcounting was 
recently removed from the network core which apparently broke TUN/TAP 
driver. btw 'misc' driver doesn't do any ref counting either.
I'll try to spend some time on it this week and fix both misc and TUN driver.

Max


