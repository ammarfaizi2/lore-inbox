Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270208AbTGWKr4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jul 2003 06:47:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270210AbTGWKr4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jul 2003 06:47:56 -0400
Received: from [164.164.94.19] ([164.164.94.19]:23986 "EHLO
	tanthi.amplewave.com") by vger.kernel.org with ESMTP
	id S270208AbTGWKrz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jul 2003 06:47:55 -0400
Subject: Dependency problem in 2.6.0-test1
From: Amol Lad <amol@amplewave.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 23 Jul 2003 16:39:08 +0530
Message-Id: <1058958553.32116.24.camel@amol.amplewave.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
make && make install && make modules && make modules_install,

I get following error message

depmod: *** Unresolved symbols in
/lib/modules/2.6.0-test1/kernel/drivers/char/agp/intel-agp.ko
depmod:         agp_remove_bridge
depmod:         agp_generic_free_gatt_table
depmod:         agp_generic_enable
...
...
...


but the symbols are already defined, 

[root@amol agp]# pwd
/lib/modules/2.6.0-test1/kernel/drivers/char/agp
[root@amol agp]# nm agpgart.ko | grep agp_remove_bridge
00000450 T agp_remove_bridge
00000062 r __kstrtab_agp_remove_bridge
00000008 r __ksymtab_agp_remove_bridge
[root@amol agp]# 

My modules.dep in /lib/modules/2.6.0-test1 looks like
.....
 /lib/modules/2.6.0-test1/kernel/drivers/char/agp/agpgart.ko:

 /lib/modules/2.6.0-test1/kernel/drivers/char/agp/intel-agp.ko:

 /lib/modules/2.6.0-test1/kernel/drivers/char/agp/sworks-agp.ko:
.....

I think here intel-agp is dependent on agpgart but this dependency is
not in modules.dep.

please CC me

Thanks
Amol


