Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129408AbQLPIhM>; Sat, 16 Dec 2000 03:37:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129485AbQLPIhE>; Sat, 16 Dec 2000 03:37:04 -0500
Received: from cx518206-b.irvn1.occa.home.com ([24.21.107.123]:59145 "EHLO
	pobox.com") by vger.kernel.org with ESMTP id <S129408AbQLPIgx>;
	Sat, 16 Dec 2000 03:36:53 -0500
From: "Barry K. Nathan" <barryn@pobox.com>
Message-Id: <200012160806.AAA32686@pobox.com>
Subject: Re: test13pre2 - netfilter modiles compile failure
To: torvalds@transmeta.com (Linus Torvalds)
Date: Sat, 16 Dec 2000 00:06:34 -0800 (PST)
Cc: linux-kernel@vger.kernel.org
Reply-To: barryn@pobox.com
In-Reply-To: <91f1ru$4e3$1@penguin.transmeta.com> from "Linus Torvalds" at Dec 15, 2000 10:25:02 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> In article <200012160552.VAA27106@pobox.com>,
> Barry K. Nathan <barryn@pobox.com> wrote:
> >I got the same error with the ipchains-compatible netfilter compiled as
> >modules. Compiling into the kernel instead, I also get an error. I've
> >included the error and my .config below.
> 
> Try removing "$(ip_conntrack-objs) $(iptable_nat-objs)" from the
> ip_nf_compat-objs line in net/ipv4/netfilter/Makefile..

Ok, I tried that, and I tried Andrew Morton's patch as well. Both patches
fix the module case, but not the in-kernel case. With Linus' patch, the
in-kernel case fails with the error message in my previous mail. With
Andrew's patch, it fails like this:

ld -m elf_i386  -r -o netfilter.o ipchains.o ip_nf_compat.o
ld: cannot open ip_nf_compat.o: No such file or directory
make[3]: *** [netfilter.o] Error 1
make[3]: Leaving directory
`/home/barryn/lsoft/kernels/buildspace/linux-2.4.0test13pre2bkn-alt-ath/net/ipv4/netfilter'
make[2]: *** [first_rule] Error 2
make[2]: Leaving directory
`/home/barryn/lsoft/kernels/buildspace/linux-2.4.0test13pre2bkn-alt-ath/net/ipv4/netfilter'
make[1]: *** [_subdir_ipv4/netfilter] Error 2
make[1]: Leaving directory
`/home/barryn/lsoft/kernels/buildspace/linux-2.4.0test13pre2bkn-alt-ath/net'
make: *** [_dir_net] Error 2

The only difference in my .config, between the working module case and the
failing in-kernel case, is whether CONFIG_IP_NF_COMPAT_IPCHAINS is set to
y or m. I included one of the .configs (although I forget which one) in my
previous email.

-Barry K. Nathan <barryn@pobox.com>
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
