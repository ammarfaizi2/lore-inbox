Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283697AbRLDOo3>; Tue, 4 Dec 2001 09:44:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283667AbRLDOnA>; Tue, 4 Dec 2001 09:43:00 -0500
Received: from ns.suse.de ([213.95.15.193]:4357 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S284362AbRLDOZU> convert rfc822-to-8bit;
	Tue, 4 Dec 2001 09:25:20 -0500
To: Arjan van de Ven <arjanv@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-ia64@linuxia64.org,
        marcelo@conectiva.com.br, davem@redhat.com
Subject: Re: [Linux-ia64] patch to no longer use ia64's software mmu
In-Reply-To: <20011203160059.A2022@devserv.devel.redhat.com>
X-Yow: The FALAFEL SANDWICH lands on my HEAD and I become a VEGETARIAN...
From: Andreas Schwab <schwab@suse.de>
Date: 04 Dec 2001 15:25:15 +0100
In-Reply-To: <20011203160059.A2022@devserv.devel.redhat.com> (Arjan van de Ven's message of "Mon, 3 Dec 2001 16:00:59 -0500")
Message-ID: <je4rn7njuc.fsf@sykes.suse.de>
User-Agent: Gnus/5.090003 (Oort Gnus v0.03) Emacs/21.1.30
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven <arjanv@redhat.com> writes:

|> Hi,
|> 
|> The patch below (against 2.4.16) makes the ia64 port no longer use the (VERY
|> slow) software IO mmu but makes it use the same mechanism the x86 PAE port
|> uses: it lets the higher layers take care of the proper bouncing of
|> PCI-unreachable memory. The implemenation is pretty simple; instead of
|> having a 4Gb GFP_DMA zone and a <rest of ram> GFP_KERNEL zone, the ia64 port
|> now has a 4Gb GFP_DMA zone and a <rest of ram> GFP_HIGH zone.
|> Since the ia64 cpu can address all of this memory directly, the kmap() and
|> related functions are basically nops. 

I tried it, but it doesn't compile: kmap_prot and kmap_pte are undefined.
If they are not used on ia64, then the reference in kernel/ksyms.c must be
removed.

Andreas.

-- 
Andreas Schwab                                  "And now for something
Andreas.Schwab@suse.de				completely different."
SuSE Labs, SuSE GmbH, Schanzäckerstr. 10, D-90443 Nürnberg
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
