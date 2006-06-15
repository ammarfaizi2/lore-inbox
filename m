Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031134AbWFOTAr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031134AbWFOTAr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jun 2006 15:00:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031133AbWFOTAr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jun 2006 15:00:47 -0400
Received: from agminet01.oracle.com ([141.146.126.228]:40383 "EHLO
	agminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1031134AbWFOTA2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jun 2006 15:00:28 -0400
Message-ID: <4491BC71.1090206@oracle.com>
Date: Thu, 15 Jun 2006 13:00:49 -0700
From: Randy Dunlap <randy.dunlap@oracle.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
CC: akpm <akpm@osdl.org>, perex@suse.cz
Subject: [Ubuntu PATCH] ALSA: Add hp_only quirk for pci id [161f:2032] to
 via82xx
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: crimsun@fungus.sh.nu <crimsun@fungus.sh.nu>

[UBUNTU:sound/pci/] Add hp_only quirk for pci id [161f:2032] to via82xx ALSA driver

http://www.kernel.org/git/?p=linux/kernel/git/bcollins/ubuntu-dapper.git;a=commitdiff;h=eae2cc78de39502595f67b7fc1f821f5963bb8ae

UpstreamStatus: Not merged

Christian Bjalevik reports in LP#38546 that his sound chipset requires
the "hp_only" quirk to allow him to control sound volume correctly when
headphones are inserted. This patch adds the appropriate pci id to the
via82xx ALSA driver so that the quirk is applied automatically, thereby
removing the need for users to modify /etc/modprobe.d/alsa-base (or to
unload and reload snd-via82xx with ac97_quirk=hp_only).

This patch closes LP#38546.

Signed-off-by: Daniel T Chen <crimsun@ubuntu.com>
Signed-off-by: Ben Collins <bcollins@ubuntu.com>
---
 sound/pci/via82xx.c |    6 ++++++
 1 files changed, 6 insertions(+)

--- linux-2617-rc6g7.orig/sound/pci/via82xx.c
+++ linux-2617-rc6g7/sound/pci/via82xx.c
@@ -1775,6 +1775,12 @@ static struct ac97_quirk ac97_quirks[] =
 		.name = "Targa Traveller 811",
 		.type = AC97_TUNE_HP_ONLY,
 	},
+	{
+		.subvendor = 0x161f,
+		.subdevice = 0x2032,
+		.name = "m680x",
+		.type = AC97_TUNE_HP_ONLY, /* http://launchpad.net/bugs/38546 */
+	},
 	{ } /* terminator */
 };
 

