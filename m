Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291291AbSCMAUr>; Tue, 12 Mar 2002 19:20:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291314AbSCMAUh>; Tue, 12 Mar 2002 19:20:37 -0500
Received: from jubjub.wizard.com ([209.170.216.9]:3086 "EHLO jubjub.wizard.com")
	by vger.kernel.org with ESMTP id <S291291AbSCMAUa>;
	Tue, 12 Mar 2002 19:20:30 -0500
Date: Tue, 12 Mar 2002 16:19:57 -0800
From: A Guy Called Tyketto <tyketto@wizard.com>
To: linux-kernel@vger.kernel.org
Subject: more unresolved symbols in 2.5.6
Message-ID: <20020313001957.GA9853@wizard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.26i
X-Operating-System: Linux/2.5.5 (i686)
X-uptime: 4:12pm  up 8 days, 11:09,  2 users,  load average: 0.00, 0.29, 0.52
X-RSA-KeyID: 0xE9DF4D85
X-DSA-KeyID: 0xE319F0BF
X-GPG-Keys: see http://www.wizard.com/~tyketto/pgp.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


        Just going through the rest of the reports in my rolling of 2.5.6.

        With CONFIG_BLK_DEV_IDECD=m, /sbin/depmod -ae -F System.map 2.5.6 from 
make modules_install comes back with:

depmod: *** Unresolved symbols in /lib/modules/2.5.6/kernel/drivers/ide/ide-cd.o
depmod:         ide_fops
depmod: *** Unresolved symbols in /lib/modules/2.5.6/kernel/drivers/net/tulip/de4x5.o
depmod:         virt_to_bus_not_defined_use_pci_map
depmod: *** Unresolved symbols in /lib/modules/2.5.6/kernel/sound/oss/sound.o
depmod:         virt_to_bus_not_defined_use_pci_map

        The virt_to_bus_not_defined_use_pci_map is known and is being worked 
on, AFAIK, but ide_fops is new. Poking around ide-cd.c, line 2514, is the only 
reference to it, inside a devfs_register() call. Leads me to assume that this 
would only show up, if CONFIG_DEVFS_FS is set to Y. Richard, any insights into 
this one? It looks like ide_fops may only need to be exported via ksyms.c, but 
I'd rather have a second opinion..

                                                        BL.
-- 
Brad Littlejohn                         | Email:        tyketto@wizard.com
Unix Systems Administrator,             |           tyketto@ozemail.com.au
Web + NewsMaster, BOFH.. Smeghead! :)   |   http://www.wizard.com/~tyketto
  PGP: 1024D/E319F0BF 6980 AAD6 7329 E9E6 D569  F620 C819 199A E319 F0BF

