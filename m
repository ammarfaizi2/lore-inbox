Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265151AbTLROCZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Dec 2003 09:02:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265154AbTLROCZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Dec 2003 09:02:25 -0500
Received: from lists.us.dell.com ([143.166.224.162]:49553 "EHLO
	lists.us.dell.com") by vger.kernel.org with ESMTP id S265151AbTLROCY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Dec 2003 09:02:24 -0500
Date: Thu, 18 Dec 2003 08:02:16 -0600
From: Matt Domsch <Matt_Domsch@dell.com>
To: Meelis Roos <mroos@linux.ee>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Anton Altaparmakov <aia21@cam.ac.uk>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.23-bk bogus edd changeset - Re: 2.4.23 compile error in edd
Message-ID: <20031218080216.A30913@lists.us.dell.com>
References: <20031205113619.A20371@lists.us.dell.com> <Pine.GSO.4.44.0312181330150.5204-100000@math.ut.ee>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.GSO.4.44.0312181330150.5204-100000@math.ut.ee>; from mroos@linux.ee on Thu, Dec 18, 2003 at 01:32:20PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Same here - instant reboot when EDD is enabled. Do you need my config
> also? The mainboard is Intel D815EEA2 with latest BIOS
> (EA81520A.86A.0039.P21.0211061753).

Ok, 2 reports now.  With Anton off getting married, can you assist
with debugging this (I've tried, and can't reproduce it on any systems
available to me) ?

In include/asm-i386/edd.h, change:
#define DISK80_SIG_BUFFER 0x228

to

#define DISK80_SIG_BUFFER 0x2cc

and see if that helps.  What I'm thinking right now is that 0x228 is
being used by a boot loader somehow (what's your boot loader?) though I can't
yet prove it, and it isn't listed in
Documentation/i386/zero-page.txt.  But Anton showed that the int13
calls the EDD code makes (or even if you remove those) succeeds, but
by writing something into 0x228 the kernel uncompress fails.  I'm
hoping that by moving the buffer to 0x2cc (immediately before the e820
memory map reserved space) that it will succeed.

Thanks,
Matt


-- 
Matt Domsch
Sr. Software Engineer, Lead Engineer
Dell Linux Solutions www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com
