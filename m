Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269561AbUJLI60@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269561AbUJLI60 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 04:58:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269549AbUJLIzy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 04:55:54 -0400
Received: from gprs213-46.eurotel.cz ([160.218.213.46]:11904 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S269557AbUJLIzN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 04:55:13 -0400
Date: Tue, 12 Oct 2004 10:54:40 +0200
From: Pavel Machek <pavel@suse.cz>
To: David Brownell <david-b@pacbell.net>
Cc: Stefan Seyfried <seife@suse.de>, Paul Mackerras <paulus@samba.org>,
       Linus Torvalds <torvalds@osdl.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Pavel Machek <pavel@ucw.cz>,
       ncunningham@linuxmail.org
Subject: Re: Totally broken PCI PM calls
Message-ID: <20041012085440.GB2292@elf.ucw.cz>
References: <1097455528.25489.9.camel@gaston> <200410111437.17898.david-b@pacbell.net> <416B0557.40407@suse.de> <200410111959.53048.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200410111959.53048.david-b@pacbell.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > The machines I've tested with relatively generic 2.6.9-rc kernels
> > > don't use BIOS support for S4 when I call swsusp.
> > 
> > first do either
> > echo platform > /sys/power/disk     # for S4
> > echo shutdown > /sys/power/disk     # for poweroff
> > 
> > then do
> > echo disk > /sys/power/state
> 
> Oddly enough, neither of them work lately for me.
> They each resume immediately after writing the
> image to disk.

dmesg would help....

> p.s. I find the /sys/power/disk file mildly cryptic, maybe
>     other folk will find the attached patch slightly more
>     informative about what this interface can do.

> --- 1.19/kernel/power/disk.c	Thu Sep  9 08:45:13 2004
> +++ edited/kernel/power/disk.c	Fri Oct  1 11:01:41 2004
> @@ -282,7 +282,14 @@
>  
>  static ssize_t disk_show(struct subsystem * subsys, char * buf)
>  {
> -	return sprintf(buf,"%s\n",pm_disk_modes[pm_disk_mode]);
> +	return sprintf(buf,"%s%s %s%s %s%s\n",
> +		(pm_disk_mode == pm_ops->pm_disk_mode) ? "*" : "",
> +			pm_disk_modes[pm_ops->pm_disk_mode],
> +		(pm_disk_mode == PM_DISK_SHUTDOWN) ? "*" : "",
> +			pm_disk_modes[PM_DISK_SHUTDOWN],
> +		(pm_disk_mode == PM_DISK_REBOOT) ? "*" : "",
> +			pm_disk_modes[PM_DISK_REBOOT]
> +		);
>  }
>  
>  

Hmm, its interface change, and was not /sys expected to be "one file,
one value"?

								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
