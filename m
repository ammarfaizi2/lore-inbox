Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271045AbTHGWi7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 18:38:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271042AbTHGWi7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 18:38:59 -0400
Received: from 213-0-201-17.dialup.nuria.telefonica-data.net ([213.0.201.17]:10130
	"EHLO dardhal.mired.net") by vger.kernel.org with ESMTP
	id S271038AbTHGWiz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 18:38:55 -0400
Date: Fri, 8 Aug 2003 00:38:54 +0200
From: Jose Luis Domingo Lopez <linux-net@24x7linux.com>
To: linux-net@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: "No buffer space available" on 2.6.0-test2-mm2 trying to create sit-mode tunnel
Message-ID: <20030807223854.GA7824@localhost>
Mail-Followup-To: linux-net@vger.kernel.org,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi:

Doing some tests with 2.6.0-test2-mm2 and IPv6 over IPv4 tunnels I come
across the error message in the subject:

dardhal:~# ip tunnel add sixbone mode sit remote 64.71.xxx.xxx local 213.0.xxx.xxx ttl 255
ioctl: No buffer space available

Tracing the previous command shows the following (relevant part only):
socket(PF_INET, SOCK_DGRAM, IPPROTO_IP) = 3
ioctl(3, 0x89f1, 0xbffff7d8)            = -1 ENOBUFS (No buffer space available)
dup(2)                                  = 4
fcntl64(4, F_GETFL)                     = 0x2 (flags O_RDWR)
brk(0)                                  = 0x805e000
brk(0x805f000)                          = 0x805f000
brk(0)                                  = 0x805f000
fstat64(4, {st_mode=S_IFCHR|0600, st_rdev=makedev(136, 4), ...}) = 0
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x40012000
_llseek(4, 0, 0xbffff5f0, SEEK_CUR)     = -1 ESPIPE (Illegal seek)
write(4, "ioctl: No buffer space available"..., 33ioctl: No buffer space available
) = 33
close(4)                                = 0
munmap(0x40012000, 4096)                = 0
close(3)                                = 0
exit_group(-1)                          = ?

This same command has worked for me previously, even after several IP changes 
(local tunnel enpoint on a dynamic IP). Maybe I am doing something wrong, 
but my box configuration seems to be the same as it was some hours ago.

Some (hopefully) useful data follows:
# ip -6 link show
3: sit0: <NOARP> mtu 1480 qdisc noop 
    link/sit 0.0.0.0 brd 0.0.0.0
6: sixbone@NONE: <POINTOPOINT,NOARP,UP> mtu 1504 qdisc noqueue 
    link/sit 213.0.xxx.xxx peer 64.71.xxx.xxx
7: ppp0: <POINTOPOINT,MULTICAST,NOARP,UP> mtu 1524 qdisc sfq qlen 3
    link/ppp 

# ip -4 address show
7: ppp0: <POINTOPOINT,MULTICAST,NOARP,UP> mtu 1524 qdisc sfq qlen 3
    inet 213.0.xxx.xxx peer 213.0.xxx.xxx/32 scope global ppp0

# ip -6 address show
6: sixbone@NONE: <POINTOPOINT,NOARP,UP> mtu 1504 qdisc noqueue 
    inet6 2001:470:1f00:xxxx::xxxx/127 scope global 
    inet6 fe80::d500:c95d/128 scope link 

# ip -6 tunnel show
sit0: ipv6/ip  remote any  local any  ttl 64  nopmtudisc
sixbone: ipv6/ip  remote 64.71.xxx.xxx  local 213.0.xxx.xxx  ttl 255 

I don't know what other information could be of interest, but just ask.

Regards,

-- 
Jose Luis Domingo Lopez
Linux Registered User #189436     Debian Linux Sid (Linux 2.6.0-test2-mm2)
