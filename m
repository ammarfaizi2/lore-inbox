Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281020AbRKOTrx>; Thu, 15 Nov 2001 14:47:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281015AbRKOTrc>; Thu, 15 Nov 2001 14:47:32 -0500
Received: from netsrvr.ami.com.au ([203.55.31.38]:40714 "EHLO
	netsrvr.ami.com.au") by vger.kernel.org with ESMTP
	id <S281022AbRKOTrZ>; Thu, 15 Nov 2001 14:47:25 -0500
Message-Id: <200111151901.fAFJ14x07788@numbat.os2.ami.com.au>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: "David S. Miller" <davem@redhat.com>
cc: summer@os2.ami.com.au, linux-kernel@vger.kernel.org, netdev@oss.sgi.com,
        summer@numbat.os2.ami.com.au
Subject: Re: BOOTP and 2.4.14 
In-Reply-To: Message from "David S. Miller" <davem@redhat.com> 
   of "Thu, 15 Nov 2001 07:11:05 PST." <20011115.071105.45157375.davem@redhat.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 16 Nov 2001 03:01:04 +0800
From: summer@os2.ami.com.au
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> Set your kernel command line correctly, the format is:
> 
> 	HOSTNAME.NIS_DOMAINNAME
> 
> It has been like this since ancient times :-)
> 


I don't understand. According to nfsroot.txt all I need is this:

[root@numbat root]# cat /misc/fd0/syslinux.cfg
default linux
prompt 1
timeout 1
label linux
        kernel vmlinuz
        append  root=/dev/nfs ip=bootp initrd=initial.dsk
[root@numbat root]#

The kernel messages say it's got the domain name, but by the time it 
gets to init (I altered /etc/rc.d/rc.sysinit to see) it's using the IP 
address for host/domain names, and that's what I see in the code I 
cited.

The nis domain's not being set, but I've not established the kernel's 
at failt.

According to the debugging code which I've enabled, it's seeing 
extensions 1, 3, 6, 55, 45, 46 and 15.

1 looks like the netmask, 3, 6, 44 and 45 are all the IP address of the 
server (it does several things so that's probably okay), 46 has the 
value 08 and 15 is the DNS domain name.

The client's IP address isn't reported by the debugging code, but is 
set to the value I expect.

I see the extensions are parsed in ic_do_bootp_ext which silently 
ignores 44, 45 & 46.

Here are some kernel messages from booting the client:
Nov 16 02:46:51 192 kernel: IP-Config: Entered.
Nov 16 02:46:52 192 kernel: IP-Config: eth0 UP (able=1, xid=46e93477)
Nov 16 02:46:52 192 kernel: Sending BOOTP requests .DHCP/BOOTP: Got 
extension 1: ff ff ff 00
Nov 16 02:46:52 192 kernel: DHCP/BOOTP: Got extension 3: c0 a8 01 01
Nov 16 02:46:52 192 kernel: DHCP/BOOTP: Got extension 6: c0 a8 01 01
Nov 16 02:46:52 192 kernel: DHCP/BOOTP: Got extension 44: c0 a8 01 01
Nov 16 02:46:52 192 kernel: DHCP/BOOTP: Got extension 45: c0 a8 01 01
Nov 16 02:46:52 192 kernel: DHCP/BOOTP: Got extension 46: 08
Nov 16 02:46:52 192 kernel: DHCP/BOOTP: Got extension 15: 4f 73 32 2e 
41 6d 69 2e 43 6f 6d 2e 41 75
Nov 16 02:46:52 192 kernel:  OK
Nov 16 02:46:52 192 kernel: IP-Config: Got BOOTP answer from 
192.168.1.1, my address is 192.168.1.20
Nov 16 02:46:52 192 kernel: IP-Config: Complete:
Nov 16 02:46:52 192 kernel:       device=eth0, addr=192.168.1.20, 
mask=255.255.255.0, gw=192.168.1.1,
Nov 16 02:46:52 192 kernel:      host=192.168.1.20, 
domain=Os2.Ami.Com.Au, nis-domain=(none),
Nov 16 02:46:52 192 kernel:      bootserver=192.168.1.1, 
rootserver=192.168.1.1, rootpath=


By the time init passes control to ins initialisation script, the 
hostname command reports 192 and dnsdomainname reports 168.0.1.


-- 
Cheers
John Summerfield

Microsoft's most solid OS: http://www.geocities.com/rcwoolley/

Note: mail delivered to me is deemed to be intended for me, for my 
disposition.



