Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267840AbUIPIXU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267840AbUIPIXU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 04:23:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267841AbUIPIXU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 04:23:20 -0400
Received: from witte.sonytel.be ([80.88.33.193]:12994 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S267840AbUIPIXS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 04:23:18 -0400
Date: Thu, 16 Sep 2004 10:23:08 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linux/m68k <linux-m68k@lists.linux-m68k.org>,
       Debian GNU/Linux m68k <debian-68k@lists.debian.org>,
       uClinux list <uclinux-dev@uclinux.org>,
       GNU Libc Maintainers <debian-glibc@lists.debian.org>
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: `new' syscalls for m68k
In-Reply-To: <Pine.LNX.4.58.0409102250300.24607@anakin>
Message-ID: <Pine.GSO.4.58.0409161016400.23693@waterleaf.sonytel.be>
References: <Pine.LNX.4.58.0409102250300.24607@anakin>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Sep 2004, Geert Uytterhoeven wrote:
> I'm updating the syscall table for m68k...
>
> Below is a patch that adds all syscalls that m68k is currently lacking
> (compared to ia32). However, I'm wondering whether we need all of them:
>   - Are sys_sched_[gs]etaffinity() needed for non-SMP?
>   - I disabled [sg]et_thread_area() since sys_[gs]et_thread_area() are
>     missing. Do we have to implement them, or should we use some other
>     method for Thread Local Storage?
>   - What about sys_vserver()?
>   - What about sys_kexec_load()?
>   - Any others we can/should drop?

My conclusion (so far). I will:
  - drop sys_sched_[gs]etaffinity() (no SMP on m68k), and sys_kexec_load()
  - reserve an entry for sys_vserver()
  - add waitid() (2.6.9-rc2)
  - rename p{read,write}64() to p{read,write} (cfr. m68knommu in 2.6.8.1-uc0)

Which leaves us with [sg]et_thread_area(): what do the glibc hackers have in
mind for TLS on m68k?

Thanks!

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
