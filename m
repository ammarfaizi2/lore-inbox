Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261481AbVA1Qs4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261481AbVA1Qs4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jan 2005 11:48:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261478AbVA1Qsx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jan 2005 11:48:53 -0500
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:21437 "EHLO
	faui03.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S261481AbVA1QsN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jan 2005 11:48:13 -0500
Date: Fri, 28 Jan 2005 17:48:11 +0100
From: Michael Gernoth <simigern@stud.uni-erlangen.de>
To: linux-kernel@vger.kernel.org
Cc: Matthias Koerber <simakoer@stud.informatik.uni-erlangen.de>
Subject: 2.4.29, e100 and a WOL packet causes keventd going mad
Message-ID: <20050128164811.GA8022@cip.informatik.uni-erlangen.de>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Matthias Koerber <simakoer@cip.informatik.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

we have about 70 P4 uniprocessor machines (some with Hyperthreading
capable CPUs) running linux 2.4.29, which are woken up on the weekdays
by sending a WOL packet to them. The machines all have a E100 nic with
WOL enabled in the bios. The E100 driver is compiled into the kernel
and not loaded as a module.

If the machine which should be woken up is already running (because
someone switched it on by hand), the WOL packet causes keventd to go
mad and "use" 100% CPU:

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
    2 root      15   0     0    0    0 R 99.9  0.0 140:50.94 keventd

This can be reproduced on any of the 70 machines by simply sending a WOL
packet to it, when it's already running... No entry is made in the
kernel log.

The dmesg of an affected machine can be found at:
http://wwwcip.informatik.uni-erlangen.de/~simigern/cip-dmesg
Our kernel-config is at:
http://wwwcip.informatik.uni-erlangen.de/~simigern/cip-generic-config
lspci -vvv is at:
http://wwwcip.informatik.uni-erlangen.de/~simigern/cip-lspci

We are using a kernel.org linux 2.4.29 kernel patched with the current
autofs patch and ACL support.

Regards,
  Michael
