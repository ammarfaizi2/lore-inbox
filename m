Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264274AbRFHRpT>; Fri, 8 Jun 2001 13:45:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264284AbRFHRpJ>; Fri, 8 Jun 2001 13:45:09 -0400
Received: from dsl-64-192-150-245.telocity.com ([64.192.150.245]:11539 "EHLO
	mail.communicationsboard.net") by vger.kernel.org with ESMTP
	id <S264274AbRFHRpE>; Fri, 8 Jun 2001 13:45:04 -0400
To: Ion Badulescu <ionut@cs.columbia.edu>
Subject: Re: xircom_cb problems
Message-ID: <992022302.3b210f1e0e26f@eargle.com>
Date: Fri, 08 Jun 2001 13:45:02 -0400 (EDT)
From: Tom Sightler <ttsig@tuxyturvy.com>
Cc: Tom Sightler <ttsig@tuxyturvy.com>, linux-kernel@vger.kernel.org,
        arjan@fenrus.demon.nl
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-MOQ9920223029bf91d0bb62ae3d3b801a6414b21e76b"
User-Agent: IMP/PHP IMAP webmail program 2.2.3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This message is in MIME format.

---MOQ9920223029bf91d0bb62ae3d3b801a6414b21e76b
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit

Whoops!! Sorry, forgot the attachment.

Thanks,
Tom


> Both of these are slow, actually. I'm getting 7.5-8MB/s when receiving
> from a 100Mbit box (tulip or starfire, doesn't seem to matter). 
> Transmitting is still slow for me, but that is most likely a different 
> problem -- and I'm looking into it.

Yeah, I knew they were both slow, but at least one is acceptable, the <200KB/s
is below usable when doing any network based work.

> Moreover, I'm getting 9+MB/s in both directions when using the other 
> driver (xircom_tulip_cb), patched to do half-duplex only. So the card
> can definitely transfer at network speeds.

I'm not doing nearly as well with the other driver, but I don't have it patched
for half-duplex only.  I tried setting the remote end to force half-duplex but
this didn't seem to work quite right.


> Looking forward to seeing them...

OK, I tried your patch, it did fix the problem where pump wouldn't pull an IP
address, but I'm still having the problem where my ping times go nuts.  I've
attached an example, it's 100% repeatable on my network at work.  It was so bad
I couldn't get any benchmark numbers.

Later,
Tom


---MOQ9920223029bf91d0bb62ae3d3b801a6414b21e76b
Content-Type: text/plain; name="/root/xircom-slow-pings.txt"; name="/root/xircom-slow-pings.txt"; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Content-Disposition: inline; filename="/root/xircom-slow-pings.txt"


[root@iso-2146-l1 ttsig]# ping 10.10.4.254
PING 10.10.4.254 (10.10.4.254) from 10.10.4.33 : 56(84) bytes of data.
64 bytes from 10.10.4.254: icmp_seq=3 ttl=255 time=590 usec
64 bytes from 10.10.4.254: icmp_seq=0 ttl=255 time=2.996 sec
64 bytes from 10.10.4.254: icmp_seq=1 ttl=255 time=2.000 sec
64 bytes from 10.10.4.254: icmp_seq=2 ttl=255 time=1.000 sec
64 bytes from 10.10.4.254: icmp_seq=7 ttl=255 time=575 usec
64 bytes from 10.10.4.254: icmp_seq=4 ttl=255 time=3.000 sec
64 bytes from 10.10.4.254: icmp_seq=5 ttl=255 time=2.000 sec
64 bytes from 10.10.4.254: icmp_seq=6 ttl=255 time=1.000 sec

--- 10.10.4.254 ping statistics ---
10 packets transmitted, 8 packets received, 20% packet loss
round-trip min/avg/max/mdev = 0.575/1500.228/3000.710/1117.327 ms
[root@iso-2146-l1 ttsig]# rmmod xircom_cb
rmmod: module xircom_cb is not loaded
[root@iso-2146-l1 ttsig]# lsmod
Module                  Size  Used by
appletalk              18352   0  (autoclean)
serial                 44864   0 
vmnet                  16448   1 
vmmon                  18352   0 
r128                  145392   1 
agpgart                13568   3  (autoclean)
usb-uhci               20864   0  (unused)
usbcore                48176   1  [usb-uhci]
[root@iso-2146-l1 ttsig]# ping 10.10.4.254
PING 10.10.4.254 (10.10.4.254) from 10.10.4.33 : 56(84) bytes of data.
64 bytes from 10.10.4.254: icmp_seq=0 ttl=255 time=955 usec
64 bytes from 10.10.4.254: icmp_seq=1 ttl=255 time=492 usec
64 bytes from 10.10.4.254: icmp_seq=2 ttl=255 time=453 usec
64 bytes from 10.10.4.254: icmp_seq=3 ttl=255 time=465 usec
64 bytes from 10.10.4.254: icmp_seq=4 ttl=255 time=451 usec
64 bytes from 10.10.4.254: icmp_seq=5 ttl=255 time=455 usec
64 bytes from 10.10.4.254: icmp_seq=6 ttl=255 time=450 usec
64 bytes from 10.10.4.254: icmp_seq=7 ttl=255 time=453 usec

--- 10.10.4.254 ping statistics ---
8 packets transmitted, 8 packets received, 0% packet loss
round-trip min/avg/max/mdev = 0.450/0.521/0.955/0.166 ms
---MOQ9920223029bf91d0bb62ae3d3b801a6414b21e76b--
