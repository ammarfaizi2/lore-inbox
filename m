Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262098AbTD3Gdt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Apr 2003 02:33:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262099AbTD3Gdt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Apr 2003 02:33:49 -0400
Received: from gbmail.gettysburg.edu ([138.234.4.100]:17118 "EHLO
	gettysburg.edu") by vger.kernel.org with ESMTP id S262098AbTD3Gds
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Apr 2003 02:33:48 -0400
Date: Wed, 30 Apr 2003 02:46:04 -0400
To: Ricardo Galli <gallir@uib.es>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Issues with 2.4.20/2.4.21-rc1[-ac3] and 2.5.68 on a Dell laptop
Message-ID: <20030430064604.GA28388@cetus>
References: <E19AcoY-0006Wj-00@cetus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E19AcoY-0006Wj-00@cetus>
User-Agent: Mutt/1.5.3i
From: Justin Pryzby <justinpryzby@users.sourceforge.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi; FWIW, I've got an Inspiron 4000 running 2.5.68.  Neither
/proc/sys/cpu/0/speed nor /proc/cpufreq all me to change any values
(speed has min==max==0, `cat cpufreq` lists no parameters).  `cat i8k`
works, causing no such lock.  I don't use suspend/resume.  The screen
brightness buttons work and do not hang.  ACPI kind of works;
`cat BAT0/info` causes "Error: ul_allocate: Attempt to allocate zero bytes".
The same occurs when I reinsert the battery.

Justin Pryzby

PS: I can confirm that /proc/acpi/button/lid/LID/state works; I just
sshed in to check.

On Tue, Apr 29, 2003 at 05:35:00PM -0500, Ricardo Galli wrote:
> 
> 
> Hi Alan,
>        first of all, thanks for you -acX, it solved several issues in my Dell
> X200, the inclusion of XFS is great, and dri/drm with xfree 4.3 works 
> perfectly with the i830M (thanks).
> 
> But there still several problems (with APM enabled, no framebuffer):
> 
> - With cpufreq enabled, the kernel hangs if you change the CPU speed
> _after_ a suspend/resume via the old interface (/proc/sys/cpu/0/speed,
> (also repeatable in a vanilla or -rc1 kernel)). It doesn't happen if my
> governor program uses /proc/cpufreq instead. I saw this bug also with the
> original cpufreq patch and also with 2.5.68.
> 
> - cat /proc/i8k produces a long kernel lock, everything gets locked for a
> few seconds. If you are playing a music, you must restart the program in
> order the get alsa sync'd again.
> 
> - After suspend/resume, the kernel hangs during a shutdown (just like the
> infamous w98se shutdown bug :-), it happens after all processes have been
> TERMed. Sometimes the screen goes white (it happens also with Marcelo
> tree). I tried this with almost every different version and bios
> workaround in APM kernel options. I also happens with 2.5.68.
> 
> - The kernel hangs/lock hard if IO-APIC is enabled and you try to change
> the screen brightness (<Fn><[UP][DOWN]-Arrow>). It also happens with
> 2.5.68.
> 
> - ACPI doesn't see the battery, the shutdown buttons just turn down with
> notifying the kernel, suspend doesn't work. Also seen with ACPI original
> patches and 2.5.68.
> 
> - Only happens with -ac3 version: the poweroff button turns the machine
> off inmediately, it doesn't wait for a few seconds, as previous versions.
> 
> Regards,
> 
> 
> --
>  ricardo galli      GPG id C8114D34
> -
> To unsubscribe from this list: send the line 'unsubscribe linux-kernel' in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at http://www.tux.org/lkml/
