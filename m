Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132526AbREBKOt>; Wed, 2 May 2001 06:14:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132527AbREBKOk>; Wed, 2 May 2001 06:14:40 -0400
Received: from [195.50.100.22] ([195.50.100.22]:8370 "HELO
	emasgn01.eu.rabobank.com") by vger.kernel.org with SMTP
	id <S132526AbREBKOa>; Wed, 2 May 2001 06:14:30 -0400
X-Server-Uuid: df2cf700-468c-11d4-860a-00508b951a52
Message-ID: <1E8992B3CD28D4119D5B00508B08EC5627E8A4@sinxsn02.ap.rabobank.com>
From: "Sim, CT (Chee Tong)" <CheeTong.Sim@sin.rabobank.com>
To: "'Michel Wilson'" <michel@procyon14.yi.org>,
        "Sim, CT (Chee Tong)" <CheeTong.Sim@sin.rabobank.com>
cc: linux-kernel@vger.kernel.org
Subject: RE: Linux NAT questions- (kernel upgrade??)
Date: Wed, 2 May 2001 18:14:50 +0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
X-WSS-ID: 16F1028E81948-01-02
Content-Type: text/plain; 
 charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.. I follow your instruction, but I encounter this issue, my kernel need
to be upgrade? MAy I know how to determine the current kernel version and
how to upgrade it?? 


[root@guava /root]# iptables -t nat -A PREROUTING -p tcp --dst 1.1.1.160 -i
eth1 -j D
NAT --to-destination 192.168.200.2
iptables v1.1.1: can't initialize iptables table `nat': iptables who? (do
you need to insm
od?)
Perhaps iptables or your kernel needs to be upgraded.


[root@guava simc]# rpm -ivh iptables-1_2_0-6_i386.rpm
error: failed dependencies:
        kernel >= 2.4.0 is needed by iptables-1.2.0-6


-----Original Message-----
From: Michel Wilson [mailto:michel@procyon14.yi.org]
Sent: Wednesday, May 02, 2001 5:13 PM
To: Sim, CT (Chee Tong)
Cc: linux-kernel@vger.kernel.org
Subject: RE: Linux NAT questions


> what I am trying to do is this. I have a genuine network, say 1.1.1.x, and
> my Linux host is on it, as 1.1.1.252 (eth0). I also have a second
> network at
> the back of the Linux box, 192.168.200.x, and a web server on
> that network,
> 192.168.200.2. The Linux address is 192.168.200.1 on eth1.
>
> What I want to do is make the web server appear on the 1.1.1.x network as
> 1.1.1.160. I have done this before with Firewall-1 on NT, by
> putting an arp
> entry for 1.1.1.160 to point to the Linux machine eth0. The packets get
> redirected into the Linux machine, then translated, and then routed out of
> eth1.
>
> The benefit is that there is no routing change to the 1.1.1.x network, and
> the Linux box isn't even seen as a router.
>
> I would appreciate any help with this. Any command to do this?
>
> Chee Tong
This isn't really a kernel question. I think you'd better ask it on some
linux network list/newsgroup. But here's an answer anyway....

You could add 1.1.1.160 to eth0:
   ip addr add 1.1.1.160 dev eth0
and then use NAT to redirect these to the webserver:
   iptables -t nat -A PREROUTING -p tcp --dst 1.1.1.160 -i eth1 -j
DNAT --to-destination 192.168.200.2

This should work, AFAIK, but i didn't try it myself. You could also try to
use the arp command (see 'man arp'), but i don't know exactly how that
works.

Good luck!

Michel Wilson.


==================================================================
De informatie opgenomen in dit bericht kan vertrouwelijk zijn en 
is uitsluitend bestemd voor de geadresseerde. Indien u dit bericht 
onterecht ontvangt wordt u verzocht de inhoud niet te gebruiken en 
de afzender direct te informeren door het bericht te retourneren. 
==================================================================
The information contained in this message may be confidential 
and is intended to be exclusively for the addressee. Should you 
receive this message unintentionally, please do not use the contents 
herein and notify the sender immediately by return e-mail.


==================================================================

