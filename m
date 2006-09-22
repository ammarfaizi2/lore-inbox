Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932210AbWIVCIg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932210AbWIVCIg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 22:08:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932208AbWIVCIg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 22:08:36 -0400
Received: from gw.goop.org ([64.81.55.164]:2989 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S932207AbWIVCIf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 22:08:35 -0400
Message-ID: <45134539.7070305@goop.org>
Date: Thu, 21 Sep 2006 19:06:49 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Mathieu Desnoyers <compudj@krystal.dyndns.org>
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
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] Linux Kernel Markers 0.7 for 2.6.17 (with type checking!)
References: <20060921232024.GA16155@Krystal> <451331A1.3020601@goop.org> <20060922020119.GA28712@Krystal>
In-Reply-To: <20060922020119.GA28712@Krystal>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mathieu Desnoyers wrote:
> #define MARK_SYM(name) \
>         do { \
>                 __label__ here; \
>                 volatile static void *__mark_kprobe_##name \
>                         asm (MARK_CALL_PREFIX#name) \
>                         __attribute__((unused)) = &&here; \
> here: \
>                 do { } while(0); \
>         } while(0)
>
> Which fixes the problem. Some tests showed me that the compiler does not unroll
> an otherwise unrolled loop when this specific macro is called. (test done with
> -funroll-all-loops).

Eh?  I thought you wanted to avoid changing the generated code?  
Inhibiting loop unrolling could be a pretty large change...

    J
