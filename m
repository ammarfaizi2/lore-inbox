Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131167AbQL2OOc>; Fri, 29 Dec 2000 09:14:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131151AbQL2OOW>; Fri, 29 Dec 2000 09:14:22 -0500
Received: from nta-monitor.demon.co.uk ([212.229.78.70]:6406 "EHLO
	mercury.nta-monitor.com") by vger.kernel.org with ESMTP
	id <S129838AbQL2OOF>; Fri, 29 Dec 2000 09:14:05 -0500
Message-Id: <4.3.2.7.2.20001229133326.00b28990@192.168.124.1>
X-Mailer: QUALCOMM Windows Eudora Version 4.3.2
Date: Fri, 29 Dec 2000 13:43:28 +0000
To: linux-kernel@vger.kernel.org
From: Roy Hills <Roy.Hills@nta-monitor.com>
Subject: UDP ports 800-n used by NFS client in 2.2.17
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Does anyone know what causes netstat to show UDP port 800
as active on a Linux NFS client with 2.2.17 kernel when an NFS filesystem
is mounted?

Using Debian Linux 2.2 with Kernel 2.2.17 with one NFS filesystem mounted, 
I see
the following:

    rsh@lithium [3]$ netstat -n -a -u
    Active Internet connections (servers and established)
    Proto Recv-Q Send-Q Local Address          Foreign Address
    udp        0      0 0.0.0.0:800            0.0.0.0:*

If I unmount the NFS Filesystem, the UDP port disappears.

It appears that each NFS mounted filesystem uses a separate UDP
port, and that they count down from port 800.  I.e. the first
mount uses UDP port 800, the second UDP port 799.

"lsof -i" doesn't show this port belonging to any process, and the "-p" 
option to netstat
doesn't show any process info either. I assume that this means that it's a 
kernel thing
rather than a process level thing.

A network sniff while mounting and umounting the NFS filesystem
doesn't show any traffic on UDP port 800 - I just see portmapper, mountd 
and nfs
traffic.

Does anyone know what this is or where I can look in the source for more info?
I've searched /usr/src/linux/fs/nfs/*.c for 800 and 320 (800 in hex) 
without success.

Roy Hills
--
Roy Hills                                    Tel:   +44 1634 721855
NTA Monitor Ltd                              FAX:   +44 1634 721844
14 Ashford House, Beaufort Court,
Medway City Estate,                          Email: Roy.Hills@nta-monitor.com
Rochester, Kent ME2 4FA, UK                  WWW:   http://www.nta-monitor.com/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
