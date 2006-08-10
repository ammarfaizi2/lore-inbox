Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161113AbWHJJxu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161113AbWHJJxu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 05:53:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161127AbWHJJxu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 05:53:50 -0400
Received: from mx-outbound.sourceforge.net ([66.35.250.223]:50331 "EHLO
	sc8-sf-sshgate.sourceforge.net") by vger.kernel.org with ESMTP
	id S1161113AbWHJJxu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 05:53:50 -0400
From: Shem Multinymous <multinymous@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Robert Love <rlove@rlove.org>, Pavel Machek <pavel@suse.cz>,
       Jean Delvare <khali@linux-fr.org>, Greg Kroah-Hartman <gregkh@suse.de>,
       Andrew Morton <akpm@osdl.org>, hdaps-devel@lists.sourceforge.net
Subject: [PATCH 00/12] ThinkPad embedded controller and hdaps drivers (version 2)
Reply-To: Shem Multinymous <multinymous@gmail.com>
Date: Thu, 10 Aug 2006 12:48:38 +0300
Message-Id: <1155203330179-git-send-email-multinymous@gmail.com>
X-Mailer: git-send-email 1.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This resubmission addresses all the comments I've received on LKML,
except where said otherwise in reply. Other changes are very minor.

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
of the out-of-tree tp_smapi package [1], and verified to work on dozens
of ThinkPad models (thousands of sf.net downloads and no unresolved
bugs). Note that the tp_smapi package includes another driver, to
be submitted later, which also depends the thinkpad_ec driver
introduced here.

For some context and the necessity for a separate thinkpad_ec module,
see LKML thread "tp_smapi conflict with IDE, hdaps" on Dec. 2005.

I would like to thank the many testers and contributors who helped
in the development, and in particular Henrique de Moraes Holschuh,
ThinkWiki.org users Whoopie and Spiney, and Pavel Machek.

[1] http://thinkwiki.org/wiki/tp_smapi


Summary:

 drivers/firmware/Kconfig       |    3 
 drivers/firmware/Makefile      |    1 
 drivers/firmware/thinkpad_ec.c |  465 ++++++++++++++++++
 drivers/hwmon/Kconfig          |    1 
 drivers/hwmon/hdaps.c          |  784 ++++++++++++++++++-------------
 include/linux/thinkpad_ec.h    |   47 +
 6 files changed, 990 insertions(+), 311 deletions(-)
