Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751095AbWIUJpQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751095AbWIUJpQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 05:45:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751096AbWIUJpQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 05:45:16 -0400
Received: from ns2.suse.de ([195.135.220.15]:61065 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751095AbWIUJpO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 05:45:14 -0400
From: Andi Kleen <ak@suse.de>
To: Mike Galbraith <efault@gmx.de>
Subject: Re: 2.6.18-rc7-mm1
Date: Thu, 21 Sep 2006 11:44:58 +0200
User-Agent: KMail/1.9.3
Cc: Andrew Morton <akpm@osdl.org>, "Rafael J. Wysocki" <rjw@sisk.pl>,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
References: <20060919012848.4482666d.akpm@osdl.org> <20060919133606.f0c92e66.akpm@osdl.org> <1158762221.6512.10.camel@Homer.simpson.net>
In-Reply-To: <1158762221.6512.10.camel@Homer.simpson.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609211144.58950.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 20 September 2006 16:23, Mike Galbraith wrote:
> On Tue, 2006-09-19 at 13:36 -0700, Andrew Morton wrote:
> > On Tue, 19 Sep 2006 22:25:21 +0200
> > "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> > 
> > > > - It took maybe ten hours solid work to get this dogpile vaguely
> > > >   compiling and limping to a login prompt on x86, x86_64 and powerpc. 
> > > >   I guess it's worth briefly testing if you're keen.
> > > 
> > > It's not that bad, but unfortunately the networking doesn't work on my system
> > > (HPC nx6325 + SUSE 10.1 w/ updates, 64-bit).  Apparently, the interfaces don't
> > > get configured (both tg3 and bcm43xx are affected).
> > 
> > Is there anything interesting in the dmesg output?
> > 
> > Perhaps an `strace -f ifup' or whatever would tell us what's failing.
> 
> FYI, it`s SuSE`s /sbin/getcfg binary that doesn't like the changes.  It
> sees /sys/class/net/eth0 as a symlink, and reels off into sys/block (?)
> looking for a directory.

It's a known problem. It's actually libsysfs' fault which somehow manages
to not support symlinks properly. Unfortunately getcfg made the mistake of using libsysfs
instead of accessing /sys directly

-Andi
