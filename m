Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261451AbUGEUzv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261451AbUGEUzv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jul 2004 16:55:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262101AbUGEUzv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jul 2004 16:55:51 -0400
Received: from fw.osdl.org ([65.172.181.6]:22679 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261451AbUGEUzt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jul 2004 16:55:49 -0400
Date: Mon, 5 Jul 2004 13:54:44 -0700
From: Andrew Morton <akpm@osdl.org>
To: jhf@rivenstone.net (Joseph Fannin)
Cc: linux-kernel@vger.kernel.org, paulus@samba.org, benh@kernel.crashing.org
Subject: Re: 2.6.7-mm6 - ppc32 inconsistent kallsyms data
Message-Id: <20040705135444.1b5a728a.akpm@osdl.org>
In-Reply-To: <20040705203818.GA11625@samarkand.rivenstone.net>
References: <20040705023120.34f7772b.akpm@osdl.org>
	<20040705203818.GA11625@samarkand.rivenstone.net>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jhf@rivenstone.net (Joseph Fannin) wrote:
>
> On Mon, Jul 05, 2004 at 02:31:20AM -0700, Andrew Morton wrote:
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.7/2.6.7-mm6/
> 
>   I'm getting this while building for ppc32:
>     
>     Inconsistent kallsyms data, try setting CONFIG_KALLSYMS_EXTRA_PASS
> 
>   This didn't happen with -mm5.
> 
>   The help text for CONFIG_KALLSYMS_EXTRA_PASS says I should report a
> bug, and reads like kallsyms is a utility or part of the toolchain;
> I think it's talking about the kernel feature though, so I guess
> I'll report it here.  I'll keep this tree around in case any more
> information is needed.
> 

The kernel's kallsyms feature does, roughly, this:

- generate vmlinux
- generate a list of symbols from it
- turn those symbols into a C array
- generate a new vmlinux which includes that C array

All this assumes that the symbols in the fist and second vmlinux's fall at
the same addresses.  But for some reason, that doesn't always happen.  End
result: the second vmlinux's kallsyms info is wrong.  It's not clear why
the linker does this.

The third kallsyms pass will generate a list of symbols from the vmlinux+C
array and will again generate a vmlinux+C array.  It turns out that this is
stable.
