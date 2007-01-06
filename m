Return-Path: <linux-kernel-owner+w=401wt.eu-S932251AbXAFWY4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932251AbXAFWY4 (ORCPT <rfc822;w@1wt.eu>);
	Sat, 6 Jan 2007 17:24:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932252AbXAFWY4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Jan 2007 17:24:56 -0500
Received: from 85.8.24.16.se.wasadata.net ([85.8.24.16]:40284 "EHLO
	smtp.drzeus.cx" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932251AbXAFWY4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Jan 2007 17:24:56 -0500
Message-ID: <45A021B2.4090104@drzeus.cx>
Date: Sat, 06 Jan 2007 23:24:50 +0100
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Thunderbird 1.5.0.9 (X11/20061223)
MIME-Version: 1.0
To: Anderson Briglia <anderson.briglia@indt.org.br>
CC: Russell King <rmk+lkml@arm.linux.org.uk>,
       "Lizardo Anderson (EXT-INdT/Manaus)" <anderson.lizardo@indt.org.br>,
       linux-kernel@vger.kernel.org,
       "Aguiar Carlos (EXT-INdT/Manaus)" <carlos.aguiar@indt.org.br>,
       Tony Lindgren <tony@atomide.com>,
       ext David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 4/4] Add MMC Password Protection (lock/unlock) support
 V9: mmc_sysfs.diff
References: <4582F007.7030100@indt.org.br> <459B9C4E.3020406@indt.org.br>
In-Reply-To: <459B9C4E.3020406@indt.org.br>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've queued it up for -mm, but there a few more comments I want resolved
before this can move to Linus...

You need to clean up mmc_lockable_store(). It had a few broken variable
declarations that even prevented it from compiling, and after I fixed
that I still get:

drivers/mmc/mmc_sysfs.c: In function ‘mmc_lockable_store’:
drivers/mmc/mmc_sysfs.c:160: warning: ignoring return value of
‘device_attach’, declared with attribute warn_unused_result
drivers/mmc/mmc_sysfs.c:93: warning: ‘mmc_key’ may be used uninitialized
in this function

There's also no handling for an invalid string written to the sysfs node.

And third, you're a bit excessive on the goto:s. E.g. out_unlocked is
used in a single place, so it is completely unnecessary. Please do a
general cleanup of the control flow.

Rgds

-- 
     -- Pierre Ossman

  Linux kernel, MMC maintainer        http://www.kernel.org
  PulseAudio, core developer          http://pulseaudio.org
  rdesktop, core developer          http://www.rdesktop.org

