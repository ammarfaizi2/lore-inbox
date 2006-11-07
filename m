Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754114AbWKGJU6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754114AbWKGJU6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 04:20:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754120AbWKGJU6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 04:20:58 -0500
Received: from emailer.gwdg.de ([134.76.10.24]:36028 "EHLO emailer.gwdg.de")
	by vger.kernel.org with ESMTP id S1754114AbWKGJU5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 04:20:57 -0500
Date: Tue, 7 Nov 2006 10:17:14 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Paul Rolland <rol@as2917.net>
cc: "'Marc Perkel'" <marc@perkel.com>,
       "'Chris Lalancette'" <clalance@redhat.com>,
       "'Rafael J. Wysocki'" <rjw@sisk.pl>, linux-kernel@vger.kernel.org
Subject: RE: could not find filesystem /dev/root
In-Reply-To: <02e401c7023a$fdcce1d0$4b00a8c0@donald>
Message-ID: <Pine.LNX.4.61.0611071013420.11192@yvahk01.tjqt.qr>
References: <02e401c7023a$fdcce1d0$4b00a8c0@donald>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>I also had nearly the same problem when moving from FC5 kernel to a
>stock vanilla kernel : FC5 is heavily relying on modules, and my vanilla
>kernel was compiled with everything built-in and no modules. 
>This is definitely changing the order in which drivers and disks are
>discovered

The order in which disks are discovered, is basically
(1) what module (let's take the "core kernel" as a module too) is loaded 
    first (core kernel always comes first)
(2) running order of the __init functions in a specific module;
    running order mostly defined by linking order

>and resulted in drives changing devices :
>FC5               Vanilla
>/dev/sda   <--->  /dev/sdb
>/dev/sdb   <--->  /dev/sdc
>/dev/sdc   <--->  /dev/sda
>
>This is a real pain, though people will tell you that udev is supposed
>to take care of this... My problem was just that I _don't_ want udev
>on my machine...

If you don't want udev, make an initramfs, build your disk driver as 
modules, and load them in the order you want your disks numbered.

udev or initramfs, you ought to choose at least one.

>So, check also this point...

	-`J'
-- 
