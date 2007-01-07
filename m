Return-Path: <linux-kernel-owner+w=401wt.eu-S932578AbXAGPRr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932578AbXAGPRr (ORCPT <rfc822;w@1wt.eu>);
	Sun, 7 Jan 2007 10:17:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932579AbXAGPRr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Jan 2007 10:17:47 -0500
Received: from eazy.amigager.de ([213.239.192.238]:51160 "EHLO
	eazy.amigager.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932578AbXAGPRq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Jan 2007 10:17:46 -0500
Date: Sun, 7 Jan 2007 16:17:44 +0100
From: Tino Keitel <tino.keitel@tikei.de>
To: linux-kernel@vger.kernel.org
Subject: 2.6.20-rc3 regression: suspend to RAM broken on Mac mini Core Duo
Message-ID: <20070107151744.GA9799@dose.home.local>
Mail-Followup-To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

I tried 2.6.20-rc3 and suspend to RAM is now broken. The screen stays
dark after resume, the same with the network link. It worked with
2.6.18 (I skipped 2.6.19 because of a regression in the sky2 driver).

I enabled pm_trace and did a echo mem > /sys/power/state in single user
mode.

After the reboot, all I got from pm_trace is this:

ACPI: (supports S0 S3 S4 S5)
  Magic number: 0:798:636
  hash matches drivers/base/power/resume.c:46
Freeing unused kernel memory: 228k freed

This is line 46 in resume.c:

	TRACE_RESUME(error);

No information about the device/driver that refuses to resume.

I think that this is a regression, as it worked with 2.6.18 and the
kernel config is the same. The hardare is a Mac mini Core Duo.

Regards,
Tino
