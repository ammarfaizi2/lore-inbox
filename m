Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267273AbTAGAWE>; Mon, 6 Jan 2003 19:22:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267274AbTAGAWE>; Mon, 6 Jan 2003 19:22:04 -0500
Received: from smtpzilla5.xs4all.nl ([194.109.127.141]:1041 "EHLO
	smtpzilla5.xs4all.nl") by vger.kernel.org with ESMTP
	id <S267273AbTAGAWC>; Mon, 6 Jan 2003 19:22:02 -0500
Message-ID: <3E1A1B54.A52307D2@linux-m68k.org>
Date: Tue, 07 Jan 2003 01:12:04 +0100
From: Roman Zippel <zippel@linux-m68k.org>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Randy.Dunlap" <rddunlap@osdl.org>
CC: Linus Torvalds <torvalds@transmeta.com>,
       Tom Rini <trini@kernel.crashing.org>, linux-kernel@vger.kernel.org,
       Sam Ravnborg <sam@ravnborg.org>, szepe@pinerecords.com
Subject: Re: [PATCH] configurable LOG_BUF_SIZE
References: <Pine.LNX.4.33L2.0301061257160.15416-100000@dragon.pdx.osdl.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

"Randy.Dunlap" wrote:

> +config LOG_BUF_SHIFT
> +       int "Kernel log buffer size"
> +       depends on DEBUG_KERNEL

Just change this into:

	int "Kernel log buffer size" if DEBUG_KERNEL

> +       default 17 if ARCH_S390
> +       default 16 if X86_NUMAQ || IA64
> +       default 15 if SMP
> +       default 14
> +       help
> +         Select kernel log buffer size as a power of 2.
> +         Defaults and Examples:
> +                    17 (=> 128 KB for S/390)
> +                    16 (=> 64 KB for x86 NUMAQ or IA-64)
> +                    15 (=> 32 KB for SMP)
> +                    14 (=> 16 KB for uniprocessor)
> +                    13 (=>  8 KB)
> +                    12 (=>  4 KB)

and you don't need this:

> +config LOG_BUF_SHIFT
> +       int
> +       depends on !DEBUG_KERNEL
> +       default 17 if ARCH_S390
> +       default 16 if X86_NUMAQ || IA64
> +       default 15 if SMP
> +       default 14

bye, Roman
