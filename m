Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269605AbUJLKlt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269605AbUJLKlt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 06:41:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269604AbUJLKlt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 06:41:49 -0400
Received: from cantor.suse.de ([195.135.220.2]:28370 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S269605AbUJLKld (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 06:41:33 -0400
Message-ID: <416BB2A3.4080605@suse.de>
Date: Tue, 12 Oct 2004 12:32:03 +0200
From: Stefan Seyfried <seife@suse.de>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pavel Machek <pavel@suse.cz>
Cc: David Brownell <david-b@pacbell.net>, Paul Mackerras <paulus@samba.org>,
       Linus Torvalds <torvalds@osdl.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Pavel Machek <pavel@ucw.cz>,
       ncunningham@linuxmail.org
Subject: Re: Totally broken PCI PM calls
References: <1097455528.25489.9.camel@gaston> <200410111437.17898.david-b@pacbell.net> <416B0557.40407@suse.de> <200410111959.53048.david-b@pacbell.net> <20041012085440.GB2292@elf.ucw.cz>
In-Reply-To: <20041012085440.GB2292@elf.ucw.cz>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Pavel Machek wrote:

>>p.s. I find the /sys/power/disk file mildly cryptic, maybe
>>    other folk will find the attached patch slightly more
>>    informative about what this interface can do.
> 
>>--- 1.19/kernel/power/disk.c	Thu Sep  9 08:45:13 2004
>>+++ edited/kernel/power/disk.c	Fri Oct  1 11:01:41 2004
>>@@ -282,7 +282,14 @@
>> 
>> static ssize_t disk_show(struct subsystem * subsys, char * buf)
>> {
>>-	return sprintf(buf,"%s\n",pm_disk_modes[pm_disk_mode]);
>>+	return sprintf(buf,"%s%s %s%s %s%s\n",
>>+		(pm_disk_mode == pm_ops->pm_disk_mode) ? "*" : "",
>>+			pm_disk_modes[pm_ops->pm_disk_mode],
>>+		(pm_disk_mode == PM_DISK_SHUTDOWN) ? "*" : "",
>>+			pm_disk_modes[PM_DISK_SHUTDOWN],
>>+		(pm_disk_mode == PM_DISK_REBOOT) ? "*" : "",
>>+			pm_disk_modes[PM_DISK_REBOOT]
>>+		);
>> }
>
> Hmm, its interface change,

yes, this would break _my_ userspace app that checks for successfully
setting shutdown mode by reading out the file, but well, i could live
with that.

>  and was not /sys expected to be "one file, one value"?

# cat /sys/power/state
standby mem disk

so one could assume that /sys/power/disk would have similar semantics.
OTOH, /sys/power/state does not indicate the active state but
/sys/power/disk does, so they _are_ different.
-- 
Stefan Seyfried, QA / R&D Team Mobile Devices, SUSE LINUX AG Nürnberg.

"Any ideas, John?"
"Well, surrounding them's out."
