Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268540AbUH3QkI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268540AbUH3QkI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Aug 2004 12:40:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268539AbUH3QkG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Aug 2004 12:40:06 -0400
Received: from users.linvision.com ([62.58.92.114]:7658 "HELO bitwizard.nl")
	by vger.kernel.org with SMTP id S268540AbUH3Qje (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Aug 2004 12:39:34 -0400
Date: Mon, 30 Aug 2004 18:39:31 +0200
From: Rogier Wolff <R.E.Wolff@harddisk-recovery.nl>
To: linux-kernel@vger.kernel.org
Cc: linux-ide@vger.kernel.org
Subject: Driver retries disk errors. 
Message-ID: <20040830163931.GA4295@bitwizard.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organization: Harddisk-recovery.nl
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi, 

We encounter "bad" drives with quite a lot more regularity than other
people (look at the Email address). We're however, wondering why the
IDE code still retries a bad block 8 times? By the time the drive
reports "bad block" it has already tried it several times, including a
bunch of "recalibrates" etc etc. For comparison, the Scsi-disk driver
doesn't do any retrying.

So, why do we still do this?

- The driver may still work for MFM drives and less "intelligent"
  controllers?

- Someone has recently seen that this actually helps?


In fact we regularly are able to recover data from drives: we have a
userspace application that retries over and over again, and this
sometimes recovers "marginal" blocks. This could be considered "good
practise" if there is a filesystem requesting the block. On the other
hand, when this happens, the drive is usually beyond being usable for
a filesystem: if we recover one block this way, the next block will be
errorred and the filesystem "crashes" anyway. In fact this behaviour
may masquerade the first warnings that something is going wrong....

So, I'm arguing for: We remove the retry code alltogether, OR we make
an option to re-enable the retry code for MFM era drives(*) (Note: those 
are more than 10 years old, so almost (but not quite) extinct).

	Roger. 

(*) Note: Tested last month: The driver still works for MFM
drives. However, the initialization apparently is not enough
anymore. The drive did not work when the BIOS didn't think there was a
drive.

-- 
+-- Rogier Wolff -- www.harddisk-recovery.nl -- 0800 220 20 20 --
| Files foetsie, bestanden kwijt, alle data weg?!
| Blijf kalm en neem contact op met Harddisk-recovery.nl!
