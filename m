Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311279AbSCLR0a>; Tue, 12 Mar 2002 12:26:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311291AbSCLR0U>; Tue, 12 Mar 2002 12:26:20 -0500
Received: from mons.uio.no ([129.240.130.14]:28355 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S311279AbSCLRZ7>;
	Tue, 12 Mar 2002 12:25:59 -0500
To: Gerd Knorr <kraxel@bytesex.org>
Cc: linux-kernel@vger.kernel.org, Marcelo Tosatti <marcelo@conectiva.com.br>,
        Dave Jones <davej@suse.de>
Subject: Re: Linux 2.4.19-pre3
In-Reply-To: <Pine.LNX.4.21.0203111805480.2492-100000@freak.distro.conectiva>
	<slrna8rmfn.46r.kraxel@bytesex.org>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 12 Mar 2002 18:24:48 +0100
In-Reply-To: <slrna8rmfn.46r.kraxel@bytesex.org>
Message-ID: <shsy9gxhf6n.fsf@charged.uio.no>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Cuyahoga Valley)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Gerd Knorr <kraxel@bytesex.org> writes:

    >> Here goes -pre3, with the new IDE code. It has been stable
    >> enough time in the -ac tree, in my and Alan's opinion.

     > Doesn't boot my machine.  "Intel machine check architecture
     > supported" is the last message printed before it just hangs.

Ditto on my laptop. I've tracked it down to a change in the file
arch/i386/kernel/bluesmoke.c between pre2 and pre3. My guess is that

- Fix off-by-one error in bluesmoke                     (Dave Jones)

is wrong for some reason. Backing out that change using the appended
patch causes pre3 to boot normally.

Cheers,
  Trond

--- linux-2.4.19-up/arch/i386/kernel/bluesmoke.c.orig	Tue Mar 12 14:56:56 2002
+++ linux-2.4.19-up/arch/i386/kernel/bluesmoke.c	Tue Mar 12 18:07:44 2002
@@ -169,7 +169,7 @@
 	if(l&(1<<8))
 		wrmsr(MSR_IA32_MCG_CTL, 0xffffffff, 0xffffffff);
 	banks = l&0xff;
-	for(i=0;i<banks;i++)
+	for(i=1;i<banks;i++)
 	{
 		wrmsr(MSR_IA32_MC0_CTL+4*i, 0xffffffff, 0xffffffff);
 	}

