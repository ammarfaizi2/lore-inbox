Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264498AbUDUJ76@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264498AbUDUJ76 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Apr 2004 05:59:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264512AbUDUJ76
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Apr 2004 05:59:58 -0400
Received: from cmsrelay02.mx.net ([165.212.11.111]:34812 "HELO
	cmsrelay02.mx.net") by vger.kernel.org with SMTP id S264498AbUDUJ74 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Apr 2004 05:59:56 -0400
X-USANET-Auth: 165.212.8.13    AUTO slansky@usa.net uwdvg013.cms.usa.net
Date: Wed, 21 Apr 2004 11:59:51 +0200
From: Petr Slansky <slansky@usa.net>
To: <linux-kernel@vger.kernel.org>
Subject: PROBLEM: serial port loopback serious bug
X-Mailer: USANET web-mailer (CM.0402.7.05)
Mime-Version: 1.0
Message-ID: <258iDuJ8z1872S13.1082541591@uwdvg013.cms.usa.net>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Description:

I observe the bug in kernel 2.4.21 and 2.4.22, I guess it is general problem
in 2.4.xx kernel. Command 'cat file >/dev/ttyS0' sends the first 4096 bytes
again and again...

DETAILS:

I have generic serial port on i586 machine (PC). I created loopback cable
(TX-RX and RTS-CTS pins connected) and conected the cable to serial port
ttyS0. Simple serial port loopback.

Configuration:
#stty 38400 raw clocal crtscts </dev/ttyS0

Command in console1 (capture ttyS0 to file):
#cat /dev/ttyS0 > fileI.bin

Command in console2 (send a longer file to ttyS0):
#cat fileO.bin >/dev/ttyS0

The file fileO.bin have to be at least 4096 bytes long.

I guess you know what is expected result but I bet you don't know real
result under Linux. I will tell you. Only first 4096 bytes are sent to
/dev/ttyS0. After that this sequence is read from /dev/ttyS0 again and
again..., even when no data are send to /dev/ttyS0 anymore. I tested this
sequence on FreeBSD 4.9 too and I had no problem with loopback like
this there. Something is seriosly wrong in kernel 2.4.x What about 2.6.x??

With regards,
Petr


---------------------------------
  Petr Slansky, slansky@usa.net
---------------------------------


