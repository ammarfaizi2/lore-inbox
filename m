Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129145AbQKQDyZ>; Thu, 16 Nov 2000 22:54:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129314AbQKQDyP>; Thu, 16 Nov 2000 22:54:15 -0500
Received: from michae7.lnk.telstra.net ([139.130.137.101]:27144 "EHLO
	ppro.pineview.net") by vger.kernel.org with ESMTP
	id <S129145AbQKQDyF>; Thu, 16 Nov 2000 22:54:05 -0500
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Linux 2.2.17, Advanced routing & a Masq Link
Message-ID: <974434633.3a14b1499867c@ppro.pineview.net>
Date: Fri, 17 Nov 2000 14:47:13 +1000 (CST)
From: "\"Mike O\\\\'Connor\"" <kernel@pineview.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: IMP/PHP IMAP webmail program 2.2.3
X-Originating-IP: 203.38.186.33
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all

I\'ve asked this question on a few other email list with no responce, so as a 
last resort I\'m posting it here.

I\'m trying to get a system going which has two links to the internet. One has 
class C range routed over it and the other will need to be Masq\'d.
I want to route traffic like smtp, http, https & ftp via the low cost link (the 
Masq\'s one)

I\'ve setup Advanced routing based on using 2.2.17 and ipchains & iproute2 (the 
lastest as part of debian 2.2r1) using Linux 2.4 Advanced Routing HOWTO as an 
example. (there is not a 2.2 how-to for this even thought it is supposed to be 
able to do this type of thing) A few of the command did not have a ipchains 
equivalent, particularly \'mangle\'.

Using tcpdump I can see the packet come in from my notebook 203.33.246.2 which 
hits 203.33.246.1 and is MASQ\'d to the Ipaddress of the isdn link. The 
requested information is returned to the ISDN interface but nothing is seen on 
the eth1 link going back to notebook.

I also watched the normal ppp link and there was no traffic on this link in 
relation to the www connection.

The following is a list of the commands I used:

/sbin/ipchains -A forward -j MASQ -s 203.33.246.0/24 -i ippp+
/sbin/ipchains -A input -i eth1 -p tcp --dport 80 -m 1

root@ppro:~# ip rule ls
0:      from all lookup local
32765:  from all fwmark        1 lookup lowcost.out
32766:  from all lookup main
32767:  from all lookup default
root@ppro:~#

ip route add default dev ippp0 table lowcost.out

Any help would be great :)

Cheers & Thanks
    Mike O\'Connor
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
