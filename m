Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261330AbVBRKdd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261330AbVBRKdd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Feb 2005 05:33:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261335AbVBRKdd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Feb 2005 05:33:33 -0500
Received: from 206.175.9.210.velocitynet.com.au ([210.9.175.206]:52915 "EHLO
	cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S261326AbVBRKcg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Feb 2005 05:32:36 -0500
Subject: Re: Swsusp, resume and kernel versions
From: Nigel Cunningham <ncunningham@cyclades.com>
Reply-To: ncunningham@cyclades.com
To: Stefan Seyfried <seife@suse.de>
Cc: Pavel Machek <pavel@ucw.cz>, LKML <linux-kernel@vger.kernel.org>,
       dtor_core@ameritech.net, Bernard Blackham <bernard@blackham.com.au>
In-Reply-To: <421506FC.3060909@suse.de>
References: <200502162346.26143.dtor_core@ameritech.net>
	 <1108617332.4471.33.camel@desktop.cunningham.myip.net.au>
	 <200502170038.30033.dtor_core@ameritech.net>
	 <1108627778.4471.54.camel@desktop.cunningham.myip.net.au>
	 <421506FC.3060909@suse.de>
Content-Type: text/plain
Message-Id: <1108722865.4077.8.camel@desktop.cunningham.myip.net.au>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Fri, 18 Feb 2005 21:34:25 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stefan.

For Suspend2, we also put a device id in the space, so there's only room
for one character, which is a lower or upper case Z. (We also validate
the device ID, so a random Z won't cause an oops).

Thanks for the code. With your/Suse's permission, I'll ask Bernard
(cc'd) to include the script in the docs somewhere with the appropriate
credit.

Thanks and regards,

Nigel

On Fri, 2005-02-18 at 08:05, Stefan Seyfried wrote:
> Nigel Cunningham wrote:
> 
> > If the mistakenly booted kernel isn't suspend enabled, however, you need
> > a more generic method of removing the image, such as mkswapping the
> > storage device. This is what I was speaking of.
> 
> The following code is used in the SUSE bootscripts to do exactly this:
> 
> ----------------------------------------------------
> get_swap_id() {
>     local line;
>     fdisk -l | while read line; do
>         case "$line" in
>         /*Linux\ [sS]wap*) echo "${line%% *}"
>         esac
>     done
> }
> 
> check_swap_sig () {
>     local part="$(get_swap_id)"
>     local where what type rest p c
>     while read  where what type rest ; do
>         test "$type" = "swap" || continue
>         c=continue
>         for p in $part ; do
>             test "$p" = "$where" && c=true
>         done
>         $c
>         case "$(dd if=$where bs=1 count=6 skip=4086 2>/dev/null)" in
>         S1SUSP|S2SUSP) mkswap $where
>         esac
>     done < /etc/fstab
> }
> ---------------------------------------------------------------------
> 
> This invalidates the suspend signature if the kernel has not already
> done it. It probably does not cover the softwaresuspend2 signature but
> that should be trivial to add.
> 
> Regards,
> 
>   Stefan
-- 
Nigel Cunningham
Software Engineer, Canberra, Australia
http://www.cyclades.com

Ph: +61 (2) 6292 8028      Mob: +61 (417) 100 574

