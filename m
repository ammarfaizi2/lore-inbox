Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964812AbWAIPoS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964812AbWAIPoS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 10:44:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964824AbWAIPoS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 10:44:18 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:30890 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S964812AbWAIPoR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 10:44:17 -0500
Date: Mon, 9 Jan 2006 16:44:16 +0100
From: Pavel Machek <pavel@ucw.cz>
To: "Li, Shaohua" <shaohua.li@intel.com>
Cc: ronald.mythtv@gmail.com, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: /proc/acpi/alarm -- does it work or not?
Message-ID: <20060109154416.GF717@atrey.karlin.mff.cuni.cz>
References: <59D45D057E9702469E5775CBB56411F1013CF084@pdsmsx406>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <59D45D057E9702469E5775CBB56411F1013CF084@pdsmsx406>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >I wanted to write some documentation about /proc/acpi/alarm, but
> >failed to make it work. I was putting machine to suspend-to-ram and
> >enabled everything in /proc/acpi/wakeup, still it would not do
> >anything. I even went to bios (thinkpad x32), set "RTC alarm" to
> >enabled and set time there. Nothing interesting
> >happened. /proc/acpi/alarm could not see most of my changes done in
> >BIOS, it only cleared century or something like that.
> >
> >I checked that RTC readout in BIOS shows same thing as system timer.
> >
> >Here are my attempts: [Commands were typed one-after-another where it
> >makes sense, and I left machine suspended for long enough -- timer
> >should have expired]
> It appears we need enable rtc driver to make alarm work.

I enabled CONFIG_RTC:

pavel@amd:/data/l/linux$ grep CONFIG_RTC .config
CONFIG_RTC=y
# CONFIG_RTC_X1205_I2C is not set
pavel@amd:/data/l/linux$

...but /proc/acpi/alarm still behaves very strangely:

2006-01-00 12:42:00
root@amd:/proc/acpi# echo '2006-01-01 12:34:56' > alarm
root@amd:/proc/acpi# cat alarm
2006-01-01 12:34:56
root@amd:/proc/acpi# echo '2006-09-01 12:34:56' > alarm
root@amd:/proc/acpi# cat alarm
2006-01-01 12:34:56
root@amd:/proc/acpi# echo '2006-01-09 12:34:56' > alarm
root@amd:/proc/acpi# cat alarm
2006-01-09 12:34:56
root@amd:/proc/acpi# echo '2006-02-09 12:34:56' > alarm
root@amd:/proc/acpi# cat alarm
2006-01-09 12:34:56
root@amd:/proc/acpi#

...why does it hate february and september?

							Pavel

-- 
Thanks, Sharp!
