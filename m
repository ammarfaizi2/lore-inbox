Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269704AbUJVNxt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269704AbUJVNxt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 09:53:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269755AbUJVNwU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 09:52:20 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:11528 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S269762AbUJVNu7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 09:50:59 -0400
Date: Fri, 22 Oct 2004 15:50:26 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, Christoph Lameter <clameter@sgi.com>
Cc: linux-kernel@vger.kernel.org, jgarzik@pobox.com, linux-net@vger.kernel.org
Subject: 2.6.9-mm1: timer_event multiple definition
Message-ID: <20041022135026.GC2831@stusta.de>
References: <20041022032039.730eb226.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041022032039.730eb226.akpm@osdl.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 22, 2004 at 03:20:39AM -0700, Andrew Morton wrote:
>...
> Changes since 2.6.9-rc4-mm1:
>...
> +posix-layer-clock-driver-api-fix.patch
> 
>  posix clock api fix
>...

This causes the following compile error:

<--  snip  -->

...
  LD      .tmp_vmlinux1
drivers/built-in.o(.text+0x30a210): In function `timer_event':
: multiple definition of `timer_event'
kernel/built-in.o(.text+0x16270): first defined here
ld: Warning: size of symbol `timer_event' changed from 157 in 
kernel/built-in.o to 11 in drivers/built-in.o
make: *** [.tmp_vmlinux1] Error 1

<--  snip  -->


I'd say drivers/net/skfp/queue.c is more at fault for using the pretty 
generic timer_event name...


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

