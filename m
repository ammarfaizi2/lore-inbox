Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261880AbULPLsM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261880AbULPLsM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 06:48:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261925AbULPLsM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 06:48:12 -0500
Received: from bay23-f32.bay23.hotmail.com ([64.4.22.82]:29306 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S261880AbULPLsH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 06:48:07 -0500
Message-ID: <BAY23-F321730E4EE170D8D922075C4AE0@phx.gbl>
X-Originating-IP: [212.143.127.195]
X-Originating-Email: [dankaspi@hotmail.com]
From: "Dan Kaspi" <dankaspi@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: Initrd entry in grub.conf and loading initrd in the kernel code
Date: Thu, 16 Dec 2004 13:47:29 +0200
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
X-OriginalArrivalTime: 16 Dec 2004 11:48:05.0765 (UTC) FILETIME=[1B03C350:01C4E365]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I tried to understand the correlarion between initrd in grub.conf and the
call to initrd_load() in the kernel (under init subtree).
My question is : when we do not use initrd in grub (meaning there is no
entry for initrd in grub.conf), does the kernel still calls load_initrd()?
Or does it sets somehow the mount_initrd variable to false ? if so - how ?

Grepping the kernel for no_initrd() shows that do_mounts_initrd.c is the
only
"C" file where this method definition appears.
Does it have to do with the _setup call in this file : __setup("noinitrd",
no_initrd) ?

I did not see initrd it in the kernel command line:
When I run cat /proc/cmdline to see the kernel command line,
I do not see any mention of initrd (thoughin my grub.conf I DO USE initrd ).
What I see is:
ro root=/dev/hda3 hdb=none hdc=none hdd=none

Trying to understand the code raise some confusion (as is depicted below)
So I hope maybe one of the Mulixes knows something about it.

I had looked at 2.6.7 kernel.
what I see (under init subtree):

There is a variable named "mount_initrd" which is initialized to true (1)
in do_mounts_initrd.c

The initrd_load() method (also in do_mounts_initrd.c) checks this variable
and
if it is true it performs the load initrd process (creates /dev/ram0 and
loads
the initrd data into it by calling rd_load_image() ).

There is a method named no_initrd() in this file which sets mount_initrd to
0.
there is also a call to __setup("noinitrd", no_initrd);
(This macro calls __setup_param() in init.h ; it says there that it is
OBSOLOETE
and send us to moduleparam.h.)

Regards,
Dan

_________________________________________________________________
Express yourself instantly with MSN Messenger! Download today it's FREE! 
http://messenger.msn.click-url.com/go/onm00200471ave/direct/01/

