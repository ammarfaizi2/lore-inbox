Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261441AbVC0DSf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261441AbVC0DSf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Mar 2005 22:18:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261424AbVC0DSe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Mar 2005 22:18:34 -0500
Received: from ds01.webmacher.de ([213.239.192.226]:62615 "EHLO
	ds01.webmacher.de") by vger.kernel.org with ESMTP id S261441AbVC0DSR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Mar 2005 22:18:17 -0500
In-Reply-To: <200503270200.j2R20eM4006733@laptop11.inf.utfsm.cl>
References: <200503270200.j2R20eM4006733@laptop11.inf.utfsm.cl>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <38a77580c5510faa1a846cf639454923@dalecki.de>
Content-Transfer-Encoding: 7bit
Cc: Arjan van de Ven <arjan@infradead.org>,
       Linux kernel <linux-kernel@vger.kernel.org>, linux-os@analogic.com,
       ext2-devel@lists.sourceforge.net, Jesper Juhl <juhl-lkml@dif.dk>
From: Marcin Dalecki <martin@dalecki.de>
Subject: Re: [PATCH] no need to check for NULL before calling kfree() -fs/ext2/ 
Date: Sun, 27 Mar 2005 05:18:04 +0200
To: Horst von Brand <vonbrand@inf.utfsm.cl>
X-Mailer: Apple Mail (2.619.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2005-03-27, at 04:00, Horst von Brand wrote:
>
>> Needless to say that there are enough architectures out there, which
>> don't even have something like an explicit call as separate assembler
>> instruction...
>
> The mechanism exists somehow.

Most RISC architectures are claiming a huge register set advantage over 
IA32.
However in reality it's normal that:

1. Some of the register take roles as declared by the ABI. One is stack 
one
is basis pointer and so no.
2. Only a subset of register is declared to be guaranteed to be 
preserved by
system calls.

Thus the mechanisms are simple calling conventions.

Compilers can frequently see what a subroutine does and can flatten out 
the cost
of function calls to something very much resembling just two jumps 
instead of
a single jump around a condition.

On the other hand most modern IA32 implementation (since cyrix 486) are 
very
efficient at mapping stack operations to a special cache between the 
CPU and
L1 cache. I could even imagine them to be more efficient then plain 
jumps, which
simply don't carry the same information for cache prefetch and branch 
predition.

