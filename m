Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269840AbUJMUrL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269840AbUJMUrL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Oct 2004 16:47:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269842AbUJMUrL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Oct 2004 16:47:11 -0400
Received: from rproxy.gmail.com ([64.233.170.203]:51619 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S269840AbUJMUrE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Oct 2004 16:47:04 -0400
Message-ID: <f44c5fdf041013134726043453@mail.gmail.com>
Date: Wed, 13 Oct 2004 22:47:00 +0200
From: Radoslaw Szkodzinski <astralstorm@gmail.com>
Reply-To: Radoslaw Szkodzinski <astralstorm@gmail.com>
To: Stef van der Made <svdmade@planet.nl>
Subject: Re: Gnome-2.8 stoped working on kernel-2.6.9-rc4-mm1
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <416D923B.3030404@planet.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <Pine.LNX.4.58.0410131204580.31327@danga.com>
	 <416D8999.7080102@pobox.com>
	 <Pine.LNX.4.58.0410131302190.31327@danga.com>
	 <416D8C33.9080401@osdl.org> <416D923B.3030404@planet.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Oct 2004 22:38:19 +0200, Stef van der Made <svdmade@planet.nl> wrote:
> 
> I'm trying to get kernel-2.6.9-rc4-mm1 to work with gnome-2.8. While
> 2.6.9-rc4 works fine with gnome-2.8 the mm1 version has an issue. Any
> process that I'm trying to start that uses gnome libraries crashes
> immediatly after startup. Mozilla, nautilus and gnome terminal to name a
> few. The reason for using mm1 is that I'm using reiser4 for one of my
> partitions.
> 
> The output that I get in bugbuddy is as following:
> 
> Backtrace was generated from '/usr/test/garnome2/lib/nautilus'
> 
> <snip>
This was useless, w/o any information.
Next time please compile with debugging (-g) and without
-fomit-frame-pointer. (in case of gcc <3.5)

> 
> And on the terminal that I started X windows:
> 
> "/usr/test/garnome2/lib/nautilus": not in executable format: Is a directory
> /home/stef/405: No such file or directory.
> /usr/local/mozilla/run-mozilla.sh: line 423:   460 Segmentation
> fault      "$prog" ${1+"$@"}
> <snip>
> /usr/local/mozilla/run-mozilla.sh: line 423:   483 Segmentation
> fault      "$prog" ${1+"$@"}
> 

Looks like you need to back out this patch, the root of all evil:
http://kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9-rc4/2.6.9-rc4-mm1/broken-out/optimize-profile-path-slightly.patch
like this:
cd linux-2.6.9-rc4-mm1
patch -p1 -R < /download-dir/optimize-profile-path-slightly.patch
