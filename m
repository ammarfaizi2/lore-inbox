Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261748AbSJIOTd>; Wed, 9 Oct 2002 10:19:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261751AbSJIOTd>; Wed, 9 Oct 2002 10:19:33 -0400
Received: from smtp06.iddeo.es ([62.81.186.16]:3283 "EHLO smtp06.retemail.es")
	by vger.kernel.org with ESMTP id <S261748AbSJIOT0>;
	Wed, 9 Oct 2002 10:19:26 -0400
Date: Wed, 9 Oct 2002 16:24:58 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: root@chaos.analogic.com
Cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Writable global section?
Message-ID: <20021009142458.GA2243@werewolf.able.es>
References: <Pine.LNX.3.95.1021009090703.31255B-100000@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <Pine.LNX.3.95.1021009090703.31255B-100000@chaos.analogic.com>; from root@chaos.analogic.com on Wed, Oct 09, 2002 at 15:08:44 +0200
X-Mailer: Balsa 1.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2002.10.09 Richard B. Johnson wrote:
>
> 
> When using shared libraries, is there a ".section" into which
> I can put a variable that's writable? I note that when programs
> that use shared libraries start, the pages are mprotect(ed)
> PROT_READ|PROT_EXEC, but sometimes I see PROT_WRITE on some
> pages.
> 
> I'd like to rip out a memory-mapped semiphore and put it directly
> in a shared library if possible.
> 

A library can define global variables visible to others, has its own BSS:

int x;

void f()
{
}

built with gcc -shared, and nm'ed gives:

00000694 T f
000017f8 B x
000016f8 D y

from man nm:
  "B" The symbol is in the uninitialized data section (known as BSS).
  "D" The symbol is in the initialized data section.
  "T" The symbol is in the text (code) section.

Was about this or I misunderstood you ?

-- 
J.A. Magallon <jamagallon@able.es>      \                 Software is like sex:
werewolf.able.es                         \           It's better when it's free
Mandrake Linux release 9.1 (Cooker) for i586
Linux 2.4.20-pre10-jam1 (gcc 3.2 (Mandrake Linux 9.0 3.2-2mdk))
