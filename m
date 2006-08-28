Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932468AbWH1Hle@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932468AbWH1Hle (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 03:41:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932464AbWH1Hle
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 03:41:34 -0400
Received: from moutng.kundenserver.de ([212.227.126.171]:38650 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S932419AbWH1Hld (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 03:41:33 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Andi Kleen <ak@suse.de>
Subject: Re: [PATCH 6/7] remove all remaining _syscallX macros
Date: Mon, 28 Aug 2006 09:41:10 +0200
User-Agent: KMail/1.9.1
Cc: linux-arch@vger.kernel.org, Jeff Dike <jdike@addtoit.com>,
       Bjoern Steinbrink <B.Steinbrink@gmx.de>,
       Arjan van de Ven <arjan@infradead.org>,
       Chase Venters <chase.venters@clientec.com>,
       Andrew Morton <akpm@osdl.org>, Russell King <rmk+lkml@arm.linux.org.uk>,
       rusty@rustcorp.com.au, linux-kernel@vger.kernel.org
References: <20060827214734.252316000@klappe.arndb.de> <20060827215637.555365000@klappe.arndb.de> <p73ac5pe2iy.fsf@verdi.suse.de>
In-Reply-To: <p73ac5pe2iy.fsf@verdi.suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608280941.10965.arnd@arndb.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 28 August 2006 09:35, Andi Kleen wrote:
> I would prefer to keep them on i386/x86-64 at least because
> a lot of my test programs are using them.
> 
Hmm, maybe we should have an asm-generic/unistd.h then
containing something like

#ifndef __KERNEL__
#include <sys/syscall.h>
#define _syscall0(type,name) \
type name(type1 arg1) \
{ \
	return syscall(__NR_ ## name); \
}
#define _syscall1(type,name,type1,arg1) \
type name(type1 arg1) \
{ \
	return syscall(__NR_ ## name, arg1); \
}
#define _syscall1(type,name,type1,arg1,type2,arg2) \
type name(type1 arg1, type2 arg2) \
{ \
	return syscall(__NR_ ## name, arg1, arg2); \
}
// ...
#endif

	Arnd <><
