Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261891AbUBWJHM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 04:07:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261889AbUBWJHM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 04:07:12 -0500
Received: from [206.191.46.196] ([206.191.46.196]:32009 "EHLO mdant.atkin.com")
	by vger.kernel.org with ESMTP id S261891AbUBWJHD convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 04:07:03 -0500
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: 2.6.2 issues (IPSec+NAT, RFC2684 bridge)
X-MimeOLE: Produced By Microsoft Exchange V6.5.6944.0
Date: Mon, 23 Feb 2004 04:06:36 -0500
Message-ID: <66187D861C1747499BE1365B74E036917B5F82@mdant.atkin.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 2.6.2 issues (IPSec+NAT, RFC2684 bridge)
Thread-Index: AcP57FcYf1hF0VovRPG0DIBSTwFSRQ==
From: "Samofatov, Nickolay" <Nickolay@BroadViewSoftware.com>
To: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Here is a list of minor issues I encountered when migrated my AMD64
machine to 2.6.2 kernel (64-bit).

1) Attempts to combine IPSec and NAT result in various kinds of
failures. The easiest to reproduce is reliable hard system lock-up when
IKE session needs to be initiated because of request from masqueraded
machine.
(workaround is to run cron job keeping IPSec connection active)

2) I had to add following line to my routing rules to get IPSec working
locally:
--
route add -m 172.20.0.0 netmask 255.255.0.0 gw 172.21.113.1
--
172.20.0.0 here is VPN subnet I'm interested in. 172.21.113.1 is the
address assigned to eth0 interface which is also IP address of this
machine in VPN.
Before I added this rule TCP connections from localhost failed with no
route to host. The result works for most applications, but not all. For
example, SSH fails.
(my workaround is to use SOCKS5 proxy running locally for local SSH
connections over IPSec tunnels)

3) RFC2684 bridge oopses when I try to run it with my ATM device
(SpeedTouch USB) not plugged.
(workaround is to check if device is really plugged and initialized in
usbfs before attempting to start bridge)
BTW, if you build SpeedTouch driver as module and build ATM bridge into
kernel you get oopses during bridge initialization.
(AFAIU, they work fine only if both built into kernel)

4) My attempts to use preemptable kernel failed miserably. Kernel
produces lots of warnings during boot and usually oopses before system
init finishes. If I disable RFC2684 bridge it successfully boots more
often, but attempts to do any big work, for example to start X fail in
any case.
(workaround is to build non-preeptable kernel, bad for multimedia
applications, but tolerable)

If there is interest, I may provide as much information as required to
resolve the problems.

But in general, 2.6.2 kernel works great. When I find a way to work
around hard system lockups when NPTL is used in combination with NVIDIA
XFree drivers I'll be totally happy.


Nickolay Samofatov

