Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265149AbUE0T6J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265149AbUE0T6J (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 May 2004 15:58:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265158AbUE0T6I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 May 2004 15:58:08 -0400
Received: from welcomes-you.com ([81.169.152.204]:39641 "EHLO welcomes-you.com")
	by vger.kernel.org with ESMTP id S265149AbUE0T5Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 May 2004 15:57:24 -0400
Message-ID: <40B6480D.60905@welcomes-you.com>
Date: Thu, 27 May 2004 21:57:01 +0200
From: Carsten Aulbert <carsten@welcomes-you.com>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040321)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: ACPI S3 fails to re-init NIC on Asus A7V
X-Enigmail-Version: 0.83.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-welcomes-you.com-MailScanner: Found to be clean
X-welcomes-you.com-MailScanner-SpamCheck: not spam,
	SpamAssassin (Wertung=3.271, benoetigt 5, RCVD_IN_DYNABLOCK 2.55,
	RCVD_IN_NJABL 0.10, RCVD_IN_NJABL_DIALUP 0.53, RCVD_IN_SORBS 0.10)
X-welcomes-you.com-MailScanner-SpamScore: sss
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Please consider the following problem:

Home Server (daisy):

Asus A7V board
Duron 650 MHz
Debian sarge (not 100% up2date right now - from March 22nd)
SiS900 (also tried 3Com 3c509-TX-M without a change)

Kernels tried:
2.4.22 (IIRC), 2.6.4, 2.6.4 with acpi-patch 20040311, 2.6.6

Suspending to S3 works fine, resume also (except with the 
onboard-Promise chip, but that's not a big issue), however, trying to 
use the network after resume gives
NETDEV WATCHDOG: eth0: transmit timed out

This also did not help:
/etc/init.d/networking stop
modprobe -r sis900
echo 3 > /proc/acpi/sleep

[resume]

modprobe sis900
-> module is loaded successfully
/etc/init.d/networking start
-> sets the static routes correctly
pinging a machine on the network yields the same error as before.

(Also tried 3Com 3c509-TXM to no avail)

To spare you about ~1000 lines of output, I've put the output of dmesg, 
lspci -v, acpidmp and an excerpt from /var/log/syslog with enabled 
sis900-debugging here
http://carsten.welcomes-you.com/misc-tmp/acpi-s3/

Does this problem ring any bell, do you need more input from my side? 
I'm currently running out of options and ideas.

TIA for any help

Carsten

PS: I'm not subscribed but monitor linux.kernel, but feel free to Cc me.
