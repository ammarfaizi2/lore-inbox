Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130170AbRBQBCa>; Fri, 16 Feb 2001 20:02:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129854AbRBQBCV>; Fri, 16 Feb 2001 20:02:21 -0500
Received: from 041imtd176.chartermi.net ([24.247.41.176]:58010 "EHLO
	oof.netnation.com") by vger.kernel.org with ESMTP
	id <S129634AbRBQBCP>; Fri, 16 Feb 2001 20:02:15 -0500
Date: Fri, 16 Feb 2001 20:02:11 -0500
From: Simon Kirby <sim@stormix.com>
To: linux-kernel@vger.kernel.org, davem@redhat.com
Cc: Alan Evetts <alane@netnation.com>
Subject: Re: 2.4 TCP(?) timeouts
Message-ID: <20010216200211.A14853@stormix.com>
In-Reply-To: <20010216190805.A14603@stormix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <20010216190805.A14603@stormix.com>; from sim@stormix.com on Fri, Feb 16, 2001 at 07:08:05PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 16, 2001 at 07:08:05PM -0500, Simon Kirby wrote:

> Hello,
> 
> Today we put 2.4.1 on our mail server after having see it perform well on
> some other boxes.  It seems now we are receiving a few calls every hour
> from customers reporting that the server tends to hang and eventually
> time out on them when downloading mail.  All customers that have reported
> this problem so far are on a didalup connection.  Apparently the server
> will stop transmitting data (or the client seems to think so), and then
> their mail client will time out.

We recorded a trace on the mail server end to one of the customers having
the problem.  At first they closed the connection because their mail
client was set to a timeout of 1 minute, but then when they changed it to
5 seconds, it seemed to limp along further.  It seems to me just like
there's a huge amount of packet loss, but pinging the machine just after
this shows 0% loss (just occasional jumps in response time).

During this trace, when long periods of nothing went by, "netstat -tan
|grep ip" showed nothing abnormal: a 0 byte receive queue and some
data in the send queue equal to what would be retransmitted and
eventually go through two minutes later.

nmap:
Remote operating system guess: Windows 2000 Professional, Build 2128

16:26:14.738836 < client.1104 > mail.pop3: S 1263956200:1263956200(0) win 8760 <mss 536,nop,nop,sackOK> (DF)
16:26:14.738888 > mail.pop3 > client.1104: S 26894293:26894293(0) ack 1263956201 win 5840 <mss 1460,nop,nop,sackOK> (DF)
16:26:15.014145 < client.1104 > mail.pop3: . 1:1(0) ack 1 win 9112 (DF)
16:26:15.014866 > mail.pop3 > client.1104: P 1:92(91) ack 1 win 5840 (DF)
16:26:15.291998 < client.1104 > mail.pop3: P 1:16(15) ack 92 win 9021 (DF)
16:26:15.292199 > mail.pop3 > client.1104: . 92:92(0) ack 16 win 5840 (DF)
16:26:15.292305 > mail.pop3 > client.1104: P 92:115(23) ack 16 win 5840 (DF)
16:26:16.686295 > mail.pop3 > client.1104: P 92:115(23) ack 16 win 5840 (DF)
16:26:16.954563 < client.1104 > mail.pop3: P 16:30(14) ack 115 win 8998 (DF)
16:26:16.976908 > mail.pop3 > client.1104: P 115:137(22) ack 30 win 5840 (DF)
16:26:19.776322 > mail.pop3 > client.1104: P 115:137(22) ack 30 win 5840 (DF)
16:26:20.033951 < client.1104 > mail.pop3: P 30:36(6) ack 137 win 8976 (DF)
16:26:20.034063 > mail.pop3 > client.1104: P 137:149(12) ack 36 win 5840 (DF)
16:26:25.626301 > mail.pop3 > client.1104: P 137:149(12) ack 36 win 5840 (DF)
16:26:25.922151 < client.1104 > mail.pop3: P 36:42(6) ack 149 win 8964 (DF)
16:26:25.922254 > mail.pop3 > client.1104: P 149:219(70) ack 42 win 5840 (DF)
16:26:36.949499 < client.1104 > mail.pop3: P 36:42(6) ack 149 win 8964 (DF)
16:26:36.949533 > mail.pop3 > client.1104: . 219:219(0) ack 42 win 5840 <nop,nop, sack 1 {36:42} > (DF)
16:26:37.116302 > mail.pop3 > client.1104: P 149:219(70) ack 42 win 5840 (DF)
16:26:37.380554 < client.1104 > mail.pop3: P 42:50(8) ack 219 win 8894 (DF)
16:26:37.380645 > mail.pop3 > client.1104: . 219:219(0) ack 50 win 5840 (DF)
16:26:37.380709 > mail.pop3 > client.1104: P 219:231(12) ack 50 win 5840 (DF)
16:26:59.567440 < client.1104 > mail.pop3: P 42:50(8) ack 219 win 8894 (DF)
16:26:59.567476 > mail.pop3 > client.1104: . 231:231(0) ack 50 win 5840 <nop,nop, sack 1 {42:50} > (DF)
16:26:59.776301 > mail.pop3 > client.1104: P 219:231(12) ack 50 win 5840 (DF)
16:27:00.043125 < client.1104 > mail.pop3: P 50:59(9) ack 231 win 8882 (DF)
16:27:00.043186 > mail.pop3 > client.1104: . 231:231(0) ack 59 win 5840 (DF)
16:27:00.043475 > mail.pop3 > client.1104: . 231:767(536) ack 59 win 5840 (DF)
16:27:00.043491 > mail.pop3 > client.1104: P 767:1220(453) ack 59 win 5840 (DF)
16:27:44.399831 < client.1104 > mail.pop3: P 50:59(9) ack 231 win 8882 (DF)
16:27:44.399869 > mail.pop3 > client.1104: . 1220:1220(0) ack 59 win 5840 <nop,nop, sack 1 {50:59} > (DF)
16:27:44.836304 > mail.pop3 > client.1104: . 231:767(536) ack 59 win 5840 (DF)
16:27:45.295946 < client.1104 > mail.pop3: . 59:59(0) ack 767 win 9112 (DF)
16:27:45.296003 > mail.pop3 > client.1104: P 767:1220(453) ack 59 win 5840 (DF)
16:29:14.886322 > mail.pop3 > client.1104: P 767:1220(453) ack 59 win 5840 (DF)
16:29:15.264417 < client.1104 > mail.pop3: P 59:67(8) ack 1220 win 8659 (DF)
16:29:15.264479 > mail.pop3 > client.1104: . 1220:1220(0) ack 67 win 5840 (DF)
16:29:15.265127 > mail.pop3 > client.1104: . 1220:1756(536) ack 67 win 5840 (DF)
16:29:15.265145 > mail.pop3 > client.1104: . 1756:2292(536) ack 67 win 5840 (DF)
16:30:45.187652 < client.1104 > mail.pop3: P 59:67(8) ack 1220 win 8659 (DF)
16:30:45.187727 > mail.pop3 > client.1104: . 2292:2292(0) ack 67 win 5840 <nop,nop, sack 1 {59:67} > (DF)
16:31:16.326378 > mail.pop3 > client.1104: . 1220:1756(536) ack 67 win 5840 (DF)
16:31:17.513053 < client.1104 > mail.pop3: . 67:67(0) ack 1756 win 9112 (DF)
16:31:17.513129 > mail.pop3 > client.1104: . 1756:2292(536) ack 67 win 5840 (DF)
16:31:17.513143 > mail.pop3 > client.1104: . 2292:2828(536) ack 67 win 5840 (DF)
16:33:17.506376 > mail.pop3 > client.1104: . 1756:2292(536) ack 67 win 5840 (DF)
16:33:17.919146 < client.1104 > mail.pop3: . 67:67(0) ack 2292 win 9112 (DF)
16:33:17.919198 > mail.pop3 > client.1104: . 2292:2828(536) ack 67 win 5840 (DF)
16:33:17.919211 > mail.pop3 > client.1104: . 2828:3364(536) ack 67 win 5840 (DF)
16:35:17.916383 > mail.pop3 > client.1104: . 2292:2828(536) ack 67 win 5840 (DF)
16:35:18.401250 < client.1104 > mail.pop3: . 67:67(0) ack 2828 win 9112 (DF)
16:35:18.401394 > mail.pop3 > client.1104: . 2828:3364(536) ack 67 win 5840 (DF)
16:35:18.401414 > mail.pop3 > client.1104: . 3364:3900(536) ack 67 win 5840 (DF)
16:37:18.396373 > mail.pop3 > client.1104: . 2828:3364(536) ack 67 win 5840 (DF)
16:37:21.763859 < client.1104 > mail.pop3: . 67:67(0) ack 3364 win 9112 (DF)
16:37:21.764049 > mail.pop3 > client.1104: . 3364:3900(536) ack 67 win 5840 (DF)
16:37:21.764062 > mail.pop3 > client.1104: . 3900:4436(536) ack 67 win 5840 (DF)
16:42:22.308578 < client.1104 > mail.pop3: F 67:67(0) ack 3364 win 9112 (DF)
16:42:22.308625 > mail.pop3 > client.1104: R 26897657:26897657(0) win 0 (DF)

I'm not sure how the last part happened, but I'm guessing the server was
waiting on the next transmit to send that it had already closed the
connection, and the RST was sent out as a response to the socket already
being closed locally when the customer eventually closed the connection.

Would any of the networking changes in 2.4.1pre3 affect what is happening
here?

Simon-

[  Stormix Technologies Inc.  ][  NetNation Communications Inc. ]
[       sim@stormix.com       ][       sim@netnation.com        ]
[ Opinions expressed are not necessarily those of my employers. ]
