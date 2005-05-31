Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261375AbVEaUBd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261375AbVEaUBd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 May 2005 16:01:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261395AbVEaUBc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 May 2005 16:01:32 -0400
Received: from ns1.g-housing.de ([62.75.136.201]:58848 "EHLO mail.g-house.de")
	by vger.kernel.org with ESMTP id S261375AbVEaUBB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 May 2005 16:01:01 -0400
Message-ID: <429CC26A.1030908@g-house.de>
Date: Tue, 31 May 2005 22:00:42 +0200
From: Christian Kujau <evil@g-house.de>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Steven Cole <elenstev@mesatop.com>
CC: Linus Torvalds <torvalds@osdl.org>, Alexander Nyberg <alexn@telia.com>,
       Pete Clements <clem@clem.clem-digital.net>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.12-rc5-git3 fails compile -- acpi_boot_table_init
References: <200505281206.j4SC6iLa015878@clem.clem-digital.net> <1117287439.952.17.camel@localhost.localdomain> <Pine.LNX.4.58.0505291157120.10545@ppc970.osdl.org> <429C7024.40002@mesatop.com>
In-Reply-To: <429C7024.40002@mesatop.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Cole wrote:
> I had to fix up one reject, but it still fixes the no ACPI build for me, 
> with the current HEAD=5e485b7975472ba4a408523deb6541e70c451842.

hm, i still had 2 rejects with your patch, -git tree updated today.
another "version" of patch attached, and yes: it does fix the no-ACPI build.

thanks,
Christian.

Signed-off-by: Christian Kujau <evil@g-house.de>

--- linux-2.6-git/include/linux/acpi.h.orig     2005-05-31 
21:49:00.411776244 +0200
+++ linux-2.6-git/include/linux/acpi.h  2005-05-31 21:51:30.855399473 +0200
@@ -415,16 +415,6 @@

  #define acpi_mp_config 0

-static inline int acpi_boot_init(void)
-{
-       return 0;
-}
-
-static inline int acpi_boot_table_init(void)
-{
-       return 0;
-}
-
  #endif         /*!CONFIG_ACPI_BOOT*/

  unsigned int acpi_register_gsi (u32 gsi, int edge_level, int 
active_high_low);
@@ -535,5 +525,17 @@

  extern int pnpacpi_disabled;

+#else  /* CONFIG_ACPI */
+
+static inline int acpi_boot_init(void)
+{
+       return 0;
+}
+
+static inline int acpi_boot_table_init(void)
+{
+       return 0;
+}
+
  #endif /* CONFIG_ACPI */
  #endif /*_LINUX_ACPI_H*/
-- 
BOFH excuse #291:

Due to the CDA, we no longer have a root account.
