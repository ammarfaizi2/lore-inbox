Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268197AbUHaMtA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268197AbUHaMtA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 08:49:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268144AbUHaMrR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 08:47:17 -0400
Received: from lax-gate3.raytheon.com ([199.46.200.232]:21359 "EHLO
	lax-gate3.raytheon.com") by vger.kernel.org with ESMTP
	id S268326AbUHaMqi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 08:46:38 -0400
Subject: Re: [patch] voluntary-preempt-2.6.9-rc1-bk4-Q5
To: Ingo Molnar <mingo@elte.hu>
Cc: "K.R. Foley" <kr@cybsft.com>, linux-kernel <linux-kernel@vger.kernel.org>,
       Felipe Alfaro Solana <lkml@felipe-alfaro.com>,
       Daniel Schmitt <pnambic@unu.nu>, Lee Revell <rlrevell@joe-job.com>
X-Mailer: Lotus Notes Release 5.0.8  June 18, 2001
Message-ID: <OF05BA5553.2755D604-ON86256F01.00456420@raytheon.com>
From: Mark_H_Johnson@raytheon.com
Date: Tue, 31 Aug 2004 07:46:08 -0500
X-MIMETrack: Serialize by Router on RTSHOU-DS01/RTS/Raytheon/US(Release 6.5.2|June 01, 2004) at
 08/31/2004 07:46:12 AM
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
X-SPAM: 0.00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>in theory the patch is more or less equivalent to setting
>netdev_max_backlog to a value of 1 - could you try that setting too?
>(with the patch unapplied.)

Ugh. That setting is VERY BAD. Just a quick test without
doing anything complex...
  # echo 1 > /proc/sys/net/core/netdev_max_backlog
  # ping dws7
  PING dws7 (192.52.215.17) 56(84) bytes of data.
[so the DNS lookup worked]
  From dws77... (192.52.215.87) icmp_seq=0 Destination Host Unreachable
  From dws77... (192.52.215.87) icmp_seq=1 Destination Host Unreachable
  From dws77... (192.52.215.87) icmp_seq=2 Destination Host Unreachable
  ...
[NOTE - these are plugged into the same 10/100 Ethernet switch]
  # echo 8 > /proc/sys/net/core/netdev_max_backlog
  # ping dws7
  PING dws7 (192.52.215.17) 56(84) bytes of data.
[so the DNS lookup worked]
  From dws77... (192.52.215.87) icmp_seq=0 ttl=64 time=2210 ms
  From dws77... (192.52.215.87) icmp_seq=1 ttl=64 time=1210 ms
  From dws77... (192.52.215.87) icmp_seq=2 ttl=64 time=210 ms
  From dws77... (192.52.215.87) icmp_seq=2 ttl=64 time=0.355 ms
  From dws77... (192.52.215.87) icmp_seq=2 ttl=64 time=0.397 ms
  ...
I tried again with 2, 3, and 4. Two appears to be "way too small" with
a ping of 1000 ms and nominal values of 0.800 ms. Three does not appear
to be good either with nominal values of 0.500 ms. Four has similar
results to eight (8).


--Mark H Johnson
  <mailto:Mark_H_Johnson@raytheon.com>

