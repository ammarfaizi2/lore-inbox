Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261720AbUKTBF2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261720AbUKTBF2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 20:05:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262867AbUKTBEB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 20:04:01 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.103]:29846 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262820AbUKTBCY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 20:02:24 -0500
Subject: Re: 2.6.10-rc2-mm2 crashes in early boot
From: Dave Hansen <haveblue@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Haren Myneni [imap]" <haren@us.ibm.com>
In-Reply-To: <1100909034.6236.11.camel@localhost>
References: <1100909034.6236.11.camel@localhost>
Content-Type: text/plain
Message-Id: <1100912538.8629.2.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 19 Nov 2004 17:02:18 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-11-19 at 16:03, Dave Hansen wrote:
> I enabled crashdump on 2.6.10-rc2-mm2 with CONFIG_SMP=y and hit the bug
> in smp_alloc_memory() because trampoline_base was allocated too high. 
> It needs to be below 0x9F000 and crash_reserve_bootmem() reserves
> everything below 0xa0000.  I'm not sure how this ever worked with SMP.  
> 
> Here's my .config: http://sprucegoose.sr71.net/~dave/lkcd-config
> 
> Commenting out the following line makes it boot:
> 
> static inline void crash_reserve_bootmem(void)
> {
>         if (!dump_enabled) {
> ------->        reserve_bootmem(0, CRASH_RELOCATE_SIZE);
>                 reserve_bootmem(CRASH_BACKUP_BASE,
>                         CRASH_BACKUP_SIZE + CRASH_RELOCATE_SIZE + PAGE_SIZE);
>         }
> }

OK, found the patch:

http://marc.theaimsgroup.com/?l=linux-kernel&m=110078720123943&w=2

Do we really still need the CRASH_RELOCATE_SIZE #define?  What is it
there for?

-- Dave

