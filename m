Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262161AbUBXF4m (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 00:56:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262174AbUBXF4m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 00:56:42 -0500
Received: from mail1.amc.com.au ([203.15.175.2]:25101 "HELO mail1.amc.com.au")
	by vger.kernel.org with SMTP id S262161AbUBXF4k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 00:56:40 -0500
From: Stuart Young <sgy-lkml@amc.com.au>
Organization: AMC Enterprises P/L
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       James Simmons <jsimmons@infradead.org>
Subject: Re: fbdv/fbcon pending problems
Date: Tue, 24 Feb 2004 16:57:37 +1100
User-Agent: KMail/1.5.4
Cc: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
References: <1077497593.5960.28.camel@gaston>
In-Reply-To: <1077497593.5960.28.camel@gaston>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200402241657.37382.sgy-lkml@amc.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Feb 2004 11:53 am, Benjamin Herrenschmidt wrote:

>  - Logo problems. When booting with a logo, then going to getty, the
> logo doesn't get erased until we actually switch to another console (or
> reset the console). At this point, using things like vi & scrolling up
> doesn't work properly. Actually, last time I tried, I had to switch
> back & forth twice before my console that had the logo got fully working
> with vi.

Been around forever and a day. RedHat getty's clear the screen, which tends to 
remove the unscrollable region that the logo sits in. Debian doesn't, so it's 
much more noticable (and always has been).

This might be best done thru userspace, as having the logo and other graphics 
sitting at the top of the screen through the boot process (eg: sysv init 
scripts, etc) within an unscrollable region can be useful. I know that the 
boot-icons package in Debian actually relies on this behaviour. Perhaps you 
could provide an option in the kernel config to change this default 
behaviour, for those that want it?

If it's possible to unlock this region so that it scrolls again from userspace 
(ie: not resetting/clearing it, just unlocking it), then it's just a simple 
matter of checking wether the current console is an fb device, and if it is, 
making it unlock the scrolling region. In Debian, this could be done 
in /etc/init.d/rmnologin, or even in /etc/profile if someone would rather it 
done after login.


