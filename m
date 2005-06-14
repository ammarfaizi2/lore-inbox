Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261293AbVFNTLZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261293AbVFNTLZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Jun 2005 15:11:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261294AbVFNTLZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Jun 2005 15:11:25 -0400
Received: from adsl-216-102-91-59.dsl.snfc21.pacbell.net ([216.102.91.59]:27530
	"EHLO nasledov.com") by vger.kernel.org with ESMTP id S261293AbVFNTLR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Jun 2005 15:11:17 -0400
Date: Tue, 14 Jun 2005 12:11:10 -0700
To: William D Waddington <william.waddington@beezmo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9 & 11 hang on ac/dc change with T43
Message-ID: <20050614191110.GA8835@nasledov.com>
References: <429130FF.2040804@beezmo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <429130FF.2040804@beezmo.com>
User-Agent: Mutt/1.5.9i
From: Misha Nasledov <misha@nasledov.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am having this same exact problem! I'm running 2.6.11.12 on my ThinkPad
T43 which I just got yesterday. I discovered last night then when I
change the power state in any way, it'll give these ATA abnormal status
0xD0 on port 0x1F7 errors.

So I began doing some sleuthing.. Bill said that this only happens with
APM, so I tried it without APM. First I booted with noapm, but I found
that my system was still trying to use the apm kernel module when apmd
started. So, I removed apm from the kernel and uninstalled apmd. An
interesting side effect that I noted here was that once apmd was
uninstalled it generated some sort of power-change event that triggered
this bug.

So I booted with a new kernel without any APM support and tried changing
the power state -- no luck. Same errors. Fortunately I haven't experienced
severe filesystem corruption quite yet, but I have a feeling that if I keep
experimenting long enough, it will be inevitable.

So this is a pretty grave bug. Everytime I want to unplug my laptop or plug
it back in, I have to shut it down first. I'm not sure what kernel version
this bug was introduced in -- I might try building 2.6.8 and see how that
works.

I believe that there are two more things I can try; Bill mentioned this
problem not happening in ACPI mode. I thought that by this he meant that
the problem disappeared in absence of APM, but perhaps this problem
might disappear in presence of ACPI. Well, I'll try this, but I'd prefer
to have working APM on this machine for suspend.

Maybe disabling the BIOS power-saving mechanisms and solely relying on
Linux kernel to handle CPU throttling and such might do it, but I have
my doubts.

Has anyone else had this problem? Anyone look into it? It seems that Bill
posted this a while ago and has received no reply on the list.

On Sun, May 22, 2005 at 06:25:19PM -0700, William D Waddington wrote:
> In the course of trying to figure out why /sys/.../cpu0 isn't populated
> when in APM mode, I discovered that the laptop hangs on the first (?)
> attempt to write to the drive after a change of power source.
> 
> This is a ThinkPad T43.  I see the problem with both 2.6.9-1.667 and
> 2.6.11-1.14_FC3 (both FC3).  Doesn't seem to happen in ACPI mode.
> I need APM since that suspends and hibernates will on TPs. (Including
> this one)
> 
> It always leads to a filesystem check on reboot, and once it damaged
> the partition so badly that it wouldn't reboot and "linux rescue" from
> the FC3 DVD couldn't mount it.  That time, I got "journalling error"
> messages on the console, and "abnormal status 0xD0 on port 0x1F7"
> when I tried to shut down.
> 
> I can't write to the HD to try to capture anything, so I don't have
> much diagnostic info.  I have posted the APM boot messages, FWIW:
> http://www.beezmo.com/scratch/t43_fc3/dmesg.apm
> 
> Any place I should poke to track this one down?  If this doesn't belong
> on lkml, please point me appropriately.

-- 
Misha Nasledov
misha@nasledov.com
GPG: A063 B99A 2BD3 2D48 F2D7 8E68 0F27 4D21 948F 8F06
