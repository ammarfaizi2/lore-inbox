Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261935AbUK0Gey@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261935AbUK0Gey (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Nov 2004 01:34:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261893AbUK0Gcc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Nov 2004 01:32:32 -0500
Received: from dev.tequila.jp ([128.121.50.153]:18451 "EHLO dev.tequila.jp")
	by vger.kernel.org with ESMTP id S261942AbUK0G3E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Nov 2004 01:29:04 -0500
Message-ID: <41A81E82.8090809@tequila.co.jp>
Date: Sat, 27 Nov 2004 15:28:18 +0900
From: Clemens Schwaighofer <cs@tequila.co.jp>
Organization: TEQUILA\Japan
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041124 Thunderbird/0.9 Mnenhy/0.6.0.104
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: FireWire DVD-R ... a never ending story
X-Enigmail-Version: 0.89.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi,

I have got a Laptop and attached to it are three firewire devices, two
HDs and one DVD writer (last in chain).

Right now I am running 2.6.10-rc1-mm5 on a debian/unstable.

I started with this situation.

Laptop
  |
HD [on]
  |
HD [on]
  |
DVD-R [off]

I turn the DVD-R on, I start k3b, I can see & write dvd-Rs.

Something happnes (perhaps my dvd-r is broken), but I turned it off, and
on again and it doesn't get recognized again, more, all Firewire traffic
is blocked.

I reboot this time the dvd-r is on, but after the reboot the dvd-r
doesn't get recognized. So I turn it off. Reboot and afterwards turn it
on. It gets recognized.

Now I play around and turn it on and off a view times until this happend
[dmesg see below]. After this oops, no more access to the two other hard
disks.

I can't test the dvd-r anymore, because I think its broken (today just
crap is sold, two years old and its broken already!)

ieee1394: Error parsing configrom for node 0-00:1023
ieee1394: Error parsing configrom for node 0-01:1023
ieee1394: Error parsing configrom for node 0-02:1023
ieee1394: Error parsing configrom for node 0-03:1023
ieee1394: The root node is not cycle master capable; selecting a new
root node and resetting...
ieee1394: Node resumed: ID:BUS[0-00:1023]  GUID[00e03600500008f2]
ieee1394: Node changed: 0-00:1023 -> 0-01:1023
ieee1394: Node changed: 0-01:1023 -> 0-02:1023
ieee1394: Node changed: 0-02:1023 -> 0-03:1023
ieee1394: sbp2: Error reconnecting to SBP-2 device - reconnect failed
ieee1394: sbp2: Logged out of SBP-2 device
ieee1394: sbp2: Logged into SBP-2 device
ieee1394: Node 0-02:1023: Max speed [S400] - Max payload [2048]
ieee1394: sbp2: Error reconnecting to SBP-2 device - reconnect failed
ieee1394: sbp2: Logged out of SBP-2 device
ieee1394: sbp2: Logged into SBP-2 device
ieee1394: Node 0-01:1023: Max speed [S400] - Max payload [2048]
ieee1394: Node changed: 0-01:1023 -> 0-00:1023
ieee1394: Node changed: 0-02:1023 -> 0-01:1023
ieee1394: Node changed: 0-03:1023 -> 0-02:1023
ieee1394: Reconnected to SBP-2 device
ieee1394: Node 0-01:1023: Max speed [S400] - Max payload [2048]
ieee1394: Node suspended: ID:BUS[0-00:1023]  GUID[00e03600500008f2]
ieee1394: Reconnected to SBP-2 device
ieee1394: Node 0-00:1023: Max speed [S400] - Max payload [2048]
ieee1394: Error parsing configrom for node 0-00:1023
ieee1394: Error parsing configrom for node 0-01:1023
ieee1394: Error parsing configrom for node 0-02:1023
ieee1394: Error parsing configrom for node 0-03:1023
ieee1394: Node suspended: ID:BUS[0-02:1023]  GUID[08004603011109a9]
ieee1394: Node suspended: ID:BUS[0-01:1023]  GUID[0010b920003d932d]
 target1:0:1: Illegal state transition <NULL>->cancel
