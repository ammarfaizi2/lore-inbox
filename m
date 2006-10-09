Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932482AbWJILjx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932482AbWJILjx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 07:39:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932484AbWJILjx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 07:39:53 -0400
Received: from rrzmta2.rz.uni-regensburg.de ([132.199.1.17]:14043 "EHLO
	rrzmta2.rz.uni-regensburg.de") by vger.kernel.org with ESMTP
	id S932482AbWJILjw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 07:39:52 -0400
From: "Ulrich Windl" <ulrich.windl@rz.uni-regensburg.de>
Organization: Universitaet Regensburg, Klinikum
To: linux-kernel@vger.kernel.org
Date: Mon, 09 Oct 2006 13:39:34 +0200
MIME-Version: 1.0
Subject: Q: I/O to block devices
Message-ID: <452A5115.27596.1451223@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de>
X-mailer: Pegasus Mail for Windows (4.31)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
X-Content-Conformance: HerringScan-0.25/Sophos-P=4.10.0+V=4.10+U=2.07.149+R=02 October 2006+T=192327@20061009.112604Z
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

I'm surprised: To my knowledge I/O to block devices is synchronous (at least write 
I thought), but:

Trying to sort my Compact Flash cards according to speed I did these tests:
1. Plug in card
2. dd if=/dev/sda of=disk_file
3. Record numbers printed for reading the card (they roughly correspond to those 
of "hdparm -t")
4. dd of=/dev/sda if=disk_file
5. Record the numbers printed for write speed

At that time I realized that write was terribly fast; way too fast. When unpluggin 
the card, replugging the card, and redoing step 4. and 5., the speed was as 
expected.

Now the first big question: Does the Linux kernel suppress writes if it knows the 
data are already on the block device? That seems to be the only possible 
explanation for that.

Then we all know that sync writes suddenly became very slow in the near past. When 
using "oflag=dsync" for the dd command in step 4., the data rate was as low as 
22kB/s (!!!). I would expect unbuffered writes with a speed of at least 500kB/s.
Now the second big question: Where did I/O speed go?

If some kind sould would answer, or point me to an answer, that would be very much 
appreciated (Please CC: to me, I'm not subscribed here).

The system used for testing was SuSE Linux 10.1 with a built-in USB 2.0 card 
reader, and the rest of the system is definitely not the reason for this type of 
slowdown.

Regards,
Ulrich

