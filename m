Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267149AbTAFVR4>; Mon, 6 Jan 2003 16:17:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267146AbTAFVRz>; Mon, 6 Jan 2003 16:17:55 -0500
Received: from louise.pinerecords.com ([213.168.176.16]:8912 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S267149AbTAFVRw>; Mon, 6 Jan 2003 16:17:52 -0500
Date: Mon, 6 Jan 2003 22:26:08 +0100
From: Tomas Szepe <szepe@pinerecords.com>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Tom Rini <trini@kernel.crashing.org>, linux-kernel@vger.kernel.org,
       zippel@linux-m68k.org, Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH] configurable LOG_BUF_SIZE
Message-ID: <20030106212608.GQ5984@louise.pinerecords.com>
References: <Pine.LNX.4.33L2.0301061119400.15416-100000@dragon.pdx.osdl.net> <Pine.LNX.4.33L2.0301061257160.15416-100000@dragon.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33L2.0301061257160.15416-100000@dragon.pdx.osdl.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> [rddunlap@osdl.org]

> | |---------------------------------------------------------------------------
> | | I'd probably be happier if the current one didn't even _ask_ the user (or|
> | | only asked the user if kernel debugging is enabled), and just silently   |
> | | defaulted to the normal values.                                          |
> | |---------------------------------------------------------------------------
> 
> Hm.  Roman, Tomas, Sam-
> 
> Do any of you know how to write a kconfig item like Linus described
> above (in the box)?
> 
> It's simple enough to have a config option that isn't available if
> DEBUG_KERNEL is false, but how do I make default values for it
> when it's false?
> The config option must still exist in this case, but not be presented
> to the user as a choice.
>
> [snip]
>
> +config LOG_BUF_SHIFT
> +	int "Kernel log buffer size"
> +	depends on DEBUG_KERNEL
> +	default 17 if ARCH_S390
> +	default 16 if X86_NUMAQ || IA64
> +	default 15 if SMP
> +	default 14
> +	help
> +	  Select kernel log buffer size as a power of 2.
> +	  Defaults and Examples:
> +	  	     17 (=> 128 KB for S/390)
> +		     16 (=> 64 KB for x86 NUMAQ or IA-64)
> +	             15 (=> 32 KB for SMP)
> +	             14 (=> 16 KB for uniprocessor)
> +		     13 (=>  8 KB)
> +		     12 (=>  4 KB)
> +
> +config LOG_BUF_SHIFT
> +	int
> +	depends on !DEBUG_KERNEL
> +	default 17 if ARCH_S390
> +	default 16 if X86_NUMAQ || IA64
> +	default 15 if SMP
> +	default 14
> +

Randy,

this looks correct to me.  Maybe using if/endif instead of the two
'depends on' would make the entry more explicit to the eye of a future
beholder.

-- 
Tomas Szepe <szepe@pinerecords.com>
