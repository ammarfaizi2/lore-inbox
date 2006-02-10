Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750977AbWBJCKY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750977AbWBJCKY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 21:10:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751006AbWBJCKX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 21:10:23 -0500
Received: from adelphi.physics.adelaide.edu.au ([129.127.102.1]:5253 "EHLO
	adelphi.physics.adelaide.edu.au") by vger.kernel.org with ESMTP
	id S1750976AbWBJCKX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 21:10:23 -0500
From: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Message-Id: <200602100212.k1A2CEat012522@auster.physics.adelaide.edu.au>
Subject: 2.6.15-rt16: possible sound-related side-effect
To: linux-kernel@vger.kernel.org
Date: Fri, 10 Feb 2006 12:42:14 +1030 (CST)
Cc: jwoithe@physics.adelaide.edu.au (Jonathan Woithe)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all

In the last week I have updated the kernel on our laptop to 2.6.15-rt16.
By and large this worked well and had the attractive side effect of making
the clock run at the correct speed once more.

During development of an ALSA patch I had the need to remove and reinsert
the hda-intel and hda-codec modules on numerous occasions.  Every so often
(perhaps once every 5 or 6 times on average) the initialisation sequence of
hda-intel would get hung up and the associated insmod would never return.  A
reboot was required to clear the problem.  The following messages were
written to syslog repeatedly and often:

  Feb  5 21:36:24: ALSA sound/pci/hda/hda_intel.c:511: azx_get_response timeout
  Feb  5 21:36:26 halite last message repeated 9 times
  Feb  5 21:36:29 halite kernel: printk: 31 messages suppressed.

I have noticed the "azx_get_response timeout" messages in earlier kernels
as well, but up until now the hda initialisation hasn't gotten hung up.

The latching up of the hda-intel initialisation does not appear to occur
when doing the same thing under a non-RT 2.6.15 kernel.  Furthermore, I have
had an instance where the lockup occured while cold-booting an unmodified
2.6.15-rt16, which rules out any changes I made to ALSA as the cause of the
problem.  In any case the changes I was making to ALSA don't affect the
initialisation code.

Prior to this kernel I was running an unmodified 2.6.14-rt21 kernel and
while these messages did occur they didn't cause hda-intel to lock up.

Any suggestions as to what might be causing this and/or of further tests
which might help narrow down the cause?

Regards
  jonathan
