Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267786AbUBTGfp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 01:35:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267788AbUBTGfp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 01:35:45 -0500
Received: from nwkea-mail-2.sun.com ([192.18.42.14]:2710 "EHLO
	nwkea-mail-2.sun.com") by vger.kernel.org with ESMTP
	id S267786AbUBTGfg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 01:35:36 -0500
Date: Thu, 19 Feb 2004 22:35:19 -0800
From: Tim Hockin <thockin@sun.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: PATCH: report NGROUPS_MAX via a sysctl (read-only)
Message-ID: <20040220063519.GP9155@sun.com>
Reply-To: thockin@sun.com
References: <20040220023927.GN9155@sun.com> <20040219213028.42835364.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040219213028.42835364.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 19, 2004 at 09:30:28PM -0800, Andrew Morton wrote:
> >  Attached is a simple patch to expose NGROUPS_MAX via sysctl.
> 
> Why does userspace actually care?  You try to do an oversized setgroups(),
> so you get an error?

I am systematically tracking down apps that use it.  glibc is almost free of
it.  sysconf() still uses it, but as long as the value compiled into glibc
as NGROUPS_MAX is less-than-or-equal-to the current kernel's idea, it meets
POSIX, right?  If any one goes into their kernel source and lowers
NGROUPS_MAX they might break things, but I guess that isn't too big of a
worry.  Some apps are still assuming that the value they get from sysconf()
is the absolute max number of groups.  Anyone with libc compiled against an
older kernel will see 32, when they could have 64k.

> And why does NGROUPS_MAX still exist, come to that?  AFAICT the only thing

Because Linus would not let me set it to INT_MAX. Something about
"insanity" ;)

As long as we can convince userspace apps to not trust sysconf() or
NGROUPS_MAX constants, I guess we don't *need* it exposed.  I guess that's a
veto, then? 

-- 
Tim Hockin
Sun Microsystems, Linux Software Engineering
thockin@sun.com
All opinions are my own, not Sun's
