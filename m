Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269309AbUJKVwb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269309AbUJKVwb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 17:52:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269294AbUJKVwX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 17:52:23 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.103]:2276 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S269293AbUJKVvc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 17:51:32 -0400
Subject: Re: 2.6.9-rc4-mm1 HPET compile problems on AMD64
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Andi Kleen <ak@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20041011212529.GB31731@wotan.suse.de>
References: <1097509362.12861.334.camel@dyn318077bld.beaverton.ibm.com>
	 <20041011125421.106eff07.akpm@osdl.org>
	 <1097526413.12861.374.camel@dyn318077bld.beaverton.ibm.com>
	 <20041011212529.GB31731@wotan.suse.de>
Content-Type: text/plain
Organization: 
Message-Id: <1097530924.12861.392.camel@dyn318077bld.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 11 Oct 2004 14:42:05 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-10-11 at 14:25, Andi Kleen wrote:
> On Mon, Oct 11, 2004 at 01:26:53PM -0700, Badari Pulavarty wrote:
> > On Mon, 2004-10-11 at 12:54, Andrew Morton wrote:
> > 
> > > 
> > > I assume you have CONFIG_HPET=n and CONFIG_HPET_TIMER=n?
> > > 
> > > Andi, what's going on here?  Should the hpet functions in
> > > arch/x86_64/kernel/time.c be inside CONFIG_HPET_TIMER?
> > 
> > I haven't enable HPET, but autoconf.h gets 
> > 
> > # grep HPET autoconf.h
> > #define CONFIG_HPET_TIMER 1
> > #define CONFIG_HPET_EMULATE_RTC 1
> > 
> > # grep HPET .config
> > # CONFIG_HPET is not set
> 
> It should be inside CONFIG_HPET. Badari's patch was correct.

make clean and oldconfig cleaned up little, but I still get
following linking error (without my patch).

# grep HPET .config
# CONFIG_HPET is not set

# grep HPET autoconf.h
#undef CONFIG_HPET

  LD      .tmp_vmlinux1
arch/x86_64/kernel/built-in.o(.init.text+0x2071): In function
`late_hpet_init':
arch/x86_64/kernel/entry.S:259: undefined reference to `hpet_alloc'

Andi, one thing I am not sure is - do you want entire routine
late_hpet_init() under CONFIG_HPET or only parts of it ?

Thanks,
Badari

