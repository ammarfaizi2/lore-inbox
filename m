Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263866AbTDYKrS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Apr 2003 06:47:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263874AbTDYKrR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Apr 2003 06:47:17 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:25074 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S263866AbTDYKrQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Apr 2003 06:47:16 -0400
Date: Fri, 25 Apr 2003 06:59:26 -0400
From: Jakub Jelinek <jakub@redhat.com>
To: devnetfs <devnetfs@yahoo.com>
Cc: arjanv@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: compiling modules with gcc 3.2
Message-ID: <20030425065926.E13397@devserv.devel.redhat.com>
Reply-To: Jakub Jelinek <jakub@redhat.com>
References: <1051261584.1391.4.camel@laptop.fenrus.com> <20030425104615.7429.qmail@web20415.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030425104615.7429.qmail@web20415.mail.yahoo.com>; from devnetfs@yahoo.com on Fri, Apr 25, 2003 at 03:46:15AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 25, 2003 at 03:46:15AM -0700, devnetfs wrote:
> --- Arjan van de Ven <arjanv@redhat.com> wrote:
> 
> Thanks for the quick reply :)
> 
> > > Either way why is this so? AFAIK gcc 3.2 has abi incompatiblities
> > > w.r.t. C++ and not C (which the kernel+modules are written in).
> > 
> > there are some cornercase C ABI changes but nobody except DAC960 will
> > ever hit those. 
> 
> what are these? i am just curious about the change as i dont
> see them (probably did not search hard) documented/listed on
> gcc site. C++ ABI changes have some mention on some sites, but 
> NOT on C ABI. 

If I remember well, long long bitfields, oversided bitfields, etc.

> so does this mean that: these workarounds now fixed in gcc 3.X?
> and its just that the workaround employed in kernel source (for 
> gcc 2.X) is different than the way gcc 3.X fixes them and hence 
> objects generated from gcc 3.X and 2.X (w.r.t kernel sources+modules)
> dont mix well?

There are couple of places in kernel which do things like:

#if (__GNUC__ > 2)
  typedef struct { } spinlock_t;
  #define SPIN_LOCK_UNLOCKED (spinlock_t) { }
#else
  typedef struct { int gcc_is_buggy; } spinlock_t;
  #define SPIN_LOCK_UNLOCKED (spinlock_t) { 0 }
#endif

Obviously you cannot mix modules/kernels using any structure like that.

	Jakub
