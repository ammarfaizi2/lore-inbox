Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261896AbUKHRP5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261896AbUKHRP5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 12:15:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261946AbUKHROr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 12:14:47 -0500
Received: from alog0232.analogic.com ([208.224.220.247]:3456 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261896AbUKHQvZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 11:51:25 -0500
Date: Mon, 8 Nov 2004 11:50:20 -0500 (EST)
From: linux-os <linux-os@chaos.analogic.com>
Reply-To: linux-os@analogic.com
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: More linux-2.6.9 module problems
Message-ID: <Pine.LNX.4.61.0411081148520.5510@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I have a memory-test procedure that tests
memory on a board, accessed via the PCI bus.
There is a lot of RAM and it's bank-switched
into some 64k windows so it takes a lot of
time to test, about 60 seconds.

This is in a module, therefore inside the kernel.
When it is invoked via an ioctl() call, the
kernel is frozen for the whole test-time. The
test procedure does not use any spin-locks nor
does it even use any semaphores. It just does a
bunch of read/write operations over the PCI/Bus.

I thought that I could enable the preemptible-
kernel option and the machine would then respond
normally. Not so. Even with 4 CPUs, when one
ioctl() is busy in the kernel, nothing else
happens until its done. Even keyboard activity
is gone, no Caps Lock and no Num Lock, no `ping`
response over the network. However, the machine
comes back to life when the memory-test is done.

This is kernel version 2.6.9. Is it possible that
somebody left on the BKL when calling a module
ioctl() on this version? If not, what do I do
to be able to execute a time-consuming procedure
from inside the kernel? Do I break it up into
sections and execute schedule() periodically
(temporary work-around --works)??

Cheers,
Dick Johnson
Penguin : Linux version 2.6.9 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by John Ashcroft.
                  98.36% of all statistics are fiction.
