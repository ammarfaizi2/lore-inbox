Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269874AbUJMWIc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269874AbUJMWIc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Oct 2004 18:08:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269875AbUJMWIc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Oct 2004 18:08:32 -0400
Received: from rproxy.gmail.com ([64.233.170.193]:56156 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S269874AbUJMWI2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Oct 2004 18:08:28 -0400
Message-ID: <5d6b657504101315086d6ef159@mail.gmail.com>
Date: Thu, 14 Oct 2004 00:08:24 +0200
From: Buddy Lucas <buddy.lucas@gmail.com>
Reply-To: Buddy Lucas <buddy.lucas@gmail.com>
To: Stef van der Made <svdmade@planet.nl>
Subject: Re: Gnome-2.8 stoped working on kernel-2.6.9-rc4-mm1
Cc: Radoslaw Szkodzinski <astralstorm@gmail.com>, linux-kernel@vger.kernel.org
In-Reply-To: <416D9B32.5030408@planet.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <Pine.LNX.4.58.0410131204580.31327@danga.com>
	 <416D8999.7080102@pobox.com>
	 <Pine.LNX.4.58.0410131302190.31327@danga.com>
	 <416D8C33.9080401@osdl.org> <416D923B.3030404@planet.nl>
	 <f44c5fdf041013134726043453@mail.gmail.com>
	 <416D9B32.5030408@planet.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Oct 2004 23:16:34 +0200, Stef van der Made <svdmade@planet.nl> wrote:
> 
> Unpatching optimize-profile-path-slightly.patchsolved the issue. Thanks
> for the tip. You also gave the tip that I should compile without
> -fomit-frame-pointer. I've done this for years without any problem. What
> problems could this cause ?

Compiling with -fomit-frame-pointer removes information from the
binary that could be used for debugging. So the bugbuddy information
you provided was not optimal, because it lacked the crucial stuff. ;-)
The flag does not cause any problems, it is routinely used for
compiling stuff  that doesn't need debugging.


Groeten,
Buddy 

> Thanks again for your help,
> 
> Stef
> 
> 
> 
> 
> Radoslaw Szkodzinski wrote:
> 
> >On Wed, 13 Oct 2004 22:38:19 +0200, Stef van der Made <svdmade@planet.nl> wrote:
> >
> >
> >>I'm trying to get kernel-2.6.9-rc4-mm1 to work with gnome-2.8. While
> >>2.6.9-rc4 works fine with gnome-2.8 the mm1 version has an issue. Any
> >>process that I'm trying to start that uses gnome libraries crashes
> >>immediatly after startup. Mozilla, nautilus and gnome terminal to name a
> >>few. The reason for using mm1 is that I'm using reiser4 for one of my
> >>partitions.
> >>
> >>The output that I get in bugbuddy is as following:
> >>
> >>Backtrace was generated from '/usr/test/garnome2/lib/nautilus'
> >>
> >><snip>
> >>
> >>
> >This was useless, w/o any information.
> >Next time please compile with debugging (-g) and without
> >-fomit-frame-pointer. (in case of gcc <3.5)
> >
> >
> >
> >>And on the terminal that I started X windows:
> >>
> >>"/usr/test/garnome2/lib/nautilus": not in executable format: Is a directory
> >>/home/stef/405: No such file or directory.
> >>/usr/local/mozilla/run-mozilla.sh: line 423:   460 Segmentation
> >>fault      "$prog" ${1+"$@"}
> >><snip>
> >>/usr/local/mozilla/run-mozilla.sh: line 423:   483 Segmentation
> >>fault      "$prog" ${1+"$@"}
> >>
> >>
> >>
> >
> >Looks like you need to back out this patch, the root of all evil:
> >http://kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9-rc4/2.6.9-rc4-mm1/broken-out/optimize-profile-path-slightly.patch
> >like this:
> >cd linux-2.6.9-rc4-mm1
> >patch -p1 -R < /download-dir/optimize-profile-path-slightly.patch
> >-
> >To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> >the body of a message to majordomo@vger.kernel.org
> >More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >Please read the FAQ at  http://www.tux.org/lkml/
> >
> >
> >
> 
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
