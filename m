Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270689AbTGNQAQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 12:00:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270477AbTGNQAQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 12:00:16 -0400
Received: from vdp071.ath07.cas.hol.gr ([195.97.122.72]:14239 "EHLO
	pfn1.pefnos") by vger.kernel.org with ESMTP id S270689AbTGNQAN convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 12:00:13 -0400
From: "P. Christeas" <p_christ@hol.gr>
To: lkml <linux-kernel@vger.kernel.org>, alsa-devel@lists.sourceforge.net
Subject: Reproducible deadlock w. alsa/maestro3 when sleeping (ACPI,) 2.6.0-test1
Date: Mon, 14 Jul 2003 19:17:22 +0300
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200307141917.22813.p_christ@hol.gr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have been experiencing some fully reproducible deadlock when waking from 
sleep, using artsd over ALSA.
The scenario is:
I use ALSA, with the maestro3 device and everything else compiled as modules.
>From userspace, I launch artsd, which uses its native ALSA support to connect 
to /dev/pcmXXXXX .
I only have a custom script, which sleeps the machine by a 'echo 1> 
/proc/acpi/sleep' . It does NOT stop alsa .
When the machine weaks, it has a deadlock. The suspended 'artsd' process waits 
for the /dev/pcmXXXX to become available (presumably; I can see 'D' on the 
'ps' line), while the maestro3 module waits for the 'artsd' process to free  
/dev/pcmXXX .
I have tried to kill (w. 15, 9 etc.) the artsd process, rmmod the 
'snd_maestro3' module (w. '-f' or '-l' options to rmmod). Nothing would 
happen. In the worst case (after the rmmod), the whole module mechanism would 
lock as well ('lsmod' would hang ).
I could not find any relevant message for this case. However, on a subsequent 
sleep, the system refuses to sleep because it cannot suspend 'artsd'.

ps. My scripts (including module-init-tools) are definitely messy. However, 
since 'artsd' or any ALSA client works in userspace and can be launched at 
any time, I believe this problem leads to serious trouble for the system.

