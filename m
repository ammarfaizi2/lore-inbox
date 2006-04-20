Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751213AbWDTUrj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751213AbWDTUrj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 16:47:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751266AbWDTUrj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 16:47:39 -0400
Received: from odyssey.analogic.com ([204.178.40.5]:60686 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S1751213AbWDTUrj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 16:47:39 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
in-reply-to: <4447C6FA.30400@cloakmail.com>
x-originalarrivaltime: 20 Apr 2006 20:47:37.0619 (UTC) FILETIME=[A88E2E30:01C664BB]
Content-class: urn:content-classes:message
Subject: Re: Unable to receive multicast stream
Date: Thu, 20 Apr 2006 16:47:37 -0400
Message-ID: <Pine.LNX.4.61.0604201638540.6613@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Unable to receive multicast stream
Thread-Index: AcZku6iVdcw4rbDORJS8NwMn20/4hA==
References: <4447C6FA.30400@cloakmail.com>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Andrew Athan" <aathan_linux_kernel_1542@cloakmail.com>
Cc: <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 20 Apr 2006, Andrew Athan wrote:

>
> The simple UDP multicast receive application below, adapted from source
> on IBM's web site, will not receive any data.  While it is blocked on
> recv():
>
> hfclinux2:/home/root/UDP/apps/Crosser2# netstat -ang
> IPv6/IPv4 Group Memberships
> Interface       RefCnt Group
> --------------- ------ ---------------------
> lo              1      224.0.0.1
> eth0            1      224.0.0.1
> eth1            1      224.0.17.44
> eth1            1      224.0.0.1
> lo              1      ff02::1
> eth0            1      ff02::1:ffdd:eb2b
> eth0            1      ff02::1
> eth1            1      ff02::1:ffdd:eb2c
> eth1            1      ff02::1
>
>
> And tcpdump shows traffic arriving at the interface(see below)!  This
> leads me to belive the kernel is filtering it, and or not delivering it
> to the socket.
>
> The one "strange" thing about this network is that the traffic is
> flowing in "dense mode", meaning there is no explicit need for IGMP
> messaging (nor any response to such messaging).
>
> Can anyone point me in the right direction regarding why the socket
> never receives any data????
>
> Thanks.
> Andrew
>
> hfclinux2:/home/root/UDP/apps/Crosser2# uname -a
> Linux hfclinux2 2.6.15.1smp #6 SMP PREEMPT Mon Feb 13 11:38:32 EST 2006
> i686 GNU/Linux
>
> hfclinux2:/home/root/UDP/apps/Crosser2# tcpdump -i eth1 port 55300
> tcpdump: verbose output suppressed, use -v or -vv for full protocol decode
> listening on eth1, link-type EN10MB (Ethernet), capture size 96 bytes
> 12:54:06.980000 IP 206.200.5.144.2232 > 224.0.17.44.55300: UDP, length 91
> 12:54:07.079675 IP 206.200.5.144.2232 > 224.0.17.44.55300: UDP, length 46
> 12:54:07.179869 IP 206.200.5.144.2232 > 224.0.17.44.55300: UDP, length 181
> 12:54:07.280437 IP 206.200.5.144.2232 > 224.0.17.44.55300: UDP, length 181
> 12:54:07.380005 IP 206.200.5.144.2232 > 224.0.17.44.55300: UDP, length 181
> 12:54:07.480073 IP 206.200.5.144.2232 > 224.0.17.44.55300: UDP, length 136
> 12:54:07.680459 IP 206.200.5.144.2232 > 224.0.17.44.55300: UDP, length 91
> 12:54:07.780277 IP 206.200.5.144.2232 > 224.0.17.44.55300: UDP, length 136
>
>
> hfclinux2:/home/root/UDP/apps/Crosser2# ifconfig
> eth0      Link encap:Ethernet  HWaddr 00:11:43:DD:EB:2B
>          inet addr:172.22.71.128  Bcast:172.22.71.255  Mask:255.255.255.0
>          inet6 addr: fe80::211:43ff:fedd:eb2b/64 Scope:Link
>          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
>          RX packets:19540 errors:0 dropped:0 overruns:0 frame:0
>          TX packets:7838 errors:0 dropped:0 overruns:0 carrier:0
>          collisions:0 txqueuelen:1000
>          RX bytes:1563190 (1.4 MiB)  TX bytes:1943895 (1.8 MiB)
>          Base address:0xdcc0 Memory:dfae0000-dfb00000
>
> eth0:1    Link encap:Ethernet  HWaddr 00:11:43:DD:EB:2B
>          inet addr:10.61.6.128  Bcast:10.61.6.255  Mask:255.255.255.0
>          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
>          Base address:0xdcc0 Memory:dfae0000-dfb00000
>
> eth0:2    Link encap:Ethernet  HWaddr 00:11:43:DD:EB:2B
>          inet addr:196.0.34.11  Bcast:196.0.34.255  Mask:255.255.255.0
>          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
>          Base address:0xdcc0 Memory:dfae0000-dfb00000
>
> eth0:3    Link encap:Ethernet  HWaddr 00:11:43:DD:EB:2B
>          inet addr:192.168.254.128  Bcast:192.168.254.255
> Mask:255.255.255.0
>          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
>          Base address:0xdcc0 Memory:dfae0000-dfb00000
>
> eth1      Link encap:Ethernet  HWaddr 00:11:43:DD:EB:2C
>          inet addr:192.168.250.128  Bcast:192.168.250.255
> Mask:255.255.255.0
>          inet6 addr: fe80::211:43ff:fedd:eb2c/64 Scope:Link
>          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
>          RX packets:137717 errors:0 dropped:0 overruns:0 frame:0
>          TX packets:24 errors:0 dropped:0 overruns:0 carrier:0
>          collisions:0 txqueuelen:1000
>          RX bytes:58314262 (55.6 MiB)  TX bytes:1596 (1.5 KiB)
>          Base address:0xccc0 Memory:df8e0000-df900000
>
> lo        Link encap:Local Loopback
>          inet addr:127.0.0.1  Mask:255.0.0.0
>          inet6 addr: ::1/128 Scope:Host
>          UP LOOPBACK RUNNING  MTU:16436  Metric:1
>          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
>          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
>          collisions:0 txqueuelen:0
>          RX bytes:0 (0.0 b)  TX bytes:0 (0.0 b)
>
>
>
> -------------------------
> #include <sys/types.h>
> #include <sys/socket.h>
> #include <arpa/inet.h>
> #include <netinet/in.h>
> #include <stdio.h>
> #include <stdlib.h>
> #include <unistd.h>
> #include <string.h>
>
> using namespace std;
>
>
> struct sockaddr_in    localSock;
> struct ip_mreqn        group;
> int                   sd;
> int                   datalen;
> char                  databuf[10];
>
> int main (int argc, char *argv[])
> {
>  sd = socket(AF_INET, SOCK_DGRAM, 0);
>  if (sd < 0) {
>    perror("opening datagram socket");
>    exit(1);
>  }
>
>  {
>    int reuse=1;
>
>    if (setsockopt(sd, SOL_SOCKET, SO_REUSEADDR,
>                   (char *)&reuse, sizeof(reuse)) < 0) {
>      perror("setting SO_REUSEADDR");
>      close(sd);
>      exit(1);
>    }
>  }
>
>  memset((char *) &localSock, 0, sizeof(localSock));
>  localSock.sin_family = AF_INET;
>  localSock.sin_port = htons(55300);;
>  localSock.sin_addr.s_addr  = INADDR_ANY;
>
>  if (bind(sd, (struct sockaddr*)&localSock, sizeof(localSock))) {
>    perror("binding datagram socket");
>    close(sd);
>    exit(1);
>  }
>
>
>  group.imr_multiaddr.s_addr = inet_addr("224.0.17.44");
>  printf("%d\n",group.imr_multiaddr.s_addr);
>  group.imr_address.s_addr = inet_addr("192.168.250.128");
>  if (setsockopt(sd, IPPROTO_IP, IP_ADD_MEMBERSHIP,
>                 (char *)&group, sizeof(group)) < 0) {
>    perror("adding multicast group");
>    close(sd);
>    exit(1);
>  }
>  /*
>   * Read from the socket.
>   */
>  datalen = sizeof(databuf);
>  if (read(sd, databuf, datalen) < 0) {
>    perror("reading datagram message");
>    close(sd);
>    exit(1);
>  } else {
>    puts("success reading");
>  }
> }


12:54:07.780277 IP 206.200.5.144.2232 > 224.0.17.44.55300: UDP, length 136
                                                            ^^^___ datagram

Question? Don't you need to use:

     socklen_t slen = sizeof(localSock);
     recvfrom(sd, databuf, datalen, &localSock, &slen);

... to receive a datagram?

Cheers,
Dick Johnson
Penguin : Linux version 2.6.16.4 on an i686 machine (5592.89 BogoMips).
Warning : 98.36% of all statistics are fiction, book release in April.
_


****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
