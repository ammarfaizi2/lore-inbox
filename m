Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261245AbVAaQWL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261245AbVAaQWL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 11:22:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261251AbVAaQWL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 11:22:11 -0500
Received: from lana.hrz.tu-chemnitz.de ([134.109.132.3]:6033 "EHLO
	lana.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id S261245AbVAaQWD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 11:22:03 -0500
Date: Mon, 31 Jan 2005 17:22:02 +0100
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: 2.6.11-rc2 hangs on bridge shutdown (br0)
Message-ID: <20050131162201.GA1000@stilzchen.informatik.tu-chemnitz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
From: Mirko Parthey <mirko.parthey@informatik.tu-chemnitz.de>
X-Scan-Signature: 6c4dba1e91403f6684caf61b693d4145
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My Debian machine hangs during shutdown, with messages like this:
unregister_netdevice: waiting for br0 to become free. Usage count = 1

I narrowed it down to the command
  # brctl delbr br0
which does not return in the circumstances shown below.

The problem is reproducible with both 2.6.11-rc2 from kernel.org and the
Debian kernel-image-2.6.10-1-686.

My .config is taken from the above mentioned Debian kernel, adapted to
2.6.11-rc2 and the processor type set to Pentium Classic. (I can email
the .config on request).

How to reproduce the problem (I tried this on a Pentium 4 machine):

boot: linux init=/bin/bash
[...booting...]
# mount proc -t proc /proc
# ifconfig lo 127.0.0.1
# brctl addbr br0
# modprobe e100           # also reproducible with 3c5x9
# brctl addif br0 eth0
# ifconfig br0 192.168.1.1
# ifconfig eth0 up
# ifconfig lo down
# lsmod | grep bridge
bridge                 48888  0
# brctl delif br0 eth0
# ifconfig br0 down
# brctl delbr br0
unregister_netdevice: waiting for br0 to become free. Usage count = 1
unregister_netdevice: waiting for br0 to become free. Usage count = 1
[...this message again and again, but no progress...]

I'm also surprised that the reference count for the bridge module is
zero, even when it is in use.

Please let me know if you need any further information,
and please Cc me on replies (I am not subscribed to linux-kernel).

Thanks,
Mirko
