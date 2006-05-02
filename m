Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964934AbWEBSRO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964934AbWEBSRO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 14:17:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964949AbWEBSRO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 14:17:14 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:11431 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S964934AbWEBSRO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 14:17:14 -0400
Subject: Re: 2.6.17-rc1-mm3: time-i386-clocksource-drivers*.patch broke
	userspace apps
From: john stultz <johnstul@us.ibm.com>
To: ak@suse.de, Laurent Riffard <laurent.riffard@free.fr>
Cc: Kernel development list <linux-kernel@vger.kernel.org>,
       OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <4454B4A1.4060304@free.fr>
References: <4454B4A1.4060304@free.fr>
Content-Type: text/plain
Date: Tue, 02 May 2006 11:16:58 -0700
Message-Id: <1146593819.21288.2.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-04-30 at 14:59 +0200, Laurent Riffard wrote:
> [root@antares ~]# grep clocksource dmesg-2.6.17-rc*
> dmesg-2.6.17-rc1-mm1:Time: tsc clocksource has been installed.
> dmesg-2.6.17-rc1-mm1:Time: acpi_pm clocksource has been installed.
> dmesg-2.6.17-rc1-mm2:Time: tsc clocksource has been installed.
> dmesg-2.6.17-rc1-mm2:Time: acpi_pm clocksource has been installed.
> dmesg-2.6.17-rc1-mm3:Time: tsc clocksource has been installed.
> dmesg-2.6.17-rc1-mm3:Time: pit clocksource has been installed.
> dmesg-2.6.17-rc2-mm1:Time: tsc clocksource has been installed.
> dmesg-2.6.17-rc2-mm1:Time: pit clocksource has been installed.
> 
> Is pit clocksource broken ? If so, how can I get back acpi_pm
> clocksource ?


Sorry, I still don't have a patch for the PIT problems you're seeing,
but I did track down why the ACPI PM disappeared.

It looks like its from the patch:
	i386-x86-64-fix-acpi-disabled-lapic-handling.patch


The second chunk adds:

+       if (!cpu_has_apic)
+               return -ENODEV;
+

Right before we probe for the ACPI PM timer.


Andi, is there some way we can move that to after the ACPI PM probe?

thanks
-john


