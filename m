Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131017AbQKGFVI>; Tue, 7 Nov 2000 00:21:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131042AbQKGFU6>; Tue, 7 Nov 2000 00:20:58 -0500
Received: from 64.124.41.10.napster.com ([64.124.41.10]:35594 "EHLO
	foobar.napster.com") by vger.kernel.org with ESMTP
	id <S131017AbQKGFUp>; Tue, 7 Nov 2000 00:20:45 -0500
Message-ID: <3A079127.47B2B14C@napster.com>
Date: Mon, 06 Nov 2000 21:20:39 -0800
From: Jordan Mendelson <jordy@napster.com>
Organization: Napster, Inc.
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Poor TCP Performance 2.4.0-10 <-> Win98 SE PPP
In-Reply-To: <3A07662F.39D711AE@napster.com> <200011070428.UAA01710@pizda.ninka.net>
Content-Type: multipart/mixed;
 boundary="------------6346C8BEF2FBA6A7895FD23E"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------6346C8BEF2FBA6A7895FD23E
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

"David S. Miller" wrote:
> 
>    Date:        Mon, 06 Nov 2000 18:17:19 -0800
>    From: Jordan Mendelson <jordy@napster.com>
> 
>    18:54:57.394894 eth0 > 64.124.41.177.8888 > 209.179.248.69.1238: .
>    2429:2429(0) ack 506 win 6432 <nop,nop, sack 1 {456:506} > (DF)
> 
> And this is it?  The connection dies right here and says no
> more?  Surely, there was more said on this connection after
> this point.
> 
> Otherwise I see nothing obviously wrong in these dumps.

I've provided two new dumps of the complete connection lifetime between
2.4.0 and 2.2.16. Both logs show the same client connecting to identical
machines, receiving the same data and then disconnecting.

2.2.16 handles the entire process in under 5 seconds while 2.4.0 takes
over 2 minutes.

Also note that the 2.4.0 connection did not get shut down correctly and
had to send an RST... though this is probably due to the client side
closing down the connection while there was still data on it. Both
machines were under approximately the same load.

It looks to me like there is an artificial delay in 2.4.0 which is
slowing down the traffic to unbearable levels. 


Jordan
--------------6346C8BEF2FBA6A7895FD23E
Content-Type: text/plain; charset=us-ascii;
 name="240.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="240.log"

22:00:39.625351 209.179.245.186.1092 > 64.124.41.179.8888: S 4155530:4155530(0) win 8192 <mss 536,nop,nop,sackOK> (DF)
22:00:39.625437 64.124.41.179.8888 > 209.179.245.186.1092: S 1301092473:1301092473(0) ack 4155531 win 5840 <mss 1460,nop,nop,sackOK> (DF)
22:00:39.887133 209.179.245.186.1092 > 64.124.41.179.8888: . ack 1 win 8576 (DF)
22:00:39.887969 209.179.245.186.1092 > 64.124.41.179.8888: . ack 1 win 65280 (DF)
22:00:39.888951 209.179.245.186.1092 > 64.124.41.179.8888: P 1:44(43) ack 1 win 65280 (DF)
22:00:39.888964 64.124.41.179.8888 > 209.179.245.186.1092: . ack 44 win 5840 (DF)
22:00:39.991515 64.124.41.179.8888 > 209.179.245.186.1092: P 1:21(20) ack 44 win 5840 (DF)
22:00:39.991660 64.124.41.179.8888 > 209.179.245.186.1092: P 21:557(536) ack 44 win 5840 (DF)
22:00:42.991490 64.124.41.179.8888 > 209.179.245.186.1092: P 1:21(20) ack 44 win 5840 (DF)
22:00:43.180946 209.179.245.186.1092 > 64.124.41.179.8888: P 44:56(12) ack 21 win 65260 (DF)
22:00:43.180997 64.124.41.179.8888 > 209.179.245.186.1092: P 21:557(536) ack 44 win 5840 (DF)
22:00:43.181025 64.124.41.179.8888 > 209.179.245.186.1092: P 557:1093(536) ack 56 win 5840 (DF)
22:00:45.685143 209.179.245.186.1092 > 64.124.41.179.8888: P 44:456(412) ack 21 win 65260 (DF)
22:00:45.685204 64.124.41.179.8888 > 209.179.245.186.1092: . ack 456 win 6432 <nop,nop, sack 1 {44:56} > (DF)
22:00:49.171046 64.124.41.179.8888 > 209.179.245.186.1092: P 21:557(536) ack 456 win 6432 (DF)
22:00:49.470193 209.179.245.186.1092 > 64.124.41.179.8888: . ack 557 win 65280 (DF)
22:00:49.470233 64.124.41.179.8888 > 209.179.245.186.1092: P 557:1093(536) ack 456 win 6432 (DF)
22:00:49.470248 64.124.41.179.8888 > 209.179.245.186.1092: P 1093:1629(536) ack 456 win 6432 (DF)
22:01:01.461056 64.124.41.179.8888 > 209.179.245.186.1092: P 557:1093(536) ack 456 win 6432 (DF)
22:01:01.755362 209.179.245.186.1092 > 64.124.41.179.8888: . ack 1093 win 65280 (DF)
22:01:01.755428 64.124.41.179.8888 > 209.179.245.186.1092: P 1093:1629(536) ack 456 win 6432 (DF)
22:01:01.755451 64.124.41.179.8888 > 209.179.245.186.1092: P 1629:1825(196) ack 456 win 6432 (DF)
22:01:25.751048 64.124.41.179.8888 > 209.179.245.186.1092: P 1093:1629(536) ack 456 win 6432 (DF)
22:01:26.171932 209.179.245.186.1092 > 64.124.41.179.8888: . ack 1629 win 65280 (DF)
22:01:26.171979 64.124.41.179.8888 > 209.179.245.186.1092: P 1629:1825(196) ack 456 win 6432 (DF)
22:02:14.171052 64.124.41.179.8888 > 209.179.245.186.1092: P 1629:1825(196) ack 456 win 6432 (DF)
22:02:14.499920 209.179.245.186.1092 > 64.124.41.179.8888: . ack 1825 win 65084 (DF)
22:02:14.499944 64.124.41.179.8888 > 209.179.245.186.1092: P 1825:1847(22) ack 456 win 6432 (DF)
22:02:16.168708 209.179.245.186.1092 > 64.124.41.179.8888: F 456:456(0) ack 1825 win 65084 (DF)
22:02:16.181061 64.124.41.179.8888 > 209.179.245.186.1092: . ack 457 win 6432 (DF)
22:02:16.281724 64.124.41.179.8888 > 209.179.245.186.1092: F 1847:1847(0) ack 457 win 6432 (DF)
22:02:16.477943 209.179.245.186.1092 > 64.124.41.179.8888: . ack 1825 win 65084 <nop,nop, sack 1 {1847:1848} > (DF)
22:03:50.491063 64.124.41.179.8888 > 209.179.245.186.1092: P 1825:1847(22) ack 457 win 6432 (DF)
22:03:50.680141 209.179.245.186.1092 > 64.124.41.179.8888: R 4155987:4155987(0) win 0 (DF)

--------------6346C8BEF2FBA6A7895FD23E
Content-Type: text/plain; charset=us-ascii;
 name="2216.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="2216.log"

22:00:01.684927 209.179.245.186.1091 > 64.124.41.136.8888: S 4033171:4033171(0) win 8192 <mss 536,nop,nop,sackOK> (DF)
22:00:01.685021 64.124.41.136.8888 > 209.179.245.186.1091: S 1261602556:1261602556(0) ack 4033172 win 32696 <mss 536,nop,nop,sackOK> (DF)
22:00:01.916120 209.179.245.186.1091 > 64.124.41.136.8888: . ack 1 win 8576 (DF)
22:00:01.916191 209.179.245.186.1091 > 64.124.41.136.8888: . ack 1 win 65280 (DF)
22:00:01.916981 209.179.245.186.1091 > 64.124.41.136.8888: P 1:44(43) ack 1 win 65280 (DF)
22:00:01.917032 64.124.41.136.8888 > 209.179.245.186.1091: . ack 44 win 32696 (DF)
22:00:02.121143 64.124.41.136.8888 > 209.179.245.186.1091: P 1:21(20) ack 44 win 32696 (DF)
22:00:02.121279 64.124.41.136.8888 > 209.179.245.186.1091: P 21:349(328) ack 44 win 32696 (DF)
22:00:02.327779 209.179.245.186.1091 > 64.124.41.136.8888: . ack 349 win 64932 (DF)
22:00:02.327813 64.124.41.136.8888 > 209.179.245.186.1091: P 349:885(536) ack 44 win 32696 (DF)
22:00:02.327825 64.124.41.136.8888 > 209.179.245.186.1091: P 885:1408(523) ack 44 win 32696 (DF)
22:00:02.328909 209.179.245.186.1091 > 64.124.41.136.8888: P 44:56(12) ack 349 win 64932 (DF)
22:00:02.340110 64.124.41.136.8888 > 209.179.245.186.1091: . ack 56 win 32696 (DF)
22:00:02.605282 209.179.245.186.1091 > 64.124.41.136.8888: P 56:456(400) ack 885 win 65280 (DF)
22:00:02.608462 209.179.245.186.1091 > 64.124.41.136.8888: . ack 1408 win 64757 (DF)
22:00:02.608533 64.124.41.136.8888 > 209.179.245.186.1091: P 1408:1420(12) ack 456 win 32296 (DF)
22:00:02.766833 64.124.41.136.8888 > 209.179.245.186.1091: P 1420:1689(269) ack 456 win 32696 (DF)
22:00:02.889731 209.179.245.186.1091 > 64.124.41.136.8888: . ack 1420 win 64745 (DF)
22:00:03.091796 209.179.245.186.1091 > 64.124.41.136.8888: . ack 1689 win 65280 (DF)
22:00:03.091829 64.124.41.136.8888 > 209.179.245.186.1091: P 1689:1822(133) ack 456 win 32696 (DF)
22:00:03.388700 209.179.245.186.1091 > 64.124.41.136.8888: . ack 1822 win 65147 (DF)
22:00:04.442114 209.179.245.186.1091 > 64.124.41.136.8888: F 456:456(0) ack 1822 win 65147 (DF)
22:00:04.442178 64.124.41.136.8888 > 209.179.245.186.1091: . ack 457 win 32696 (DF)
22:00:04.502433 64.124.41.136.8888 > 209.179.245.186.1091: F 1822:1822(0) ack 457 win 32696 (DF)
22:00:04.689026 209.179.245.186.1091 > 64.124.41.136.8888: . ack 1823 win 65147 (DF)

--------------6346C8BEF2FBA6A7895FD23E--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
