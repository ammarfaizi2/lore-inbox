Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266479AbUIABsm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266479AbUIABsm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 21:48:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266566AbUIABsm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 21:48:42 -0400
Received: from fmr01.intel.com ([192.55.52.18]:36515 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id S266479AbUIABsf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 21:48:35 -0400
Subject: Re: CONFIG_ACPI totally broken (2.6.9-rc1-mm2)
From: Len Brown <len.brown@intel.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-acpi <linux-acpi@intel.com>, Sam Ravnborg <sam@ravnborg.org>
In-Reply-To: <566B962EB122634D86E6EE29E83DD808182C4C12@hdsmsx403.hd.intel.com>
References: <566B962EB122634D86E6EE29E83DD808182C4C12@hdsmsx403.hd.intel.com>
Content-Type: multipart/mixed; boundary="=-IknMI6YcUfvXTWRsZdol"
Organization: 
Message-Id: <1094003250.3938.33.camel@linux>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 31 Aug 2004 21:47:31 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-IknMI6YcUfvXTWRsZdol
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Martin,
Looks like having a config item simultaneously
depend on something and select it is a bad idea;-)
Let me know if this patch fixes the symptoms you see.
With your config and this patch I'm able to de-select
X86_HT and ACPI, which I think is what you were looking for, yes?

Andrew, thanks for spotting this earlier -- sorry I didn't
get back sooner.

thanks,
-Len


--=-IknMI6YcUfvXTWRsZdol
Content-Disposition: attachment; filename=kconfig.patch
Content-Type: text/plain; name=kconfig.patch; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

===== arch/i386/Kconfig 1.130 vs edited =====
--- 1.130/arch/i386/Kconfig	Tue Aug 31 02:10:41 2004
+++ edited/arch/i386/Kconfig	Tue Aug 31 21:35:30 2004
@@ -1141,7 +1141,7 @@
 
 config PCI_MMCONFIG
 	bool
-	depends on PCI && (PCI_GOMMCONFIG || (PCI_GOANY && ACPI))
+	depends on PCI && (PCI_GOMMCONFIG || PCI_GOANY)
 	select ACPI
 	default y
 

--=-IknMI6YcUfvXTWRsZdol--

