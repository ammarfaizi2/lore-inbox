Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281175AbRKEP0M>; Mon, 5 Nov 2001 10:26:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281180AbRKEP0C>; Mon, 5 Nov 2001 10:26:02 -0500
Received: from netsrvr.ami.com.au ([203.55.31.38]:35588 "EHLO
	netsrvr.ami.com.au") by vger.kernel.org with ESMTP
	id <S281175AbRKEPZu>; Mon, 5 Nov 2001 10:25:50 -0500
Message-Id: <200111051349.fA5DnFD29728@numbat.os2.ami.com.au>
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
To: Linux-Kernel@vger.kernel.org
Subject: DHCP broken in 2.4.x
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 05 Nov 2001 21:49:15 +0800
From: John Summerfield <summer@os2.ami.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

x in this case is 13.

As I type this my DHCP server is saying

ov  5 20:58:12 dugite dhcpd: DHCPDISCOVER from 00:c0:26:2d:be:12 via 
eth0
Nov  5 20:58:12 dugite dhcpd: DHCPOFFER on 192.168.1.6 to 
00:c0:26:2d:be:12 via eth0
Nov  5 20:58:15 dugite dhcpd: DHCPDISCOVER from 00:c0:26:2d:be:12 via 
eth0
Nov  5 20:58:15 dugite dhcpd: DHCPOFFER on 192.168.1.6 to 
00:c0:26:2d:be:12 via eth0
Nov  5 20:58:19 dugite dhcpd: DHCPDISCOVER from 00:c0:26:2d:be:12 via 
eth0
Nov  5 20:58:19 dugite dhcpd: DHCPOFFER on 192.168.1.6 to 
00:c0:26:2d:be:12 via eth0
Nov  5 20:58:28 dugite dhcpd: DHCPDISCOVER from 00:c0:26:2d:be:12 via 
eth0
Nov  5 20:58:28 dugite dhcpd: DHCPOFFER on 192.168.1.6 to 
00:c0:26:2d:be:12 via eth0
Nov  5 20:58:42 dugite dhcpd: DHCPDISCOVER from 00:c0:26:2d:be:12 via 
eth0
Nov  5 20:58:42 dugite dhcpd: DHCPOFFER on 192.168.1.6 to 
00:c0:26:2d:be:12 via eth0
Nov  5 20:59:06 dugite dhcpd: DHCPDISCOVER from 00:c0:26:2d:be:12 via 
eth0
Nov  5 20:59:06 dugite dhcpd: DHCPOFFER on 192.168.1.6 to 
00:c0:26:2d:be:12 via eth0


and the poor sod at the other end is
setting half-duplex ....
sending DHCP and RARP requests .... Timed out!
IPConfig: Retrying forever (NFS root).


Here's how I'm booting:
root@numbat /root]# cat /misc/fd1/syslinux.cfg
default linux
prompt 1
display boot.msg
timeout 100
label linux
        kernel vmlinuz
        append  root=/dev/hda5
[root@numbat /root]

I'm running dhcp-2.0pl5-4 on RHL 7.1.

If I override the boot prompt:
ip=bootp
then it works.


Now I can see that I misunderstood the documentation (which, btw, could 
use a minor touch-up to mention DHCP), but

but

According to the source code, ip=dchp is legit. However, it causes lots 
of messages on the server just like above., and the client's looping 
just like before.

Two things I'd like to see:
1) A message to the user if an invalid value's given
2) DHCP actually work. BOOTP seems fine, as far as BOOTP goes.

I have RARP genned, but there's not actually anything to talk to.

-- 
Cheers
John Summerfield

Microsoft's most solid OS: http://www.geocities.com/rcwoolley/

Note: mail delivered to me is deemed to be intended for me, for my 
disposition.



