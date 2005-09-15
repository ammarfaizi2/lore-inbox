Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965028AbVIOVkk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965028AbVIOVkk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 17:40:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965282AbVIOVkk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 17:40:40 -0400
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:15561 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S965028AbVIOVkj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 17:40:39 -0400
Subject: Re: [ACPI] wrong documentation for /proc/acpi/sleep?
From: Len Brown <len.brown@intel.com>
To: Jochen Hein <jochen@jochen.org>
Cc: acpi-devel@lists.sourceforge.net,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <87mzme3xv8.fsf@echidna.jochen.org>
References: <87mzme3xv8.fsf@echidna.jochen.org>
Content-Type: text/plain
Date: Thu, 15 Sep 2005 17:42:17 -0400
Message-Id: <1126820537.31252.5.camel@toshiba>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-09-15 at 16:00 -0400, Jochen Hein wrote:
> 
> The documentation in Documentation/power/swsusp.txt reads:
> 
> ,----
> | Sleep states summary
> | ====================
> |
> | There are three different interfaces you can use, /proc/acpi should
> | work like this:
> |
> | In a really perfect world:
> | echo 1 > /proc/acpi/sleep       # for standby
> | echo 2 > /proc/acpi/sleep       # for suspend to ram
> | echo 3 > /proc/acpi/sleep       # for suspend to ram, but with more
> | power conservative
> | echo 4 > /proc/acpi/sleep       # for suspend to disk
> | echo 5 > /proc/acpi/sleep       # for shutdown unfriendly the system
> |
> | and perhaps
> | echo 4b > /proc/acpi/sleep      # for suspend to disk via s4bios
> `----

You're right, swsusp.txt is out of date.
/proc/acpi/sleep is deprecated -- and the S2 comment was nonsense from
the start.

> I do get:
> root@hermes:~# echo 2 > /proc/acpi/sleep
> bash: /proc/acpi/sleep: No such file or directory
> 
> Kernel release is 2.6.14-rc1, ACPI/Power-related-config:
> ,----
> | root@hermes:/usr/src/linux-2.6.14-rc1# grep ACPI .config
> | # Power management options (ACPI, APM)
> | # ACPI (Advanced Configuration and Power Interface) Support
> | CONFIG_ACPI=y
> | CONFIG_ACPI_AC=y
> | CONFIG_ACPI_BATTERY=y
> | CONFIG_ACPI_BUTTON=y
> | CONFIG_ACPI_VIDEO=y
> | CONFIG_ACPI_HOTKEY=y
> | CONFIG_ACPI_FAN=y
> | CONFIG_ACPI_PROCESSOR=y
> | CONFIG_ACPI_THERMAL=y
> | # CONFIG_ACPI_ASUS is not set
> | CONFIG_ACPI_IBM=y
> | # CONFIG_ACPI_TOSHIBA is not set
> | CONFIG_ACPI_BLACKLIST_YEAR=0
> | CONFIG_ACPI_DEBUG=y
> | CONFIG_ACPI_EC=y
> | CONFIG_ACPI_POWER=y
> | CONFIG_ACPI_SYSTEM=y
> | # CONFIG_ACPI_CONTAINER is not set
> | CONFIG_X86_ACPI_CPUFREQ=y
> | CONFIG_X86_SPEEDSTEP_CENTRINO_ACPI=y
> | # CONFIG_X86_ACPI_CPUFREQ_PROC_INTF is not set
> | # CONFIG_HOTPLUG_PCI_ACPI is not set
> | CONFIG_PNPACPI=y
> | root@hermes:/usr/src/linux-2.6.14-rc1# grep POWER .config
> | CONFIG_ACPI_POWER=y
> | # CONFIG_APM_REAL_MODE_POWER_OFF is not set
> | CONFIG_CPU_FREQ_GOV_POWERSAVE=y
> | # CONFIG_X86_POWERNOW_K6 is not set
> | # CONFIG_X86_POWERNOW_K7 is not set
> | # CONFIG_X86_POWERNOW_K8 is not set
> | # CONFIG_USB_POWERMATE is not set
> | root@hermes:/usr/src/linux-2.6.14-rc1# grep SWSU .config
> | CONFIG_SWSUSP_ENCRYPT=y
> `----
> 
> System is a Thinkpad R40, Debian/sarge with kernel 2.6.14-rc1. Did I
> miss something obvious?

Enable CONFIG_ACPI_SLEEP

for /proc/acpi/sleep, you'll need
CONFIG_ACPI_SLEEP_PROC_FS
which will allow
CONFIG_ACPI_SLEEP_PROC_SLEEP

cheers,
-Len


