Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318221AbSHGQvo>; Wed, 7 Aug 2002 12:51:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318312AbSHGQvo>; Wed, 7 Aug 2002 12:51:44 -0400
Received: from mx1.elte.hu ([157.181.1.137]:13012 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S318221AbSHGQvn>;
	Wed, 7 Aug 2002 12:51:43 -0400
Date: Wed, 7 Aug 2002 18:53:44 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Luca Barbieri <ldb@ldb.ods.org>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Linux-Kernel ML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] [2.5 i386] Fix AP GDT descs to have limit = size - 1
In-Reply-To: <1028735671.11775.5.camel@ldb>
Message-ID: <Pine.LNX.4.44.0208071852220.20607-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 7 Aug 2002, Luca Barbieri wrote:

>  		memcpy(cpu_gdt_table[cpu], cpu_gdt_table[0], GDT_SIZE);
> -		cpu_gdt_descr[cpu].size = GDT_SIZE;
> +		cpu_gdt_descr[cpu].size = GDT_SIZE - 1;
>  		cpu_gdt_descr[cpu].address = (unsigned long)cpu_gdt_table[cpu];

indeed, good eyes!

i'm wondering whether this could have caused any problems - since the
limit was not a proper multiple of 8 minus 1, no selector value could have
caused a descriptor to be loaded from the invalid byte.

	Ingo

