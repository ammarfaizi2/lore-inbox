Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262288AbVAZNU6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262288AbVAZNU6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jan 2005 08:20:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262289AbVAZNU5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jan 2005 08:20:57 -0500
Received: from stud4.tuwien.ac.at ([193.170.75.14]:34003 "EHLO
	stud4.tuwien.ac.at") by vger.kernel.org with ESMTP id S262288AbVAZNUw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jan 2005 08:20:52 -0500
Date: Wed, 26 Jan 2005 14:20:47 +0100
From: Martin =?iso-8859-15?Q?K=F6gler?= <e9925248@student.tuwien.ac.at>
To: linux-kernel@vger.kernel.org
Subject: Deadlock in serial driver 2.6.x
Message-ID: <20050126132047.GA2713@stud4.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I noticed with different kernel versions (a 2.6.5 FC2 Kernel, a 2.6.7 Knoppix Kernel
and 2.6.10 FC2 and FC3 Kernels (which have no patches for the serial driver)), that it 
is possible for a normal user, which has rw access to /dev/ttySx, to hang a computer.
To exploit it, there must be a device on the other end on the serial line, which sends 
some data.

I tested it on a i686 machine.

At http://www.auto.tuwien.ac.at/~mkoegler/linux/serial_oops.c , I have an example programm,
which exploits the problem (/dev/ttyS0 is hardcoded as serial device).

To trigger the problem, connect two computers with a null modem cable and send some
characters to the programm (The baud rate at the other computer seems to be not important).

With SMP-Kernels, the computer stops responding.
Kernels without SMP print a panic message before they stop working, eg:
Kernel panic - not syncing: drivers/serial/serial_core.c:103: spin_lock(drivers/serial/serial_core.c:c04055e0) already locked  by drivers/serial/8250.c/1170

Photos of a panic messages of a FC3 2.6.10-1.741_FC3 Kernel are available at 
http://www.auto.tuwien.ac.at/~mkoegler/linux .

What the programm does:
It sets the low latency mode, then waiting, until a certain state of the handshake 
lines is reached, then it sends a bytes and waits for a byte. Then it changes the 
handshake lines again and the process starts again.

Martin Kögler
e9925248@stud4.tuwien.ac.at
PS: Please CC me on replies.
