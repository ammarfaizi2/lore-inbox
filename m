Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267307AbTAGF3R>; Tue, 7 Jan 2003 00:29:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267308AbTAGF3R>; Tue, 7 Jan 2003 00:29:17 -0500
Received: from TYO202.gate.nec.co.jp ([202.32.8.202]:12499 "EHLO
	TYO202.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id <S267307AbTAGF3Q>; Tue, 7 Jan 2003 00:29:16 -0500
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Embed __this_module in module itself.
References: <20021227104328.143DD2C05D@lists.samba.org>
	<buou1gma6bz.fsf@mcspd15.ucom.lsi.nec.co.jp>
Reply-To: Miles Bader <miles@gnu.org>
System-Type: i686-pc-linux-gnu
Blat: Foop
From: Miles Bader <miles@lsi.nec.co.jp>
Date: 07 Jan 2003 14:36:54 +0900
In-Reply-To: <buou1gma6bz.fsf@mcspd15.ucom.lsi.nec.co.jp>
Message-ID: <buoadid1pxl.fsf@mcspd15.ucom.lsi.nec.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miles Bader <miles@lsi.nec.co.jp> writes:
> When I try to build modules using 2.5.54, the resulting .ko files lack
> the .gnu.linkonce.* sections, which causes the kernel module loader to
> fail on them -- those sections _are_ present in the .o files, but the
> linker apparently removes them!

Ok, I found out why this is happening -- the v850 default linker
scripts, for whatever reason, merge any section called `.gnu.linker.t*'
with .text.

I can prevent this by adding the option `--unique=.gnu.linkonce.this_module'
to the linker flags (specifically, to LDFLAGS_MODULE in the top-level
Makefile).  I suppose another way to do it would be to rename the
section something that doesn't match `.gnu.linker.t*'.

What's the right way to handle this?

[from perusing the ld srcs, a few other archs seem to have the same
`feature,' though the only that I think has linux support is `cris']

Thanks,

-Miles
-- 
The secret to creativity is knowing how to hide your sources.
  --Albert Einstein
