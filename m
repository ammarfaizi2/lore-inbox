Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932077AbWJEUjd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932077AbWJEUjd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 16:39:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932082AbWJEUjc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 16:39:32 -0400
Received: from smtp.osdl.org ([65.172.181.4]:54166 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932077AbWJEUjb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 16:39:31 -0400
Date: Thu, 5 Oct 2006 13:38:07 -0700
From: Andrew Morton <akpm@osdl.org>
To: Andi Kleen <ak@suse.de>
Cc: Joe Korty <joe.korty@ccur.com>,
       Inaky Perez-Gonzalez <inaky@linux.intel.com>, Paul Jackson <pj@sgi.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bitmap: separate bitmap parsing for user buffer and
 kernel buffer
Message-Id: <20061005133807.97827533.akpm@osdl.org>
In-Reply-To: <p73odsqzgbz.fsf@verdi.suse.de>
References: <200610041756.30528.reinette.chatre@linux.intel.com>
	<20061004181003.6dae6065.akpm@osdl.org>
	<p73odsqzgbz.fsf@verdi.suse.de>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 05 Oct 2006 21:57:04 +0200
Andi Kleen <ak@suse.de> wrote:

> Andrew Morton <akpm@osdl.org> writes:
> 
> > On Wed, 4 Oct 2006 17:56:30 -0700
> > Reinette Chatre <reinette.chatre@linux.intel.com> wrote:
> > 
> > > +			if (is_user) {
> > > +				if (__get_user(c, buf++))
> > > +					return -EFAULT;
> > > +			}
> > > +			else
> > > +				c = *buf++;
> > 
> > Is this actually needed?  __get_user(kernel_address) works OK and (believe
> > it or not, given all the stuff it involves) boils down to a single instruction.		
> 
> It is needed on lots of architectures that use separate address spaces
> like sparc64, m68k, s390 (and on x86 with 4:4 patches) 
> 

It needs set_fs(KERNEL_DS) if we're going to use __get_user() on both
callpaths.

I think we'll stick with the `is_user' version - less tricky, clearer.
