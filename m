Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129066AbRBMC2W>; Mon, 12 Feb 2001 21:28:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129204AbRBMC2M>; Mon, 12 Feb 2001 21:28:12 -0500
Received: from kea.grace.cri.nz ([131.203.4.51]:7697 "EHLO kea.grace.cri.nz")
	by vger.kernel.org with ESMTP id <S129066AbRBMC2G>;
	Mon, 12 Feb 2001 21:28:06 -0500
Date: Mon, 12 Feb 2001 21:27:24 -0500 (EST)
Message-Id: <200102130227.VAA06389@whio.grace.cri.nz>
From: roger@kea.grace.cri.nz
To: linux-kernel@vger.kernel.org
CC: roger@kea.grace.cri.nz, dwmw2@infradead.org, R.Bain@comnet.co.nz
Subject: Problem with Netscape/Linux v.2.4.x [repeat] (MTU problem??) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




Symptoms: The browser (Netscape or Lynx) will not download from remote
web sites (dynamic ppp connection via external modem).

This is a second post. The problem is still not resolved, but can now
be described in more detail, thanks to help given by David Woodhouse
(and others) and my ISP.

Description: Typically Netscape/Lynx will connect to a remote site but
will not download (it will hang indefinitely). When the browser is in 
such a hung state I am still able to ping/telnet/ftp to the URL. I have
no difficulty browsing with Linux 2.2.16. The problem only occurs with 
the 2.4.x kernels (2.4.0, 2.4.1).

My ISP operates a "transparent proxy server". According to tcpdump
TX packets from my machine are passed on by the proxy server to the
remote site, and the response from the latter is also logged by the 
server and passed on to me. However at that point there is no further
traffic from the proxy server.

This looks to be a problem for my PC and the 2.4.x kernel, however
the proxy server is also involved for the following reason: although
the browser is locked for almost all remote sites, I _am_ able to
connect to (the web page of) the proxy server itself. And after I do
this the browser is *unlocked*, and I can connect/download from any web
address. However this only lasts for 5 minutes or so, after which time
I must reconnect to the ISP proxy server. It is as though some information
has been cached and then lost after a time??

Now I include a note from my ISP:


>Roger, as we discussed I think the problem is to do with the MTU being =
>used for TCP connections in combination with the 2.4.1 kernel and PPP.
>
>At any rate, what we have found from the packet dumps are when you use =
>kernel 2.2.16 and you set the MTU at 552 our cache receives SYN packets =
>from your host with a "mss" option set at 512 (MTU =3D 552 - IP header =
>(20) - TCP header (20)) (and here is a packet dump of that):
>
>19:29:33.146337 131.203.xxx.yyy.1028 > www.google.com.www: S =
>1878153551:1878153551(0) win 15872 <mss 512,sackOK,timestamp =
>614080,nop,wscale 0> (DF)
>
>however, when your 2.4.1 kernel also set with an MTU of 552 does the =
>same thing, we find a "mss" option set at 536 (MTU =3D 576 - IP header - =
>TCP header) not 552! Here is the packet trace:
>
>19:34:17.559674 131.203.xxx.yyy.32771 > www.google.com.www: S =
>2178626299:2178626299(0) win 2144 <mss 536,sackOK,timestamp =
>175390,nop,wscale 0> (DF)
>
>There is more in the trace that indicates packets with data segment =
>sizes of 536 are not getting through, and when the data segment drops to =
>468 it does get through, likewise with the 2.2.16 kernel packets only =
>get as big as 512 and they all get through ok.
>
>This indicates that although the MTU is being set to 552, this is being =
>ignored by the 2.4.1 kernel and it is using 576 instead.  Kernel 2.2.16 =
>correctly uses the 552 as specified.


This is as far as my understanding of the situation reaches. There
appear to be 3 interdependent elements:

	(1) the web browser
	(2) the 2.4.x kernel
	(3) the ISP transparent proxy server

Can anyone throw further light on this problem and/or suggest how to
fix it?  I'll say straight away that it has nothing to do with ECN
since this has not been selected as a kernel option.  Our analysis
seems to suggest that with 2.4.x the MTU is being incorrectly set, but
I don't know whether this is the whole explanation.

Thanks for any help you can provide...

Roger Young.
(roger@maths.grace.cri.nz)

...................................................................
Motherboard: GA-6VX7-4X with Via Apollo Pro AGP chipset
CPU: P3/733 MHz
Memory: 256 Mb SDRAM
Modem: Dynalink 56K external modem. Serial port IRQ4, I/O 03F8-03FF

Distribution: Slackware 7.1
Linux kernel(s): 2.4.1/2.4.0/2.2.16
PPP: 2.4.0. MTU 552
Netscape: 4.76
XFree86: 4.0.2
modutils: 2.4.1
binutils: 2.10.1
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://vger.kernel.org/lkml/
