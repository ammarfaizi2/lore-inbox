Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286378AbRLTVFs>; Thu, 20 Dec 2001 16:05:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286374AbRLTVFg>; Thu, 20 Dec 2001 16:05:36 -0500
Received: from moremagic.merlins.org ([204.80.101.251]:7391 "EHLO
	mail2.merlins.org") by vger.kernel.org with ESMTP
	id <S286380AbRLTVFc>; Thu, 20 Dec 2001 16:05:32 -0500
Date: Thu, 20 Dec 2001 13:05:30 -0800
From: Marc MERLIN <marc_ln@merlins.org>
To: linux-net@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: TCP stall between 2.4.14-patched and Win XP ?
Message-ID: <20011220130530.Q16402@merlins.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
X-Sysadmin: BOFH
X-URL: http://marc.merlins.org/
X-Operating-System: Proudly running Linux 2.4.14-lvm1.0.1rc4-ext3-0.9.15-grsec-1.8.8-servers11/Debian woody
X-Mailer: Some Outlooks can't quote properly without this header
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I couldn't find any other reports of this after a search.
I'm also not sure if it belongs on linux-net or linux-kernel.
Please edit Cc as appropriate.

I have the following kernel on my mail server:
2.4.14-lvm1.0.1rc4-ext3-0.9.15-grsec-1.8.8-servers11

I'm  fairly sure  I  have  disabled the  grsecurity  options  that could  be
causing this problem.

The XP  machine connects to  the linux box, packets  go back and  forth, and
when the linux machine starts pushing a  lot of data back, XP lowers the TCP
window until the connection stalls.

11:59:43.055725 10.1.14.206.2501 > 10.1.0.4.143: S 3253452870:3253452870(0) win 64240 <mss 1460,nop,nop,sackOK> (DF)
11:59:43.055794 10.1.0.4.143 > 10.1.14.206.2501: S 1021273236:1021273236(0) ack 3253452871 win 5840 <mss 1460,nop,nop,sackOK> (DF)
11:59:43.056813 10.1.14.206.2501 > 10.1.0.4.143: . ack 1 win 64240 (DF)
11:59:43.132647 10.1.0.4.143 > 10.1.14.206.2501: P 1:159(158) ack 1 win 5840 (DF)

(non relevant packets removed here)

11:59:45.055507 10.1.0.4.143 > 10.1.14.206.2501: . 232536:233996(1460) ack 1322 win 7070 (DF)
11:59:45.055701 10.1.14.206.2501 > 10.1.0.4.143: . ack 196036 win 48304 (DF)
11:59:45.055806 10.1.0.4.143 > 10.1.14.206.2501: . 233996:235456(1460) ack 1322 win 7070 (DF)
11:59:45.055827 10.1.0.4.143 > 10.1.14.206.2501: . 235456:236916(1460) ack 1322 win 7070 (DF)
11:59:45.055840 10.1.0.4.143 > 10.1.14.206.2501: . 236916:238376(1460) ack 1322 win 7070 (DF)
11:59:45.056800 10.1.14.206.2501 > 10.1.0.4.143: . ack 198956 win 45384 (DF)
11:59:45.056856 10.1.0.4.143 > 10.1.14.206.2501: . 238376:239836(1460) ack 1322 win 7070 (DF)
11:59:45.056868 10.1.0.4.143 > 10.1.14.206.2501: . 239836:241296(1460) ack 1322 win 7070 (DF)
11:59:45.056879 10.1.0.4.143 > 10.1.14.206.2501: . 241296:242756(1460) ack 1322 win 7070 (DF)
11:59:45.056803 10.1.14.206.2501 > 10.1.0.4.143: . ack 201876 win 42464 (DF)
11:59:45.056907 10.1.0.4.143 > 10.1.14.206.2501: . 242756:244216(1460) ack 1322 win 7070 (DF)
11:59:45.056805 10.1.14.206.2501 > 10.1.0.4.143: . ack 204796 win 39544 (DF)
11:59:45.057046 10.1.14.206.2501 > 10.1.0.4.143: . ack 207716 win 36624 (DF)
11:59:45.058221 10.1.14.206.2501 > 10.1.0.4.143: . ack 210636 win 33704 (DF)
11:59:45.058226 10.1.14.206.2501 > 10.1.0.4.143: . ack 213556 win 30784 (DF)
11:59:45.058229 10.1.14.206.2501 > 10.1.0.4.143: . ack 216476 win 27864 (DF)
11:59:45.058401 10.1.14.206.2501 > 10.1.0.4.143: . ack 219396 win 24944 (DF)
11:59:45.059254 10.1.14.206.2501 > 10.1.0.4.143: . ack 222316 win 22024 (DF)
11:59:45.059257 10.1.14.206.2501 > 10.1.0.4.143: . ack 225236 win 19104 (DF)
11:59:45.059259 10.1.14.206.2501 > 10.1.0.4.143: . ack 228156 win 16184 (DF)
11:59:45.059626 10.1.14.206.2501 > 10.1.0.4.143: . ack 231076 win 13264 (DF)
11:59:45.060719 10.1.14.206.2501 > 10.1.0.4.143: . ack 233996 win 10344 (DF)
11:59:45.060721 10.1.14.206.2501 > 10.1.0.4.143: . ack 236916 win 7424 (DF)
11:59:45.060723 10.1.14.206.2501 > 10.1.0.4.143: . ack 239836 win 4504 (DF)
11:59:45.060856 10.1.14.206.2501 > 10.1.0.4.143: . ack 242756 win 1584 (DF)
11:59:45.216677 10.1.14.206.2501 > 10.1.0.4.143: . ack 244216 win 124 (DF)
11:59:45.475957 10.1.0.4.143 > 10.1.14.206.2501: P 244216:244340(124) ack 1322 win 7070 (DF)
11:59:45.617484 10.1.14.206.2501 > 10.1.0.4.143: . ack 244340 win 0 (DF)
11:59:45.915892 10.1.0.4.143 > 10.1.14.206.2501: . ack 1322 win 7070 (DF)
11:59:45.916288 10.1.14.206.2501 > 10.1.0.4.143: . ack 244340 win 0 (DF)
11:59:46.515834 10.1.0.4.143 > 10.1.14.206.2501: . ack 1322 win 7070 (DF)
(...)

It's stalled here


I can't quite reboot  my mail server with another kernel  right now (to take
grsec completely  out of the  picture), but I  believe there may  be network
settings in /proc that I could play with to help solve this.

The trace (in tcpdump/ethereal) format can be found here:
http://marc.merlins.org/tmp/trace_stall_excerpt.gz

The full trace (showing earlier half stalls):
http://marc.merlins.org/tmp/trace_stall.gz
(I removed a few packets with account/password handshake)

Any suggestions?

Thanks,
Marc
-- 
Microsoft is to operating systems & security ....
                                      .... what McDonalds is to gourmet cooking
  
Home page: http://marc.merlins.org/   |   Finger marc_f@merlins.org for PGP key
