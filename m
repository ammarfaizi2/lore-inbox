Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262073AbTHTRK1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Aug 2003 13:10:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262078AbTHTRK1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Aug 2003 13:10:27 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:26762 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S262073AbTHTRKX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Aug 2003 13:10:23 -0400
Subject: Re: [PATCH][2.6][2/5]Support for HPET based timer
From: Dave Hansen <haveblue@us.ibm.com>
To: Andi Kleen <ak@suse.de>
Cc: Vojtech Pavlik <vojtech@suse.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       venkatesh.pallipadi@intel.com
In-Reply-To: <p731xvg7imu.fsf@oldwotan.suse.de>
References: <C8C38546F90ABF408A5961FC01FDBF1902C7D1C9@fmsmsx405.fm.intel.com.suse.lists.linux.kernel>
	 <20030820080513.GB17793@ucw.cz.suse.lists.linux.kernel>
	 <p731xvg7imu.fsf@oldwotan.suse.de>
Content-Type: text/plain
Organization: 
Message-Id: <1061399370.30807.151.camel@nighthawk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 20 Aug 2003 10:09:31 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-08-20 at 03:01, Andi Kleen wrote:
> Vojtech Pavlik <vojtech@suse.cz> writes:
> 
> > On Tue, Aug 19, 2003 at 05:18:50PM -0700, Pallipadi, Venkatesh wrote:
> > 
> > > Fixmap is for HPET memory map address access. As the timer
> > > initialization happen 
> > > early in the boot sequence (before vm initialization), we need to have
> > > fixmap() 
> > > and fix_to_virt() to access HPET memory map address.
> > 
> > Ahh, yes, you're right. You can't use ioremap at that time. Actually I
> > did the same on x86_64 not only because of vsyscalls.
> 
> iirc i386 has an ioremap_early or somesuch.

Yep, we have boot_ioremap().  It's used to do ioremap() even while we're
still using the original early boot pagetables (before paging_init()):
arch/i386/mm/boot_ioremap.c

-- 
Dave Hansen
haveblue@us.ibm.com

