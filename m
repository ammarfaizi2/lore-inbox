Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932398AbWHFHb4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932398AbWHFHb4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Aug 2006 03:31:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932416AbWHFHb4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Aug 2006 03:31:56 -0400
Received: from mx-outbound.sourceforge.net ([66.35.250.223]:8357 "EHLO
	sc8-sf-sshgate.sourceforge.net") by vger.kernel.org with ESMTP
	id S932398AbWHFHbz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Aug 2006 03:31:55 -0400
From: Shem Multinymous <multinymous@gmail.com>
To: Robert Love <rlove@rlove.org>
Cc: Jean Delvare <khali@linux-fr.org>, Greg Kroah-Hartman <gregkh@suse.de>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
       hdaps-devel@lists.sourceforge.net
Subject: [PATCH 00/12] ThinkPad embedded controller and hdaps drivers
Reply-To: Shem Multinymous <multinymous@gmail.com>
Date: Sun, 06 Aug 2006 10:26:45 +0300
Message-Id: <11548492171301-git-send-email-multinymous@gmail.com>
X-Mailer: git-send-email 1.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series does three related things:

- Introduces a new driver, thinkpad_ec, for the ThinkPad embedded 
  controller (additional non-ACPI interface).
- Changes the existing hdaps driver to use thinkpad_ec instead of
  direct (and incorrect) port access.
- Several fixes and improvements to the hdaps driver.

Applies to git head.

Most of the patches in this series depend on previous ones.
Any point in this series will compile and was briefly tested (this
required introducing some code that gets overwritten by later patches).
The *combination* of all these patches was extensively tested as part
of the out-of-kernel tp_smapi package [1], and verified to work on dozens
of ThinkPad models (thousands of sf.net downloads and no unresolved
bugs). Note that the tp_smapi package includes another driver, to
be submitted later, which also depends the thinkpad_ec driver 
introduced here.

For some context and the necessity for a separate thinkpad_ec module,
see LKML thread "tp_smapi conflict with IDE, hdaps" on Dec. 2005.

I would like to thank the many testers and contributors who helped
in the development, and in particular Henrique de Moraes Holschuh
and ThinkWiki.org users Whoopie and Spiney.

[1] http://thinkwiki.org/wiki/tp_smapi
    http://tpctl.sourceforge.net/rel/tp_smapi-0.27.tgz

Summary:

[PATCH 01/12] thinkpad_ec: New driver for ThinkPad embedded controller access
[PATCH 02/12] hdaps: Use thinkpad_ec instead of direct port access
[PATCH 03/12] hdaps: Unify and cache hdaps readouts
[PATCH 04/12] hdaps: Correct readout and remove nonsensical attributes
[PATCH 05/12] hdaps: Remember keyboard and mouse activity
[PATCH 06/12] hdaps: Limit hardware query rate
[PATCH 07/12] hdaps: delay calibration to first hardware query
[PATCH 08/12] hdaps: Add explicit hardware configuration functions
[PATCH 09/12] hdaps: Add new sysfs attributes
[PATCH 10/12] hdaps: Power off accelerometer on suspend and unload
[PATCH 11/12] hdaps: Stop polling timer when suspended
[PATCH 12/12] hdaps: Simplify whitelist

 drivers/hwmon/hdaps.c          |  758 ++++++++++++++++++++++++-----------------
 drivers/firmware/Kconfig       |    3 
 drivers/firmware/Makefile      |    1 
 drivers/firmware/thinkpad_ec.c |  444 ++++++++++++++++++++++++
 drivers/hwmon/Kconfig          |    1 
 include/linux/thinkpad_ec.h    |   47 ++
 6 files changed, 940 insertions(+), 314 deletions(-)
