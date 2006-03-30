Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750738AbWC3Wgi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750738AbWC3Wgi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 17:36:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750771AbWC3Wgi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 17:36:38 -0500
Received: from test-iport-3.cisco.com ([171.71.176.78]:13602 "EHLO
	test-iport-3.cisco.com") by vger.kernel.org with ESMTP
	id S1750738AbWC3Wgi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 17:36:38 -0500
To: "Bryan O'Sullivan" <bos@pathscale.com>, sam@ravnborg.org
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: [PATCH 16 of 16] ipath - kbuild infrastructure
X-Message-Flag: Warning: May contain useful information
References: <36bfb4f1ad322a8fb23e.1143674619@chalcedony.internal.keyresearch.com>
	<adaek0j1w25.fsf@cisco.com>
	<1143755751.24402.11.camel@chalcedony.internal.keyresearch.com>
From: Roland Dreier <rdreier@cisco.com>
Date: Thu, 30 Mar 2006 14:36:34 -0800
In-Reply-To: <1143755751.24402.11.camel@chalcedony.internal.keyresearch.com> (Bryan O'Sullivan's message of "Thu, 30 Mar 2006 13:55:51 -0800")
Message-ID: <ada64lv1rwt.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 30 Mar 2006 22:36:36.0139 (UTC) FILETIME=[672467B0:01C6544A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Bryan> I did ask at one point whether the core driver should live
    Bryan> in a directory in drivers/char/, since it's not really an
    Bryan> IB driver at all, and just have the IB-specific stuff live
    Bryan> in drivers/infiniband/hw/.

I guess we could do that (now or later).

For now how about something minimal like the change below?

Sam, does this seem OK to you?  (The situation is that the IPATH_CORE
source physically sits in drivers/infiniband/hw/ipath, but it is
possible to enable IPATH_CORE without enabling INFINIBAND.  So we need
to tell the build system to descend into drivers/infiniband if
IPATH_CORE is enabled, even if INFINIBAND isn't enabled)

Thanks,
  Roland

diff --git a/drivers/Makefile b/drivers/Makefile
index 4249552..2449ec5 100644
--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -70,6 +70,7 @@ obj-$(CONFIG_EISA)		+= eisa/
 obj-$(CONFIG_CPU_FREQ)		+= cpufreq/
 obj-$(CONFIG_MMC)		+= mmc/
 obj-$(CONFIG_INFINIBAND)	+= infiniband/
+obj-$(CONFIG_IPATH_CORE)	+= infiniband/
 obj-$(CONFIG_SGI_SN)		+= sn/
 obj-y				+= firmware/
 obj-$(CONFIG_CRYPTO)		+= crypto/
