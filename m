Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318715AbSHQShy>; Sat, 17 Aug 2002 14:37:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318716AbSHQShy>; Sat, 17 Aug 2002 14:37:54 -0400
Received: from mx2.elte.hu ([157.181.151.9]:12197 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S318715AbSHQShx>;
	Sat, 17 Aug 2002 14:37:53 -0400
Date: Sat, 17 Aug 2002 20:42:39 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Gabriel Paubert <paubert@iram.es>,
       James Bottomley <James.Bottomley@HansenPartnership.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: Boot failure in 2.5.31 BK with new TLS patch
In-Reply-To: <Pine.LNX.4.44.0208171134070.3169-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.44.0208172041480.16545-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 17 Aug 2002, Linus Torvalds wrote:

> The gdt descriptor alignment really shouldn't matter, but that bogus GDT
> _size_ thing in the descriptor might do it.
> 
> Right now it's set to be 0x8000, which is not a legal GDT size (it
> should be of the form n*8-1), and is nonsensical anyway (the comment
> says 2048 entries, but the fact is, we don't _have_ 2048 entries in
> there).

hm, in BK-curr it's set to:

SYMBOL_NAME(cpu_gdt_descr):
        .word GDT_ENTRIES*8-1
        .long SYMBOL_NAME(cpu_gdt_table)

this should be the correct value, right? Where do we have a 0x8000 size
value?

and the per-CPU GDT gets set up before being loaded.

	Ingo

