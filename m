Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261260AbVFNGzz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261260AbVFNGzz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Jun 2005 02:55:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261268AbVFNGzz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Jun 2005 02:55:55 -0400
Received: from [151.38.19.110] ([151.38.19.110]:14771 "HELO develer.com")
	by vger.kernel.org with SMTP id S261260AbVFNGzr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Jun 2005 02:55:47 -0400
Message-ID: <42AE7F5C.3000209@develer.com>
Date: Tue, 14 Jun 2005 08:55:24 +0200
From: Bernardo Innocenti <bernie@develer.com>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Audit / Netlink slowness
X-Enigmail-Version: 0.91.0.0
OpenPGP: id=FC6A66CA;
	url=https://www.develer.com/~bernie/gpgkey.txt
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

on a server running kernel 2.6.11-1.1369_FC4, both ssh
and su where taking a longish amount of time (over >1.5 sec.)

Running "strace -r 2>strace.out su", I discovered that
netlink communication is the major cause of slowdown.

"su" connects to a NETLINK_AUDIT socket 3 or 4 times.
Each time it does 2 sendto() + recvfrom() operations,
with a latency of ~200ms.  This adds up to 800ms wasted
time.

Disabling CONFIG_AUDIT in the kernel makes su and ssh
very fast again.

Is this behavior to be expected?  CONFIG_AUDIT is enabled
by default in FC4, so many people are going to be hit by
this problem.

Please Cc me in replies as I'm not subrscribed to the lkml.

-- 
  // Bernardo Innocenti - Develer S.r.l., R&D dept.
\X/  http://www.develer.com/

