Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268455AbUIWN3N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268455AbUIWN3N (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 09:29:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268457AbUIWN3N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 09:29:13 -0400
Received: from ozlabs.org ([203.10.76.45]:18147 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S268455AbUIWN3H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 09:29:07 -0400
Date: Thu, 23 Sep 2004 23:12:29 +1000
From: Anton Blanchard <anton@samba.org>
To: Dan Kegel <dank@kegel.com>
Cc: Herbert Poetzl <herbert@13thfloor.at>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       arjanv@redhat.com
Subject: Re: 2.6.8 link failure for powerpc-970?
Message-ID: <20040923131229.GA4785@krispykreme>
References: <414E93BC.4080107@kegel.com> <1095669339.2800.3.camel@laptop.fenrus.com> <4150EF69.1060007@kegel.com> <4151AB3D.3040003@kegel.com> <20040922222723.GD30109@MAIL.13thfloor.at> <41525E05.7020506@kegel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41525E05.7020506@kegel.com>
User-Agent: Mutt/1.5.6+20040818i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
> Sure.  For ppc64, beyond allnoconfig, I had to enable
> CONFIG_SYSVIPC
> CONFIG_SYSCTL
> CONFIG_NET
> ... um, but that didn't fix everything.  Now it fails with

OK, I guess we need some better wrapping of compat code.
 
> Um, why is it using the host's gcc?  I ran make with
> make V=1 ARCH=ppc64 
> CROSS_COMPILE=/opt/crosstool/powerpc64-unknown-linux-gnu/gcc-3.4.2-glibc-2.3.3/bin/powerpc64-unknown-linux-gnu-
> so it really should know better, shouldn't it?

Check out arch/ppc64/boot/Makefile, in particular CROSS32_COMPILE. The
boot wrapper is a 32bit binary. 

Now that the toolchain is biarch capable we could get rid of that and
use gcc -m32 instead. But for the moment specify a CROSS32_COMPILE ant
things should link.

Anton
