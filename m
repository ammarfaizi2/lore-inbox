Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267819AbUHUU4Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267819AbUHUU4Q (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Aug 2004 16:56:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267817AbUHUUyU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Aug 2004 16:54:20 -0400
Received: from qfep05.superonline.com ([212.252.122.162]:3229 "EHLO
	qfep05.superonline.com") by vger.kernel.org with ESMTP
	id S267819AbUHUUxG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Aug 2004 16:53:06 -0400
From: "Josan Kadett" <corporate@superonline.com>
To: "'Lee Revell'" <rlrevell@joe-job.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: Entirely ignoring TCP and UDP checksum in kernel level
Date: Sat, 21 Aug 2004 23:53:07 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
In-Reply-To: <1093121172.854.157.camel@krustophenia.net>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Thread-Index: AcSHv+hbvyRMO5BZRmGVjW9uQkfcGgACH7zg
Message-Id: <S267819AbUHUUxG/20040821205355Z+891@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Indeed I already had done that UDP and TCP patch before I posted this
thread. I think that is still not the way... I just tested the system using
the generic patch and the results are;

- I send a packet with wrong checksum to a closed UDP port, the kernel
replies it (It would seem that UDP checksum is gone but no)
- I send a packet with wrong checksum to a closed TCP port, the kernel drops
it (TCP will not budge)
- I send a packet with wrong checksum to an open UDP port, the kernel drops
it. (UDP checksum is still in effect somehow)
- I send an snmpget request to my client, intercept the packet, re-send it
to the linux machine which is pathced, snmpget gets the correct data
- I send an snmpget request to my client, intercept the packet, put arbitary
(wrong) checksum in it, re-send it to the linux machine which is patched,
snmpget does not even see the data coming in. (Still dropped by kernel)

Perhaps I should start another thread with another subject instead of
blindly trying to get rid of checksum? 

-----Original Message-----
From: Lee Revell [mailto:rlrevell@joe-job.com] 
Sent: Saturday, August 21, 2004 10:46 PM
To: Josan Kadett
Cc: linux-kernel
Subject: RE: Entirely ignoring TCP and UDP checksum in kernel level

On Sat, 2004-08-21 at 17:41, Josan Kadett wrote:
> I added the patch, indeed this was just one of the few modifications I
tried
> before. The result is failure, the TCP/IP stack still does the checksum...
> Perhaps after this modification, the condition that the packet is not
> "eaten" may not be telling the system that there is a checksum error, but
> instead, just dropping packets by not igniting the TCP ACK function.

Please try Kalin's suggestion, instead of my patch.  It's more generic,
plus my 'patch' didn't handle UDP.

Lee




