Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268295AbTGIOyA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jul 2003 10:54:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268296AbTGIOyA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jul 2003 10:54:00 -0400
Received: from asplinux.ru ([195.133.213.194]:2067 "EHLO relay.asplinux.ru")
	by vger.kernel.org with ESMTP id S268295AbTGIOx5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jul 2003 10:53:57 -0400
Content-Type: text/plain; charset=US-ASCII
From: Kirill Korotaev <dev@sw.ru>
Organization: SW Soft
To: Andi Kleen <ak@suse.de>
Subject: Re: [announce, patch] 4G/4G split on x86, 64 GB RAM (and more) support
Date: Wed, 9 Jul 2003 19:17:35 +0400
User-Agent: KMail/1.4.2
References: <E19aCeB-000ICs-00.kksx-mail-ru@f23.mail.ru.suse.lists.linux.kernel> <200307091851.33438.dev@sw.ru> <20030709164852.523093a3.ak@suse.de>
In-Reply-To: <20030709164852.523093a3.ak@suse.de>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200307091917.35500.dev@sw.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I added a printf for the actual stack

> thread_self=4000
> my stack 0xbffff4df
> attr_init stack=00000000, stack_size=001FF000

> That's the output for pthread_attr_init. The manpage says it should fill in
> the default values and a 0 base is not that unreasonable for it.
0 is ok, the problem is in get_stackaddr.

> stack rlimit=1ff000
> thread=4000, stack=40035480, stack_size=40035480
> For the main() thread it's wrong.

exactly! For the main thread pthread_get_stackaddr returns a bull shit always 
:(

But at least java 1.3 has workaround inside and handles this magic value 
separatly and doesn't crash whis 3/1GB split (this value depends on TASK_SIZE 
or more preciesly on current stack value aligned to some big boundary (AFAIR, 
1GB)).

Anyway it's definietly a bug. I have a fix in a preloading .so library for 
glibc which overrides pthread_getstack_addr symbol. If you wish I can send it 
to you.

> my stack 0xbf7ffaab
> attr_init stack=00000000, stack_size=001FF000
> stack rlimit=1ff000
> thread=4002, stack=BF800000, stack_size=001FF000
>
> For the others everything is correct.
true.

[skip]

Kirill

