Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261638AbUEALo2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261638AbUEALo2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 May 2004 07:44:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261673AbUEALo2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 May 2004 07:44:28 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:21751 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S261638AbUEALo0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 May 2004 07:44:26 -0400
Date: Sat, 1 May 2004 13:44:21 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Harald Arnesen <harald@skogtun.org>, len.brown@intel.com,
       luming.yu@intel.com
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       acpi-devel@lists.sourceforge.net
Subject: 2.6.6-rc3-mm1: modular ACPI button broken
Message-ID: <20040501114420.GF2541@fs.tum.de>
References: <20040430014658.112a6181.akpm@osdl.org> <87ad0sshku.fsf@basilikum.skogtun.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ad0sshku.fsf@basilikum.skogtun.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 01, 2004 at 10:00:01AM +0200, Harald Arnesen wrote:
> I don't see this in plain 2.6.6-rc3 or 2.6.6-rc2-mm2:
> 
> 
> $ sudo make modules_install
> INSTALL...
> if [ -r System.map ]; then /sbin/depmod -ae -F System.map
> 2.6.6-rc3-mm1; fi
> WARNING: /lib/modules/2.6.6-rc3-mm1/kernel/drivers/acpi/button.ko needs
> unknown symbol acpi_fixed_sleep_button
> WARNING: /lib/modules/2.6.6-rc3-mm1/kernel/drivers/acpi/button.ko needs
> unknown symbol acpi_fixed_pwr_button
> $
>...

Thanks for this report.

This seems to be introduced by the button driver unload unload patch 
(Bugzilla #2281) included in the ACPI BK patch.

It seems two EXPORT_SYMBOL's are missing in scan.c?

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed


