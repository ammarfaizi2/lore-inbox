Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284588AbRLET2Q>; Wed, 5 Dec 2001 14:28:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284586AbRLET2G>; Wed, 5 Dec 2001 14:28:06 -0500
Received: from mail022.mail.bellsouth.net ([205.152.58.62]:51763 "EHLO
	imf22bis.bellsouth.net") by vger.kernel.org with ESMTP
	id <S284598AbRLET1y>; Wed, 5 Dec 2001 14:27:54 -0500
Message-ID: <3C0E7534.3EC4B202@mandrakesoft.com>
Date: Wed, 05 Dec 2001 14:27:48 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.16 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Paul Larson <plars@austin.ibm.com>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: compile fails on 2.4.17-pre3
In-Reply-To: <1007558606.14970.11.camel@plars.austin.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Larson wrote:
> 
> Is everybody seeing this and it's obvious, or do I need to send my
> .config?
> 
> ld -m elf_i386  -r -o ipv4.o utils.o route.o inetpeer.o proc.o
> protocol.o ip_input.o ip_fragment.o ip_forward.o ip_options.o
> ip_output.o ip_sockglue.o tcp.o tcp_input.o tcp_output.o tcp_timer.o
> tcp_ipv4.o tcp_minisocks.o tcp_diag.o raw.o udp.o arp.o icmp.o devinet.o
> af_inet.o igmp.o sysctl_net_ipv4.o fib_frontend.o fib_semantics.o
> fib_hash.o
> ld: cannot open tcp_diag.o: No such file or directory
> make[3]: *** [ipv4.o] Error 1
> make[3]: Leaving directory `/usr/src/linux/net/ipv4'
> make[2]: *** [first_rule] Error 2
> make[2]: Leaving directory `/usr/src/linux/net/ipv4'
> make[1]: *** [_subdir_ipv4] Error 2
> make[1]: Leaving directory `/usr/src/linux/net'
> make: *** [_dir_net] Error 2

fix:

1) remove "tcp_diag.o" from net/ipv4/Makefile
2) remove two lines from net/ipv4/tcp.c which reference tcpdiag_init

The file is in vger so I assume it's easily fixed by adding that file as
well.  http://vger.kernel.org/

	Jeff

-- 
Jeff Garzik      | Only so many songs can be sung
Building 1024    | with two lips, two lungs, and one tongue.
MandrakeSoft     |         - nomeansno

