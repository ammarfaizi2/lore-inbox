Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262752AbTHUPGq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Aug 2003 11:06:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262763AbTHUPGq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Aug 2003 11:06:46 -0400
Received: from obsidian.spiritone.com ([216.99.193.137]:47037 "EHLO
	obsidian.spiritone.com") by vger.kernel.org with ESMTP
	id S262752AbTHUPGo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Aug 2003 11:06:44 -0400
Date: Thu, 21 Aug 2003 08:06:11 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
cc: michal-bugzilla@logix.cz
Subject: [Bug 1130] New: GRE tunnels freeze kernel 
Message-ID: <6570000.1061478371@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=1130

           Summary: GRE tunnels freeze kernel
    Kernel Version: 2.6.0-test2, 2.6.0-test3
            Status: NEW
          Severity: high
             Owner: bugme-janitors@lists.osdl.org
         Submitter: michal-bugzilla@logix.cz


Distribution: SuSE Linux 8.2
Hardware Environment: x86
Software Environment: gcc-3.3 used to compile kernel.

Problem Description:
Incoming packet to the GRE tunnel interface freezes the kernel.

Steps to reproduce:
On a 2.6.0-test system create a tunnel for instance with these steps:

On 10.0.0.1:
modprobe ip_gre
ip tunnel add gre1 mode gre local 10.0.0.1 remote 10.0.0.2 ttl 64
ip link set gre1 up
ip addr add 172.16.0.1/24 dev gre1

On a non-2.6.0 10.0.0.2:
modprobe ip_gre
ip tunnel add gre1 mode gre local 10.0.0.2 remote 10.0.0.1 ttl 64
ip link set gre1 up
ip addr add 172.16.0.2/24 dev gre1

Now ping the 2.6.0 system:
ping -c1 172.16.0.1

Upon receiving the packet the box foreezes. No Oops but neither <Alt>+<F>
console switching nor NumLock worked anymore. (Don't know about SysRq).


