Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263870AbUD0HqI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263870AbUD0HqI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 03:46:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263871AbUD0HqH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 03:46:07 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:4349 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S263870AbUD0HqD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 03:46:03 -0400
X-Mailer: exmh version 2.6.3_20040314 03/14/2004 with nmh-1.0.4
From: Keith Owens <kaos@sgi.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [patch] 2.6.6-rc2 Allow architectures to reenable interrupts on contended spinlocks 
In-reply-to: Your message of "Tue, 27 Apr 2004 16:54:11 +1000."
             <1083048850.11576.19.camel@gaston> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 27 Apr 2004 17:45:52 +1000
Message-ID: <6087.1083051952@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Apr 2004 16:54:11 +1000, 
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
>
>> +#ifdef __HAVE_ARCH_RAW_SPIN_LOCK_FLAGS
>> +#define _raw_spin_lock(lock) _raw_spin_lock_flags(lock, 0)
>> +#else
>> +#define _raw_spin_lock_flags(lock, flags) do { (void)flags; _raw_spin_lock(lock); } while(0)
>> +#endif
>
>Looks good, except as paulus noted that using 0 for flags in the
>_raw_spin_lock() case is wrong, since 0 is a valid flags value
>for some archs that could mean anything... 

0 is valid for ia64, which is the only architecture that currently
defines __HAVE_ARCH_RAW_SPIN_LOCK_FLAGS.  If other architectures want
to define __HAVE_ARCH_RAW_SPIN_LOCK_FLAGS and they need a different
flag value to indicate 'no flags available' then the 0 can be changed
to an arch defined value.  Worry about that if it ever occurs.

