Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288969AbSAZAxY>; Fri, 25 Jan 2002 19:53:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288971AbSAZAxP>; Fri, 25 Jan 2002 19:53:15 -0500
Received: from smtp-out-2.wanadoo.fr ([193.252.19.254]:64951 "EHLO
	mel-rto2.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S288969AbSAZAxB>; Fri, 25 Jan 2002 19:53:01 -0500
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Val Henson <val@nmt.edu>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: Athlon/AGP issue update
Date: Sat, 26 Jan 2002 01:20:45 +0100
Message-Id: <20020126002045.17802@smtp.wanadoo.fr>
In-Reply-To: <20020125113443.C26874@boardwalk>
In-Reply-To: <20020125113443.C26874@boardwalk>
X-Mailer: CTM PowerMail 3.1.1 <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>On Wed, Jan 23, 2002 at 04:47:37PM +0100, benh@kernel.crashing.org wrote:
>> >I don't think your PPC case needs the kernel mappings messed with.
>> >I really doubt the PPC will speculatively fetch/store to a TLB
>> >missing address.... unless you guys have large TLB mappings on
>> >PPC too?
>> 
>> Yes, we use BATs (sort of built-in fixed large TLBs) to map
>> the lowmem (or entire RAM without CONFIG_HIGHMEM).
>
>Looking at bat_mapin_ram, it looks like we only map the first 512MB of
>RAM with BATs, so we actually map the 512MB - 768MB range with PTEs
>(and highmem starts at 768MB).  Two of the DBATs are used by I/O
>mappings, so that only leaves two DBATs of 256MB each to map lowmem
>anyway.  Am I missing something?

No, except maybe my last patch that actually limits lowmem to 512Mb ;)

I don't think we use the io mapping BATs any more, do we ? (well,
maybe on PReP...) I don't on pmac.

>By the way, does the "nobats" option currently work on PowerMac?

No, nor on any other BAT-capable PPC (and that's the reason why I
did the above). Basically, our exception return path and some of
the hash manipulation functions aren't safe without BAT mapping,
especially on SMP when you can get evicted from the hash table
by the other CPU in places where taking hash faults isn't safe.

Ben.



