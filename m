Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750786AbVJCL6E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750786AbVJCL6E (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 07:58:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750793AbVJCL6E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 07:58:04 -0400
Received: from leo.gold.ac.uk ([158.223.1.4]:28810 "EHLO leo.gold.ac.uk")
	by vger.kernel.org with ESMTP id S1750786AbVJCL6D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 07:58:03 -0400
Date: Mon, 3 Oct 2005 12:56:20 +0100 (BST)
From: Martin Drallew <m.drallew@fatsquirrel.org>
To: linux-kernel@vger.kernel.org
Subject: Connection reset by peer - TCP window size oddity ?
Message-ID: <Pine.GSO.4.61.0510031241580.29231@scorpio.gold.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
X-Goldsmiths-MailScanner-Information: See http://www.gold.ac.uk/infos/cs/mailscanner/ for more information
X-Goldsmiths-MailScanner: Found to be clean
X-MailScanner-From: m.drallew@fatsquirrel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gurus,
apologies if this is a PEBKAC but I'm at my wits end with this one and 
have come to the conclusion, probably erroneously, that this may be a 
kernel bug.
In a nutshell, mail transactions from our SMTP server to a handful of 
remote servers consistently fail with a 'connection reset by peer' during 
the transfer. Usually only larger messages (ie with attachments) are 
affected.  A tcpdump follows and, unless I'm 
misunderstanding the output (quite possible) it looks like the kernel is 
sending outside of the peer's TCP window, to which the peer responds by 
resetting the connection.
Things to note:
'leo' is our server and 'otter' is the remote. Leo is a dual processor 
3GHz Xeon machine running 2.6.13.2. The problem was also there in 2.4.
The owners of otter claim that we are the only site that they have 
problems with.
The problem occurs less frequently if we force a stupidly small window 
size however otter seems immune.
The "interesting" part of the session begins at timestamp 624177. 
Everything up to that point is a healthy SMTP session.

Please could you CC me in on any replies as my mailbox takes enough of a 
daily beating already and lkml might just finish it off...

Many thanks in advance,
Martin

12:06:32.511347 leo.60039 > otter.smtp: S 3150703603:3150703603(0) win 5840 <mss 1460,sackOK,timestamp 41540072 0,nop,wscale 2> (DF)
12:06:32.519091 otter.smtp > leo.60039: S 1132102034:1132102034(0) ack 3150703604 win 1380 <mss 1380,sackOK,timestamp 2259256377 41540072,nop,wscale 2> (DF)
12:06:32.519103 leo.60039 > otter.smtp: . ack 1 win 1460 <nop,nop,timestamp 41540074 2259256377> (DF)
12:06:32.568277 otter.smtp > leo.60039: P 1:71(70) ack 1 win 1448 <nop,nop,timestamp 2259256425 41540074> (DF)
12:06:32.568284 leo.60039 > otter.smtp: . ack 71 win 1460 <nop,nop,timestamp 41540086 2259256425> (DF)
12:06:32.568306 leo.60039 > otter.smtp: P 1:22(21) ack 71 win 1460 <nop,nop,timestamp 41540086 2259256425> (DF)
12:06:32.575440 otter.smtp > leo.60039: . ack 22 win 1448 <nop,nop,timestamp 2259256433 41540086> (DF)
12:06:32.575481 otter.smtp > leo.60039: P 71:195(124) ack 22 win 1448 <nop,nop,timestamp 2259256433 41540086> (DF)
12:06:32.575514 leo.60039 > otter.smtp: P 22:107(85) ack 195 win 1460 <nop,nop,timestamp 41540088 2259256433> (DF)
12:06:32.616051 otter.smtp > leo.60039: P 195:273(78) ack 107 win 1448 <nop,nop,timestamp 2259256473 41540088> (DF)
12:06:32.616075 leo.60039 > otter.smtp: P 107:616(509) ack 273 win 1460 <nop,nop,timestamp 41540098 2259256473> (DF)
12:06:32.616095 leo.60039 > otter.smtp: P 616:1125(509) ack 273 win 1460 <nop,nop,timestamp 41540098 2259256473> (DF)
12:06:32.624177 otter.smtp > leo.60039: . ack 1125 win 1984 <nop,nop,timestamp 2259256481 41540098> (DF)
12:06:32.624183 leo.60039 > otter.smtp: P 1125:2493(1368) ack 273 win 1460 <nop,nop,timestamp 41540100 2259256481> (DF)
12:06:32.624200 leo.60039 > otter.smtp: P 2493:2652(159) ack 273 win 1460 <nop,nop,timestamp 41540100 2259256481> (DF)
12:06:32.624209 leo.60039 > otter.smtp: P 2652:3161(509) ack 273 win 1460 <nop,nop,timestamp 41540100 2259256481> (DF)
12:06:32.624540 otter.smtp > leo.60039: R 1132102307:1132102307(0) win 0
12:06:32.634407 otter.smtp > leo.60039: . ack 2652 win 3352 <nop,nop,timestamp 2259256490 41540100> (DF)
12:06:32.634437 leo.60039 > otter.smtp: R 3150706255:3150706255(0) win 0 (DF)
