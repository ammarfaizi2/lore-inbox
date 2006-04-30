Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750902AbWD3V0g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750902AbWD3V0g (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Apr 2006 17:26:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751222AbWD3V0g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Apr 2006 17:26:36 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:44700 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750902AbWD3V0g
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Apr 2006 17:26:36 -0400
Subject: Re: 2.6.17-rc1-mm3: time-i386-clocksource-drivers*.patch broke
	userspace apps
From: john stultz <johnstul@us.ibm.com>
To: Laurent Riffard <laurent.riffard@free.fr>
Cc: Kernel development list <linux-kernel@vger.kernel.org>,
       OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
       Andrew Morton <akpm@osdl.org>, len.brown@intel.com
In-Reply-To: <4454B4A1.4060304@free.fr>
References: <4454B4A1.4060304@free.fr>
Content-Type: text/plain
Date: Sun, 30 Apr 2006 14:26:27 -0700
Message-Id: <1146432387.10239.8.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-04-30 at 14:59 +0200, Laurent Riffard wrote:
> Since 2.6.17-rc1-mm3, some applications behave strangely here:
> - video players (mplayer, vlc) are randomly frozen after less than 1
> minute playing . They are killable by ^C.
> - some network java application (freenet-0.7) quit after a few
> minutes running.
> 
> A bissection point out time-i386-clocksource-drivers.patch as the
> sucker.

Thanks for narrowing this down!


> I noticed that, since 2.6.17-rc1-mm3, pit clocksource is installed
> instead of acpi_pm clocksource. Booting with "clocksource=acpi_pm"
> does not help.
> 
> [root@antares ~]# grep clocksource dmesg-2.6.17-rc*
> dmesg-2.6.17-rc1-mm1:Time: tsc clocksource has been installed.
> dmesg-2.6.17-rc1-mm1:Time: acpi_pm clocksource has been installed.
> dmesg-2.6.17-rc1-mm2:Time: tsc clocksource has been installed.
> dmesg-2.6.17-rc1-mm2:Time: acpi_pm clocksource has been installed.
> dmesg-2.6.17-rc1-mm3:Time: tsc clocksource has been installed.
> dmesg-2.6.17-rc1-mm3:Time: pit clocksource has been installed.
> dmesg-2.6.17-rc2-mm1:Time: tsc clocksource has been installed.
> dmesg-2.6.17-rc2-mm1:Time: pit clocksource has been installed.

Hmmm. I'm not sure why the ACPI PM timer isn't showing up. Your .config
looks good, but I don't see the ACPI PM timer io-port being detected as
I expect.

Len, has there been any changes to that ACPI code?

> Is pit clocksource broken ? If so, how can I get back acpi_pm
> clocksource ?

I just got another report about the pit clocksource having trouble,
although that was on an SMP system. So its likely there is an issue
there so I'll have to hunt that down.

> Feel free to ask for more information or to send me test patches.

I need to dig on the ACPI issue, but I should be able to have a test
patch for you on the PIT issue early this week.

thanks
-john

