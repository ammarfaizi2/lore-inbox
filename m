Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030184AbVKBXD6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030184AbVKBXD6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 18:03:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965333AbVKBXD6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 18:03:58 -0500
Received: from www.eclis.ch ([144.85.15.72]:37086 "EHLO mail.eclis.ch")
	by vger.kernel.org with ESMTP id S965332AbVKBXD5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 18:03:57 -0500
Message-ID: <4369464B.6040707@eclis.ch>
Date: Thu, 03 Nov 2005 00:05:47 +0100
From: Jean-Christian de Rivaz <jc@eclis.ch>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20051002)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: NTP broken with 2.6.14
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Since I have installed the new kernel 2.6.14, ntpd is unable to
synchronize the time:

talla:~# ntpq
ntpq> pe
      remote           refid      st t when poll reach   delay   offset 
  jitter
==============================================================================
  10.0.0.1        129.132.2.21     3 u   25   64  377    0.871  -88310. 
4885.09
ntpq> as

ind assID status  conf reach auth condition  last_event cnt
===========================================================
   1 14484  9014   yes   yes  none    reject   reachable  1
ntpq> rv 14484
assID=14484 status=9014 reach, conf, 1 event, event_reach,
srcadr=10.0.0.1, srcport=123, dstadr=10.0.33.10, dstport=123, leap=00,
stratum=3, precision=-17, rootdelay=37.842, rootdispersion=59.311,
refid=129.132.2.21, reach=377, unreach=0, hmode=3, pmode=4, hpoll=6,
ppoll=6, flash=00 ok, keyid=0, ttl=0, offset=-88310.312, delay=0.871,
dispersion=2.484, jitter=4885.096,
reftime=c713bf2b.ed424e59  Wed, Nov  2 2005 23:41:47.926,
org=c713c16b.0e8ee6b8  Wed, Nov  2 2005 23:51:23.056,
rec=c713c1c6.a420b3d4  Wed, Nov  2 2005 23:52:54.641,
xmt=c713c1c6.a3c7f77a  Wed, Nov  2 2005 23:52:54.639,
filtdelay=     0.89    0.89    0.87    0.88    0.90    0.88    0.90    0.90,
filtoffset= -91583. -90207. -88310. -86973. -85104. -83843. -81507. -79682.,
filtdisp=      0.01    0.96    1.93    2.88    3.85    4.83    5.79    6.75
ntpq>

The offset alway grow without correction from ntpd. This was perfectly
working with the previouse 2.6.8 kernel used on this machine and the
10.0.0.1 router still work as others machines on the network work well
at the same time:

craie:~# ntpq -p
      remote           refid      st t when poll reach   delay   offset 
  jitter
==============================================================================
*10.0.0.1        129.132.2.21     3 u  636 1024  377    1.170    2.184 
0.369

 From the /var/log/ntpstats/peerstats history, the offset start growing
exactly at the same time I rebooted with the new 2.6.14 kernel. The ntpd
is the from the Debian Sarge version "ntpd 4.2.0a@1:4.2.0a+stable-2-r
Fri Aug 26 10:30:12 UTC 2005 (1)".
-- 
Jean-Christian de Rivaz
