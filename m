Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751499AbWIWThF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751499AbWIWThF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Sep 2006 15:37:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751500AbWIWThF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Sep 2006 15:37:05 -0400
Received: from opersys.com ([64.40.108.71]:37636 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S1751499AbWIWThC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Sep 2006 15:37:02 -0400
Message-ID: <451591AC.9030703@opersys.com>
Date: Sat, 23 Sep 2006 15:57:32 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.6) Gecko/20060804 Fedora/1.0.4-0.5.1.fc5 SeaMonkey/1.0.4
MIME-Version: 1.0
To: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
CC: Martin Bligh <mbligh@google.com>, "Frank Ch. Eigler" <fche@redhat.com>,
       Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, prasanna@in.ibm.com,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Paul Mundt <lethal@linux-sh.org>,
       linux-kernel <linux-kernel@vger.kernel.org>, Jes Sorensen <jes@sgi.com>,
       Tom Zanussi <zanussi@us.ibm.com>,
       Richard J Moore <richardj_moore@uk.ibm.com>,
       Michel Dagenais <michel.dagenais@polymtl.ca>,
       Christoph Hellwig <hch@infradead.org>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, William Cohen <wcohen@redhat.com>,
       ltt-dev@shafik.org, systemtap@sources.redhat.com,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCH] Linux Kernel Markers 0.8 for 2.6.17 (with near jump for
 i386)
References: <20060922214239.GA28625@Krystal>
In-Reply-To: <20060922214239.GA28625@Krystal>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Mathieu Desnoyers wrote:
> --- a/arch/i386/Kconfig
> +++ b/arch/i386/Kconfig
> @@ -1082,6 +1082,8 @@ config KPROBES
>  	  for kernel debugging, non-intrusive instrumentation and testing.
>  	  If in doubt, say "N".
>  
> +source "kernel/Kconfig.marker"
> +
>  source "ltt/Kconfig"

diffing against an LTT tree ...

> --- /dev/null
> +++ b/include/asm-alpha/marker.h
...
> --- /dev/null
> +++ b/include/asm-arm/marker.h
...
> --- /dev/null
> +++ b/include/asm-arm26/marker.h
...
...

Not sure about the need for asm-foo/marker.h if the file contains no
code at all. If there's going to be one marker.h per arch, it might
as well have a purpose. So instead of:

> --- /dev/null
> +++ b/include/asm-i386/marker.h
...
> +#define ARCH_HAS_MARK_NEAR_JUMP

and

> --- /dev/null
> +++ b/include/linux/marker.h
...
> +#ifndef ARCH_HAS_MARK_NEAR_JUMP
...

Why not just have asm-foo/marker.h either implement the optimization
or point to an asm-generic/marker.h which contains the non-optimized
code. No #ifndefs needed.

> --- /dev/null
> +++ b/kernel/Kconfig.marker
...
> +config MARK_SYMBOL
...
> +config MARK_JUMP_CALL
...
> +config MARK_JUMP
...

My understanding of Ingo's input is that he'd rather not have this
multiple options. Either the markers are active or they aren't.
So ...
MARK_ACTIVE ... speaks for itself, enables both the markers and
the set/disable infrastructure. Markers are enabled in their
optimized per-architecture implementation.

MARK_FORCE_DIRECT_CALL ... forces all markers to be non-optimized
(good for embedded systems where the image is in rom/flash and
can therefore not have runtime binary modifications.) Maybe this
should depend on CONFIG_EMBEDDED.

Karim
-- 
President  / Opersys Inc.
Embedded Linux Training and Expertise
www.opersys.com  /  1.866.677.4546
