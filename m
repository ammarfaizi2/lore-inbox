Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262491AbTJJNPw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Oct 2003 09:15:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262626AbTJJNPw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Oct 2003 09:15:52 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:24590 "EHLO
	www.home.local") by vger.kernel.org with ESMTP id S262491AbTJJNPr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Oct 2003 09:15:47 -0400
Date: Fri, 10 Oct 2003 15:15:40 +0200
From: Willy Tarreau <willy@w.ods.org>
To: SMS WebMaster <sms@4-sms.com>
Cc: Willy Tarreau <willy@w.ods.org>, linux-kernel@vger.kernel.org,
       linux-config@vger.kernel.org, linux-userfs@vger.kernel.org
Subject: Re: mount: / mounted already or bad option
Message-ID: <20031010131540.GA7313@alpha.home.local>
References: <3F86C17A.8060209@4-sms.com> <20031010125052.GB7202@alpha.home.local> <3F86D1C9.10003@4-sms.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F86D1C9.10003@4-sms.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 10, 2003 at 06:35:37PM +0300, SMS WebMaster wrote:
> >>and when I login with the root and type
> >>mount -o remount,rw /
> >>
> >>I got the same message
> >>mount: / mounted already or bad option
> >>
> >>but if I write
> >>mount -o remount,rw /dev/hda4  /
> >>then the root filesystem if remounted as read/write
> >
> >
> >wouldn't your /etc/mtab be a link to /proc/self/mounts with /proc not 
> >mounted ?
> 
> 
> Sorry what do you mean ?

I meant that when you use the "incomplete" syntax with mount (ie: no device
specified), it relies on /etc/mtab to find the mount entry you want to change.
And it's somewhat common to have /etc/mtab be a symlink to /proc/self/mounts
when you don't want /etc to be written to, because the 'mounts' entry has
nearly the same format as 'mtab' (a few missing options). Now if it was the
case, and /proc was not mounted yet, /etc/mtab would point to nowhere and mount
would have no way to find what was mounted on '/', which could lead to some
errors like this.

> if I type mount I can see that proc is mounted (I can even see / is 
> mounted as read/write but its not realy mounted as read/write)

OK, so it doesn't come from this. Perhaps your /etc/mtab is simply broken by
some random mount option somewhere ? Also, do you use the "read-only" option
on the kernel command line ? And do your init scripts clear /etc/mtab at boot,
before the first mounts ?

Willy

