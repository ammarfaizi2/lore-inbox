Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932206AbWHGQXh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932206AbWHGQXh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 12:23:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932207AbWHGQXh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 12:23:37 -0400
Received: from smtp.reflexsecurity.com ([72.54.64.74]:34706 "EHLO
	crown.reflexsecurity.com") by vger.kernel.org with ESMTP
	id S932206AbWHGQXg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 12:23:36 -0400
Date: Mon, 7 Aug 2006 12:23:24 -0400
From: Jason Lunz <lunz@gehennom.net>
To: Jiri Slaby <jirislaby@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       andre@linux-ide.org, pavel@suse.cz, linux-pm@osdl.org,
       linux-ide@vger.kernel.org
Subject: Re: swsusp regression [Was: 2.6.18-rc3-mm2]
Message-ID: <20060807162322.GA17564@knob.reflex>
References: <20060806030809.2cfb0b1e.akpm@osdl.org> <44D707B6.20501@gmail.com>
In-Reply-To: <44D707B6.20501@gmail.com>
User-Agent: Mutt/1.5.12-2006-07-14
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In gmane.linux.kernel, you wrote:
>> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc3/2.6.18-rc3-mm2/
>
> I tried it and guess what :)... swsusp doesn't work :@.
>
> This time I was able to dump process states with sysrq-t:
> http://www.fi.muni.cz/~xslaby/sklad/ide2.gif
>
> My guess is ide2/2.0 dies (hpt370 driver), since last thing kernel prints is 
> suspending device 2.0

Does it go away if you revert this?
ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc3/2.6.18-rc3-mm2/broken-out/ide-reprogram-disk-pio-timings-on-resume.patch

That should only affect resume, not suspend, but it does mess around
with ide power management. Is this maybe happening on the *second*
suspend?

> -hdc: ATAPI 63X DVD-ROM DVD-R CD-R/RW drive, 2048kB Cache, UDMA(33)
> +hdc: ATAPI CD-ROM drive, 0kB Cache, UDMA(33)

This looks suspicious. -mm does have several ide-fix-hpt3xx patches.

Jason
