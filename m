Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261344AbTLBG3L (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Dec 2003 01:29:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261368AbTLBG3L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Dec 2003 01:29:11 -0500
Received: from sv1.valinux.co.jp ([210.128.90.2]:55239 "EHLO sv1.valinux.co.jp")
	by vger.kernel.org with ESMTP id S261344AbTLBG3I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Dec 2003 01:29:08 -0500
Date: Tue, 02 Dec 2003 15:43:19 +0900 (JST)
Message-Id: <20031202.154319.84357522.taka@valinux.co.jp>
To: iwamoto@valinux.co.jp
Cc: linux-kernel@vger.kernel.org, tony.luck@intel.com, pavel@suse.cz
Subject: Re: memory hotremove prototype, take 3
From: Hirokazu Takahashi <taka@valinux.co.jp>
In-Reply-To: <20031202030109.3A01B7007A@sv1.valinux.co.jp>
References: <B8E391BBE9FE384DAA4C5C003888BE6F4FAED7@scsmsx401.sc.intel.com>
	<20031202030109.3A01B7007A@sv1.valinux.co.jp>
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.0 (HANANOEN)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

> > > During hotunplug, you copy pages to new locaion. Would it simplify
> > > code if you forced them to be swapped out, instead? [Yep, it would be
> > > slower...]
> > 
> > There are some pages that will have to be copied (e.g. pages that
> > the user "mlock()d" should still be locked in their new location,
> > same for hugetlbfs pages).

And some pages which aren't associated with backing store like sysfs or
ramdisk have to be, too.

> Using kswapd is easy, but doesn't always work well.  The patch
> contains the code to ignore page accessed bits when kswapd is run on
> disabled zones, but that's not enough for swapping out frequently used
> pages.
> In my patch, page copying, or "remapping", solves this problem by
> blocking accesses to the page under operation.

Thank you,
Hirokazu Takahashi.
