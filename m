Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266727AbUGQNbm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266727AbUGQNbm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jul 2004 09:31:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266707AbUGQNbf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jul 2004 09:31:35 -0400
Received: from mail-gw0.york.ac.uk ([144.32.128.245]:28338 "EHLO
	mail-gw0.york.ac.uk") by vger.kernel.org with ESMTP id S266705AbUGQNbc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jul 2004 09:31:32 -0400
Message-ID: <019201c46c02$c6a84f30$68892090@grouse>
From: "Jee J.Z." <jz105@york.ac.uk>
To: <linux-kernel@vger.kernel.org>
Subject: Questions on Linux 2.4.20 TCP fast recovery and ECN implementation
Date: Sat, 17 Jul 2004 14:34:25 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1409
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
X-York-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear all,

I am really having problems understanding some linux 2.4.20 TCP
implementation behaviours (listed as follows). Any reply would be very much
appreciated.

1. Fast recovery trigger: I found (by ethereal traces) linux 2.4.20 TCP fast
recovery is usually triggered by only one duplicate ACK. I used to think
this is caused by FACK. However, even after I disable FACK by turning off
(set to 0) /proc/sys/net/ipv4/tcp_fack, the same phenomenon still happen.
Only when I disable SACK, fast recovery is triggered by 3 duplicate ACK. I
can't think of any explanation to this phenomenon.

2. FACK: Another issue related to FACK is that somebody said in linux 2.4
with FACK on, fast recovery is triggered on conditions: if ((snd.fack -
snd.una) > (N * MSS)) || (dupacks == 3), rather than what I have known: if
((snd.fack - snd.una) > (3 * MSS)) || (dupacks == 3), where N is dynamically
determined based on current network conditions such as reordering. However,
I can't find the codes implementing this algorithm. If this is true, could
anybody point me to the codes? Also, could anybody point me to the reference
decribing this algorithm in detail?

3. ECN implementation: As far as I read from a document, linux 2.4 ECN is
somewhat different from the standard rfc 2481/3168 in that linux 2.4 TCP
does not halve its congestion window at once on reception of a Congestion
Experenced packet, but only gradually decreases the congestion window to
half at the rate of one segment for two incoming ACKs. Is this true and are
there any paticular reasons for modifying linux 2.4 TCP like this? If I
don't remember wrong, linux 2.0 conforms to the standard in this issue.

I have been trying to search resources related to these issues for many days
but haven't found one really heuristic and useful. I would be very grateful
if anybody could help me out with any of these questions. Thank you very
much in advance!

Cheers,
Jee

