Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261343AbVCCERm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261343AbVCCERm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 23:17:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261391AbVCCEPM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 23:15:12 -0500
Received: from smtp04.mrf.mail.rcn.net ([207.172.4.63]:12663 "EHLO
	smtp04.mrf.mail.rcn.net") by vger.kernel.org with ESMTP
	id S261327AbVCCEMo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 23:12:44 -0500
Message-Id: <3sp35g$6s20j@smtp04.mrf.mail.rcn.net>
X-IronPort-AV: i="3.90,131,1107752400"; 
   d="scan'208"; a="7211027:sNHT24103410"
X-Mailer: QUALCOMM Windows Eudora Pro Version 4.0
Date: Wed, 02 Mar 2005 23:09:54 -0500
To: linux-kernel@vger.kernel.org
From: Zdenek Radouch <zdenek@rcn.com>
Subject: stack/routing kernel modification - consult needed
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I committed to a fairly complex project to run on Linux while
assuming that the Linux stack implementation would provide
equivalent functionality to that of the BSD-style stacks I am
familiar with.  At this point, quite far down the design path,
I looked at what I thought would be trivial details and
I am facing two major roadblocks.

Problem #1
The physical driver layer which itself is quite complex and
does additional routing, needs access to the destination
(next hop) IP address in order to transmit the packet.
Under BSD, the ip output method passes down the IP address,
but under Linux that does not seem to be the case.
I need some method of getting hold of the IP address.
Note that there is no protocol address
resolution on these interfaces, but there are multiple hosts
to be addressed.  The physical layer does the necessary
addressing and additional routing, but it needs the IP address
of where the packet is being forwarded.

Problem #2
This device is a routing class device, i.e., it routes network
traffic on some network segment.  As such, it must be able to
handle both public (e.g., 18.x.x.x) and private (e.g., 192.168.x.x)
IP addresses.
The device itself has multiple, loosely-coupled cards that
communicate via TCP/IP sockets.  To separate the "device
internal" TCP traffic from the external "real" network traffic,
the standard BSD solution is to subnet the 127/8 "lo" interface
to 127.0/16 for "lo" and e.g., 127.1/16 for a driver accessing
the other cards.  Unfortunately, the Linux stack does not
seem to allow subnetting of the 127 net.

Assuming that my observation are accurate (please feel free to
indicate otherwise), it would appear to me that I have two options:

1. Hack the Linux kernel/stack to add the required functionality
    (pass IP on transmit, allow 127/16 subnets).
    This would be the preferred solution given the late stage of
    the project, but I am not familiar (obviously) with the Linux stack
    code.  I am now also nervous about other possible surprises
    (I got VLANs, multiple interfaces with same IP address,
     multiple proxy ARPs on the same processor etc.)
 
2.  Scrap the project and restart under BSD.  This is quite an
     expensive option; the only advantage would be my certainty
     that all of the concepts will work as architected because
     they were based on such stack.

I am looking for advice, and, if possible, help.
Any pointers addressing any of the above will be quite useful to me.
If you are familiar with the relevant kernel code, and would be willing
to help me with the modifications, please let me know.
If you could do it, but think it would take too much of your time,
please let me know, too, I'd be glad to set up a paid consulting 
arrangement if that would help.

BTW, this is being developed on the 2.4.25 kernel.

Please respond to me directly: zdenek at rcn.com

Thanks,
-Zdenek
