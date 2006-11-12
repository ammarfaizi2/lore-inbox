Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932909AbWKLOLE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932909AbWKLOLE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Nov 2006 09:11:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932911AbWKLOLE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Nov 2006 09:11:04 -0500
Received: from mail-in-03.arcor-online.net ([151.189.21.43]:63934 "EHLO
	mail-in-03.arcor-online.net") by vger.kernel.org with ESMTP
	id S932909AbWKLOLB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Nov 2006 09:11:01 -0500
In-Reply-To: <200611121436.15492.bero@arklinux.org>
References: <200611112334.28889.bero@arklinux.org> <200611121005.58939.bero@arklinux.org> <4556E860.700@qumranet.com> <200611121436.15492.bero@arklinux.org>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <2688EFDC-868B-4BC6-AC02-79BE61419CB3@kernel.crashing.org>
Cc: Avi Kivity <avi@qumranet.com>, linux-kernel@vger.kernel.org, akpm@osdl.org
Content-Transfer-Encoding: 7bit
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: 2.6.19-rc5-mm1 fails to compile with gcc 4.2
Date: Sun, 12 Nov 2006 15:10:55 +0100
To: Bernhard Rosenkraenzer <bero@arklinux.org>
X-Mailer: Apple Mail (2.752.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>> It does look like a gcc bug -- -O0 makes it go away.
>>> Details at http://gcc.gnu.org/bugzilla/show_bug.cgi?id=29808
>>
>> That's a different bug, gcc generates code that the assembler can't
>> handle.  Might be an assembler bug.
>
> It's the same thing, the code is taken from kvm_main.c:
>
> static void load_fs(u16 sel)
> {
>         asm ("mov %0, %%fs" : : "g"(sel));	<--- line 153
> }

Like I said in GCC PR29808, it's invalid -- use "r" instead.


Segher

