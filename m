Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262021AbVBUQmO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262021AbVBUQmO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Feb 2005 11:42:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262033AbVBUQmN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Feb 2005 11:42:13 -0500
Received: from laas.laas.fr ([140.93.0.15]:16822 "EHLO laas.laas.fr")
	by vger.kernel.org with ESMTP id S262021AbVBUQmK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Feb 2005 11:42:10 -0500
Message-ID: <421A0F60.60005@laas.fr>
Date: Mon, 21 Feb 2005 17:42:08 +0100
From: Matthieu Herrb <matthieu.herrb@laas.fr>
Organization: CNRS/LAAS
User-Agent: Mozilla Thunderbird 0.9 (X11/20041127)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: rocketport driver problems in 2.6.10
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0 () 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm experimenting problems with the rocket driver with a Comtrol 
Rocketprot ISA board, under Fedora Core 3 with a 2.6.10 kernel.
(Linux dala 2.6.10-1.766_FC3 #1 Wed Feb 9 23:06:42 EST 2005 i686 i686 
i386 GNU/Linux)

I have a multi-threaded application that opens 2 ports on the rocketport 
card, and happily talks to both devices connected to these ports.

But when I quit the application, the close on the last port leaves the 
thread that called close() and the rocket kernel module in a strange 
state: the thread changes between 'D' state with a wait channel of 
'release_dev' and running. It can't be killed. Lsof doesn't show the 
device as open anymore. Any try to open the device again fails with 
errno == EIO.
lsmod shows the kernel module used by 1 client, and I can't rmmod it.

Only a reboot can free the device and let me work further.

When I only use one device on the rocketport per process, everything is 
ok (or seems ok).

Any idea(s) on how to debug/fix that ?

-- 
Matthieu Herrb
