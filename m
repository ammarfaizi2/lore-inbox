Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264648AbUEOATO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264648AbUEOATO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 20:19:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264862AbUEOAQu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 20:16:50 -0400
Received: from dingo.clsp.jhu.edu ([128.220.117.40]:1664 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S264648AbUENXtd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 19:49:33 -0400
Date: Fri, 14 May 2004 05:15:31 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Plaz McMan <PlazMcMan@Softhome.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: swsusp + APM in 2.6.6
Message-ID: <20040514031531.GB14773@elf.ucw.cz>
References: <1084411449.2562.20.camel@ansel.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1084411449.2562.20.camel@ansel.lan>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Upgrading older IBM ThinkPad from 2.6.1 to 2.6.6.
> 
> In 2.6.1, I had ACPI + APM support compiled in, and I disabled ACPI at
> boot (acpi=off). With this setup, I could sleep, shutdown, and use swap
> suspend with "echo 4 > /proc/sleep" (_not_ /proc/acpi/sleep, as there
> was no /proc/acpi). I slept the computer with "apm -[s,S]". I had ACPI
> support because for some reason the computer wouldn't shutdown without
> it, even though I have it disabled at boot. Note that ACPI wouldn't
> properly sleep my computer (display stayed on, even with lid closed),
> which is why I used APM. In any event, 2.6.1 worked _great_ as far as PM
> stuff was concerned.

Well, you actually exploited bug in ACPI /proc handling. Cute.

> In 2.6.6, however, using the same kernel configuration, neither
> /proc/sleep or /proc/acpi/sleep exist! I _do_ have swsusp enabled in the
> kernel, as well as ACPI sleep states (do they do anything if you disable
> ACPI at boot?). ACPI sleep doesn't turn off the screen, so I want to use
> APM. However, I also want swsusp to work. So, I will continue to use
> 2.6.1 until everything pans out.

It works as designed. Perhaps on one sunny day shutdown will support
-z option meaning "do swsusp".
								Pavel

Q: My machine doesn't work with ACPI. How can I use swsusp than ?

A: Do reboot() syscall with right parameters. Warning: glibc gets in
its way, so check with strace:
 
reboot(LINUX_REBOOT_MAGIC1, LINUX_REBOOT_MAGIC2, 0xd000fce2)

(Thanks to Peter Osterlund:)

#include <unistd.h>
#include <syscall.h>

#define LINUX_REBOOT_MAGIC1     0xfee1dead
#define LINUX_REBOOT_MAGIC2     672274793
#define LINUX_REBOOT_CMD_SW_SUSPEND     0xD000FCE2

int main()
{
    syscall(SYS_reboot, LINUX_REBOOT_MAGIC1, LINUX_REBOOT_MAGIC2,
            LINUX_REBOOT_CMD_SW_SUSPEND, 0);
    return 0;
}

-- 
When do you have heart between your knees?
