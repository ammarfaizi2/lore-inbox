Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262664AbSKYSXi>; Mon, 25 Nov 2002 13:23:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262780AbSKYSXi>; Mon, 25 Nov 2002 13:23:38 -0500
Received: from sullivan.realtime.net ([205.238.132.76]:51473 "EHLO
	sullivan.realtime.net") by vger.kernel.org with ESMTP
	id <S262664AbSKYSXh>; Mon, 25 Nov 2002 13:23:37 -0500
Date: Mon, 25 Nov 2002 12:30:46 -0600 (CST)
Message-Id: <200211251830.gAPIUkZ90395@sullivan.realtime.net>
To: Helge Hafting <helgehaf@aitel.hist.no>
From: Milton Miller <miltonm@bga.com>
Subject: Re: [PATCH] make 2.5.49 mount root again for devfs users
In-Reply-To: <3DE21B96.8BA15D27@aitel.hist.no>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

What you did was bypass devfs, and cause create_dev to mknod a file
with the device number of your root instead of creating a symlink
to the normal devfs node.

Is your booter translating the device name into a number?  You can
check this by looking at the printed comand line in the dmesg, or
by cat /proc/cmdline .

If you see root=0304 then your booter is translating the device number
and therefore find_in_devfs is failing (possibly because of the previously
metioned patch to read_dir).

I notice that there are lots of hardcoded maxdepth of 64 characters for
the devfs path, but yours seems to be 39 and therefore should be ok.

milton
