Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261326AbVFNU1z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261326AbVFNU1z (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Jun 2005 16:27:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261328AbVFNU1z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Jun 2005 16:27:55 -0400
Received: from smtp.osdl.org ([65.172.181.4]:20941 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261326AbVFNU1w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Jun 2005 16:27:52 -0400
Date: Tue, 14 Jun 2005 13:27:21 -0700
From: Andrew Morton <akpm@osdl.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: bonganilinux@mweb.co.za, ak@muc.de, linux-kernel@vger.kernel.org
Subject: Re: Tracking a bug in x86-64
Message-Id: <20050614132721.3b55c196.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0506140819440.8487@ppc970.osdl.org>
References: <200506132259.22151.bonganilinux@mweb.co.za>
	<200506132339.13614.bonganilinux@mweb.co.za>
	<Pine.LNX.4.58.0506140819440.8487@ppc970.osdl.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> wrote:
>
> The way to do the binary searach is to get the
> 
>  	ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.11/2.6.11-mm1/2.6.11-mm1-broken-out.tar.gz 
> 
>  file, and then to apply half of the patches

Or:

- install https://savannah.nongnu.org/projects/quilt/

cd /usr/src/linux
wget ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.11/2.6.11-mm1/2.6.11-mm1-broken-out.tar.gz
tar xfz 2.6.11-mm1-broken-out.tar.gz
mv broken-out patches
mv patches/series .

Now you can do `quilt push 100' to apply 100 patches, `quilt pop 50' to
remove half of them, etc.

Open a copy of the series file in an editor and add markers to it as you
proceed through the search so you don't get lost.

Avoid applying obviously-broken patches.  For example, we have, in the
series file:

posix-timers-cpu-clock-support-for-posix-timers.patch
posix-timers-cpu-clock-support-for-posix-timers-fix.patch
posix-timers-cpu-clock-support-for-posix-timers-fix3.patch

That's one patch plus two fixes to it.  You'd either apply all of these or none.

There's a bit of setup but once quilt is installed it's all pretty easy and
quick.

