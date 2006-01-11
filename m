Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751478AbWAKNLg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751478AbWAKNLg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 08:11:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751479AbWAKNLg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 08:11:36 -0500
Received: from [194.67.67.195] ([194.67.67.195]:64196 "EHLO
	trinity.dezcom.mephi.ru") by vger.kernel.org with ESMTP
	id S1751478AbWAKNLf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 08:11:35 -0500
Date: Wed, 11 Jan 2006 16:06:52 +0300
From: Alexander Sbitnev <nwshuras@dezcom.mephi.ru>
X-Mailer: The Bat! (v3.0.1.33) UNREG / CD5BF9353B3B7091
X-Priority: 3 (Normal)
Message-ID: <204883.20060111160652@dezcom.mephi.ru>
To: linux-kernel@vger.kernel.org
Subject: SX8 stability issue
MIME-Version: 1.0
Content-Type: text/plain; charset=Windows-1251
Content-Transfer-Encoding: 8bit
X-DEZCOM-MailScanner: Found to be clean
X-DEZCOM-MailScanner-SpamCheck: not spam, SpamAssassin (score=-3.299,
	required 5, ALL_TRUSTED -3.30, BAYES_50 0.00)
X-MailScanner-From: nwshuras@dezcom.mephi.ru
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Working with Promise SX8 card for a while we still can't get NCQ
working stable for both original promise and vanilla kernel drivers.
We using latest firmware 1.00.0.37 and kernels from 2.6.8 up to 2.6.15.
Problems occured at least on two different hardware platforms.
We don't played with max_queue option (or it's header file analog value) yet,
keeping it on default value.
Controller work almost stable while NCQ option disabled in BIOS.
Once feature enabled in BIOS the system become hanging on IO with next
error messages appearing in the kernel log:

syslog.0:Jan 10 23:30:57 cell kernel: sx8(0000:01:06.0): unhandled event type 16
syslog.0:Jan 10 23:31:18 cell kernel: sx8(0000:01:06.0): unhandled event type 16
syslog.0:Jan 10 23:31:40 cell kernel: sx8(0000:01:06.0): unhandled event type 16
syslog.0:Jan 10 23:32:01 cell kernel: sx8(0000:01:06.0): unhandled event type 16
syslog.0:Jan 10 23:32:18 cell kernel: end_request: I/O error, dev sx8/0, sector 220064
syslog.0:Jan 10 23:32:18 cell kernel: Buffer I/O error on device sx8/0, logical block 27508
syslog.0:Jan 10 23:32:18 cell kernel: lost page write due to I/O error on sx8/0
syslog.0:Jan 10 23:32:18 cell kernel: Buffer I/O error on device sx8/0, logical block 27509
syslog.0:Jan 10 23:32:18 cell kernel: lost page write due to I/O error on sx8/0
syslog.0:Jan 10 23:32:18 cell kernel: Buffer I/O error on device sx8/0, logical block 27510

  We don't really sure this problem is a 100% linux related, but it is
still persist after big hardware upgrade (From dual Pentium III to
Dual Opteron based system recomended for this controller).
  Maybe it is not right way at all to turn NCQ in BIOS? Мауве we must
just increase max_queue parameter while keeping NCQ in BIOS disabled?



