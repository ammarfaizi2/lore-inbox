Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932415AbVLITRx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932415AbVLITRx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Dec 2005 14:17:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751317AbVLITRx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Dec 2005 14:17:53 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:10377 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751315AbVLITRx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Dec 2005 14:17:53 -0500
Date: Fri, 9 Dec 2005 20:17:35 +0100
From: Pavel Machek <pavel@suse.cz>
To: Stefan Seyfried <seife@suse.de>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, LKML <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH][mm] swsusp: limit image size
Message-ID: <20051209191735.GB4658@elf.ucw.cz>
References: <200512072246.06222.rjw@sisk.pl> <4399A737.40809@suse.de> <200512091804.22397.rjw@sisk.pl> <4399CD28.9080000@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4399CD28.9080000@suse.de>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >> What happens if IMAGE_SIZE is bigger than free swap? Do we "try harder"
> >> or do we fail?
> > 
> > First, with swsusp the image can't be bigger than 1/2 of lowmem (1/2 of RAM
> > on x86-64) and the too great values of IMAGE_SIZE have no effect.  Still, if
> > the amount of free swap is smaller than 1/2 of RAM and the image happens
> > to be bigger, we will fail.
> 
> ok. This is not nice since we might fail without any _real_ need. Can we
> make this parameter userspace-tweakable, so that my userspace app can do
> something like (pseudocode):
> 
>     echo 500 > /sys/power/swsusp/imagesize
>     echo disk > /sys/power/state
>     R=$?
>     if [ $R -eq $ENOMEM ]; then
>         echo 100 > /sys/power/swsusp/imagesize # try again

You can do 'echo 0' -- as small as possible.

>         echo disk > /sys/power/state
>         R=$?
>     fi
>     if [ $R -ne 0 ]; then
>         pop_up_some_loud_beeping_window "suspend failed!"
>     fi
> 
> This would at least give us a chance for a second try. I know that Pavel
> dislikes userspace tunables, but i dislike failing suspends ;-)

Can we do that when we start seeing failed suspends? I think it will
not happen. If we have reasonably-sized swap partition, it should be
ok.

							Pavel
-- 
Thanks, Sharp!
