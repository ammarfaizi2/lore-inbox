Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262528AbTAVSkQ>; Wed, 22 Jan 2003 13:40:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262602AbTAVSkQ>; Wed, 22 Jan 2003 13:40:16 -0500
Received: from nowaydude.rearden.com ([64.160.169.126]:29752 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id <S262528AbTAVSkP>; Wed, 22 Jan 2003 13:40:15 -0500
Date: Wed, 22 Jan 2003 10:49:28 -0800
From: Andrew Morton <akpm@digeo.com>
To: Brice Goglin <bgoglin@ens-lyon.fr>
Cc: linux-kernel@vger.kernel.org, tigran@veritas.com, davej@suse.de,
       hpa@zytor.com
Subject: Re: copy_from_user broken on i386 since 2.5.57
Message-Id: <20030122104928.769d72da.akpm@digeo.com>
In-Reply-To: <20030122183148.GB23109@ens-lyon.fr>
References: <20030122183148.GB23109@ens-lyon.fr>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 22 Jan 2003 18:49:18.0935 (UTC) FILETIME=[F850F670:01C2C246]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brice Goglin <bgoglin@ens-lyon.fr> wrote:
>
> Hi,
> 
> Trying to compile a very very simple module for 2.5,
> I got an error from gcc saying that assembly code
> is incorrect.
> This problem appeared in 2.5.57 and is still here
> in 2.5.59.
> I only tried on i386.
> 
> Here's a very simple example code :
> 
> #define __KERNEL__
> #define MODULE
> #include "linux/module.h"
> #include "asm/uaccess.h"
> 
> int func(void *to, const void *from) {
>   return __copy_from_user(to, from, 1);
> }
> 
> 
> Here's gcc report :
> 
> mp760:~/tmp% gcc user.c -c -o user.o -Ipath_to_2.5.57/include
> /tmp/cceAbcRd.s: Assembler messages:
> /tmp/cceAbcRd.s:120: Error: `%al' not allowed with `movl'
> /tmp/cceAbcRd.s:124: Error: `%al' not allowed with `xorl'
> /tmp/cceAbcRd.s:209: Warning: using `%eax' instead of `%ax' due to `l' suffix
> /tmp/cceAbcRd.s:213: Warning: using `%eax' instead of `%ax' due to `l' suffix
> /tmp/cceAbcRd.s:213: Warning: using `%eax' instead of `%ax' due to `l' suffix

Add `-O2' to the compiler switches.

No, I don't know either ;)


