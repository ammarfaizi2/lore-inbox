Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263021AbUCVVBD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Mar 2004 16:01:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262101AbUCVVBD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Mar 2004 16:01:03 -0500
Received: from bay15-f28.bay15.hotmail.com ([65.54.185.28]:17 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S263021AbUCVVA4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Mar 2004 16:00:56 -0500
X-Originating-IP: [132.177.117.88]
X-Originating-Email: [mk_26@hotmail.com]
From: "m k" <mk_26@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: Linux TCP implementation
Date: Mon, 22 Mar 2004 20:58:46 +0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <BAY15-F28psNhnM7kl300089ffe@hotmail.com>
X-OriginalArrivalTime: 22 Mar 2004 20:58:46.0367 (UTC) FILETIME=[77A0C6F0:01C41050]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

      I am working with 2.4.21 kernel for iSCSI performance study. I have a 
question
regarding the congestion avoidance algorithm used in the linux TCP 
implementation.
After dumping the value of the snd_cwnd, snd_ssthresh and snd_cwnd_clamp 
when
the tcp_cong_avoid function is called, I observed that the value of 
snd_ssthresh
was always set to a value of 2147483647 and the value of snd_cwnd_clamp was 
set to 65535.
If the snd_cwnd is not be more than the snd_cwnd_clamp, the else part of the
function is never executed, as snd_cwnd is never going to be more than 
snd_ssthresh.
	Also, if the snd_cwnd is maintained in terms of packets and snd_ssthresh 
and
snd_cwnd_clamp is maintained in terms of bytes, how come the comparison 
between them.


static __inline__ void tcp_cong_avoid(struct tcp_opt *tp)
{
         if (tp->snd_cwnd <= tp->snd_ssthresh) {
                 /* In "safe" area, increase. */
                 if (tp->snd_cwnd < tp->snd_cwnd_clamp)
                         tp->snd_cwnd++;
         } else {
                 /* In dangerous area, increase slowly.
                  * In theory this is tp->snd_cwnd += 1 / tp->snd_cwnd
                  */
                 if (tp->snd_cwnd_cnt >= tp->snd_cwnd) {
                         if (tp->snd_cwnd < tp->snd_cwnd_clamp)
                                 tp->snd_cwnd++;
                         tp->snd_cwnd_cnt=0;
                 } else
                         tp->snd_cwnd_cnt++;
         }
         tp->snd_cwnd_stamp = tcp_time_stamp;
}

var/log/messages:
Mar 22 15:08:20 jupiter kernel: snd_cwnd: 2, snd_ssthresh: 2147483647, 
snd_cwnd_clamp: 65535
Mar 22 15:08:20 jupiter kernel: snd_cwnd: 3, snd_ssthresh: 2147483647, 
snd_cwnd_clamp: 65535
Mar 22 15:08:20 jupiter kernel: snd_cwnd: 4, snd_ssthresh: 2147483647, 
snd_cwnd_clamp: 65535
Mar 22 15:08:20 jupiter kernel: snd_cwnd: 5, snd_ssthresh: 2147483647, 
snd_cwnd_clamp: 65535
Mar 22 15:08:20 jupiter kernel: snd_cwnd: 6, snd_ssthresh: 2147483647, 
snd_cwnd_clamp: 65535
Mar 22 15:08:20 jupiter kernel: snd_cwnd: 7, snd_ssthresh: 2147483647, 
snd_cwnd_clamp: 65535
Mar 22 15:08:20 jupiter kernel: snd_cwnd: 8, snd_ssthresh: 2147483647, 
snd_cwnd_clamp: 65535
Mar 22 15:08:20 jupiter kernel: snd_cwnd: 9, snd_ssthresh: 2147483647, 
snd_cwnd_clamp: 65535
Mar 22 15:08:20 jupiter kernel: snd_cwnd: 10, snd_ssthresh: 2147483647, 
snd_cwnd_clamp: 65535
Mar 22 15:08:20 jupiter kernel: snd_cwnd: 11, snd_ssthresh: 2147483647, 
snd_cwnd_clamp: 65535
Mar 22 15:08:20 jupiter kernel: snd_cwnd: 12, snd_ssthresh: 2147483647, 
snd_cwnd_clamp: 65535
Mar 22 15:08:20 jupiter kernel: snd_cwnd: 13, snd_ssthresh: 2147483647, 
snd_cwnd_clamp: 65535
Mar 22 15:08:20 jupiter kernel: snd_cwnd: 14, snd_ssthresh: 2147483647, 
snd_cwnd_clamp: 65535
Mar 22 15:08:20 jupiter kernel: snd_cwnd: 15, snd_ssthresh: 2147483647, 
snd_cwnd_clamp: 65535
Mar 22 15:08:20 jupiter kernel: snd_cwnd: 16, snd_ssthresh: 2147483647, 
snd_cwnd_clamp: 65535
Mar 22 15:08:20 jupiter kernel: snd_cwnd: 17, snd_ssthresh: 2147483647, 
snd_cwnd_clamp: 65535
Mar 22 15:08:20 jupiter kernel: snd_cwnd: 18, snd_ssthresh: 2147483647, 
snd_cwnd_clamp: 65535
Mar 22 15:08:20 jupiter kernel: snd_cwnd: 19, snd_ssthresh: 2147483647, 
snd_cwnd_clamp: 65535
Mar 22 15:08:20 jupiter kernel: snd_cwnd: 20, snd_ssthresh: 2147483647, 
snd_cwnd_clamp: 65535
Mar 22 15:08:20 jupiter kernel: snd_cwnd: 21, snd_ssthresh: 2147483647, 
snd_cwnd_clamp: 65535
Mar 22 15:08:20 jupiter kernel: snd_cwnd: 22, snd_ssthresh: 2147483647, 
snd_cwnd_clamp: 65535


Any insight on this topic would be appreciated.

Thanks,
k

_________________________________________________________________
Get rid of annoying pop-up ads with the new MSN Toolbar – FREE! 
http://clk.atdmt.com/AVE/go/onm00200414ave/direct/01/

