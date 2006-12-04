Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758525AbWLDKkK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758525AbWLDKkK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 05:40:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758839AbWLDKkK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 05:40:10 -0500
Received: from mail.syneticon.net ([213.239.212.131]:51147 "EHLO
	mail2.syneticon.net") by vger.kernel.org with ESMTP
	id S1758525AbWLDKkI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 05:40:08 -0500
Message-ID: <4573FAF0.60302@wpkg.org>
Date: Mon, 04 Dec 2006 11:39:44 +0100
From: Tomasz Chmielewski <mangoo@wpkg.org>
User-Agent: Thunderbird 1.5.0.8 (X11/20061128)
MIME-Version: 1.0
To: tobiasoed@hotmail.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: why can't I remove a kernel module (or: what uses a given module)?
References: <4572B30F.9020605@wpkg.org> <jewt592oxf.fsf@sykes.suse.de> <4572BBE0.4010801@wpkg.org> <20061203154936.GB26669@kallisti.us> <45732C8E.4060801@wpkg.org> <el0s6r$agu$1@sea.gmane.org>
In-Reply-To: <el0s6r$agu$1@sea.gmane.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tobias Oed wrote:
> Tomasz Chmielewski wrote:
> 
>> Ross Vandegrift wrote:
>>> On Sun, Dec 03, 2006 at 12:58:24PM +0100, Tomasz Chmielewski wrote:
>>>> You mean the "Used by" column? No, it's not used by any other module
>>>> according to lsmod output.
>>>>
>>>> Any other methods of checking what uses /dev/sda*?
>>> There's a good chance that if it was loaded at system boot, hald or
>>> udev may be doing something with it.
>> This machine doesn't have hal; when I kill udevd still doesn't help.
>>
>> Yes, something's using that drive, be it a program, a module (unlikely),
>> or something that is compiled directly in the kernel (for example,
>> md/raid1).
>> But what is it?
> 
> Since you mention md, dm comes to mind. I have seen a couple of drives that
> were previously attached to fake raid controllers becoming unavailable when
> moved to a normal controller. I haven't found the one size workaround for
> the problem yet. Can you check
> /sys/block/sda/holders ?

Yes, that was the right answer.
On a system with sata_mv (machine_1) I indeed had RAID, and that's why I 
suspected I couldn't remove the module. It was confirmed by checking 
/sys/block/sda/sda1/holders:

# ls /sys/block/sda/sda1/holders
md0@


On yet another system (machine_2), with sata_via module, I didn't set up 
RAID, but still, I couldn't remove the module. Inspecting 
/sys/block/sda/sda1/holders revealed why:

# ls /sys/block/sda/sda1/holders
dm-0@  dm-1@  dm-2@


The drive was taken from the machine_1; it had LVM2 on it.


Thanks!


-- 
Tomasz Chmielewski
http://wpkg.org


