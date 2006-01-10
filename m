Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751011AbWAJDVg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751011AbWAJDVg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 22:21:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751013AbWAJDVg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 22:21:36 -0500
Received: from fmr17.intel.com ([134.134.136.16]:35226 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751006AbWAJDVg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 22:21:36 -0500
Subject: Re: /proc/acpi/alarm -- does it work or not?
From: Shaohua Li <shaohua.li@intel.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: ronald.mythtv@gmail.com, kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20060109154416.GF717@atrey.karlin.mff.cuni.cz>
References: <59D45D057E9702469E5775CBB56411F1013CF084@pdsmsx406>
	 <20060109154416.GF717@atrey.karlin.mff.cuni.cz>
Content-Type: text/plain
Date: Tue, 10 Jan 2006 11:20:56 +0800
Message-Id: <1136863261.5750.4.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-01-09 at 16:44 +0100, Pavel Machek wrote:
> Hi!
> 
> > >I wanted to write some documentation about /proc/acpi/alarm, but
> > >failed to make it work. I was putting machine to suspend-to-ram and
> > >enabled everything in /proc/acpi/wakeup, still it would not do
> > >anything. I even went to bios (thinkpad x32), set "RTC alarm" to
> > >enabled and set time there. Nothing interesting
> > >happened. /proc/acpi/alarm could not see most of my changes done in
> > >BIOS, it only cleared century or something like that.
> > >
> > >I checked that RTC readout in BIOS shows same thing as system timer.
> > >
> > >Here are my attempts: [Commands were typed one-after-another where it
> > >makes sense, and I left machine suspended for long enough -- timer
> > >should have expired]
> > It appears we need enable rtc driver to make alarm work.
> 
> I enabled CONFIG_RTC:
> 
> pavel@amd:/data/l/linux$ grep CONFIG_RTC .config
> CONFIG_RTC=y
> # CONFIG_RTC_X1205_I2C is not set
It appears CONFIG_RTC isn't related with the issue. In my test system,
if I didn't CONFIG_RTC, `date` shows wrong time, that's why I need RTC.

> pavel@amd:/data/l/linux$
> 
> ...but /proc/acpi/alarm still behaves very strangely:
> 
> 2006-01-00 12:42:00
> root@amd:/proc/acpi# echo '2006-01-01 12:34:56' > alarm
> root@amd:/proc/acpi# cat alarm
> 2006-01-01 12:34:56
> root@amd:/proc/acpi# echo '2006-09-01 12:34:56' > alarm
> root@amd:/proc/acpi# cat alarm
> 2006-01-01 12:34:56
> root@amd:/proc/acpi# echo '2006-01-09 12:34:56' > alarm
> root@amd:/proc/acpi# cat alarm
> 2006-01-09 12:34:56
> root@amd:/proc/acpi# echo '2006-02-09 12:34:56' > alarm
> root@amd:/proc/acpi# cat alarm
> 2006-01-09 12:34:56
> root@amd:/proc/acpi#
> 
> ...why does it hate february and september?
No. Setting day, month, century for alarm is optional. This means your
system doesn't support setting month and century. But maybe we should
print some infos here ...

Thanks,
Shaohua