Badness in scsi_device_set_state at drivers/scsi/scsi_lib.c:1713
 [<c02f28a3>] scsi_device_set_state+0xc4/0x122
 [<c02edb1c>] scsi_device_cancel+0x27/0x10e
 [<c02edc61>] scsi_device_cancel_cb+0x0/0x1c
 [<c02bfd6c>] device_for_each_child+0x3d/0x69
 [<c02edcad>] scsi_host_cancel+0x30/0xbb
 [<c02edc61>] scsi_device_cancel_cb+0x0/0x1c
 [<c02573d5>] kobject_put+0x1e/0x22
 [<c02573ad>] kobject_release+0x0/0xa
 [<c02f4d47>] scsi_remove_device+0x7c/0xad
 [<c02f3f62>] scsi_forget_host+0x79/0xa2
 [<c02edd5b>] scsi_remove_host+0x23/0x71
 [<c0314716>] sbp2_remove_device+0x1dd/0x1f6
 [<c0313ead>] sbp2_remove+0x24/0x2e
 [<c02c0b85>] device_release_driver+0x7f/0x81
 [<c030669c>] nodemgr_suspend_ne+0xeb/0x111
 [<c03068e7>] nodemgr_probe_ne+0x6a/0x9e
 [<c0306969>] nodemgr_node_probe+0x4e/0x95
 [<c0306d01>] nodemgr_host_thread+0x159/0x174
 [<c0306ba8>] nodemgr_host_thread+0x0/0x174
 [<c010227d>] kernel_thread_helper+0x5/0xb
Unable to handle kernel paging request at virtual address 62363763
 printing eip:
c02edb2f
*pde = 00000000
Oops: 0000 [#1]
PREEMPT
Modules linked in: snd_intel8x0m ntfs
CPU:    0
EIP:    0060:[<c02edb2f>]    Not tainted VLI
EFLAGS: 00010013   (2.6.10-rc1-mm5)
EIP is at scsi_device_cancel+0x3a/0x10e
eax: 00000001   ebx: c1647880   ecx: 00000001   edx: 62363763
esi: 62363753   edi: dfd0fe80   ebp: 00000286   esp: dfd0fe78
ds: 007b   es: 007b   ss: 0068
Process knodemgrd_0 (pid: 860, threadinfo=dfd0f000 task=dfcc8550)
Stack: c1647880 00000003 dfd0fe80 dfd0fe80 c1647a04 dfc050cc c05188e8
c02edc61
       c02bfd6c c1647880 00000000 dfc05000 dfc05000 c051d04c dfd22240
c02edcad
       dfc050b4 dfd0ff18 c02edc61 dfdd55c0 dfdd5400 dfdd5584 c02573d5
dfdd55c0
Call Trace:
 [<c02edc61>] scsi_device_cancel_cb+0x0/0x1c
 [<c02bfd6c>] device_for_each_child+0x3d/0x69
 [<c02edcad>] scsi_host_cancel+0x30/0xbb
 [<c02edc61>] scsi_device_cancel_cb+0x0/0x1c
 [<c02573d5>] kobject_put+0x1e/0x22
 [<c02573ad>] kobject_release+0x0/0xa
 [<c02f4d47>] scsi_remove_device+0x7c/0xad
 [<c02f3f62>] scsi_forget_host+0x79/0xa2
 [<c02edd5b>] scsi_remove_host+0x23/0x71
 [<c0314716>] sbp2_remove_device+0x1dd/0x1f6
 [<c0313ead>] sbp2_remove+0x24/0x2e
 [<c02c0b85>] device_release_driver+0x7f/0x81
 [<c030669c>] nodemgr_suspend_ne+0xeb/0x111
 [<c03068e7>] nodemgr_probe_ne+0x6a/0x9e
 [<c0306969>] nodemgr_node_probe+0x4e/0x95
 [<c0306d01>] nodemgr_host_thread+0x159/0x174
 [<c0306ba8>] nodemgr_host_thread+0x0/0x174
 [<c010227d>] kernel_thread_helper+0x5/0xb
Code: c7 44 24 04 03 00 00 00 89 7c 24 08 89 7c 24 0c 89 1c 24 e8 c3 4c
00 00 9c 5d fa b8 01 00 00 00 e8 4f be e2 ff 8b 53 1c 8d 72 f0 <8b> 46
10 0f 18 00 90 83 c3 1c 39 da 74 31 8b 86 b8 00 00 00 85
 <6>note: knodemgrd_0[860] exited with preempt_count 1
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBqB6BjBz/yQjBxz8RAi/QAJ9oEkqI/EWUR3rxfPsEPhWNhzFh5QCffIaw
adI5MZ6IN3c3HeTjmbU4LNY=
=iJJo
-----END PGP SIGNATURE-----
