Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932145AbWIVAnO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932145AbWIVAnO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 20:43:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932146AbWIVAnO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 20:43:14 -0400
Received: from gw.goop.org ([64.81.55.164]:31146 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S932145AbWIVAnN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 20:43:13 -0400
Message-ID: <451331A1.3020601@goop.org>
Date: Thu, 21 Sep 2006 17:43:13 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Mathieu Desnoyers <compudj@krystal.dyndns.org>
CC: Martin Bligh <mbligh@google.com>, "Frank Ch. Eigler" <fche@redhat.com>,
       Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, prasanna@in.ibm.com,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
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
References: <20060921232024.GA16155@Krystal>
In-Reply-To: <20060921232024.GA16155@Krystal>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mathieu Desnoyers wrote:
> +#ifdef CONFIG_MARK_SYMBOL
> +#define MARK_SYM(name) \
> +	do { \
> +		__label__ here; \
> +		here: asm volatile \
> +			(MARK_KPROBE_PREFIX#name " = %0" : : "m" (*&&here)); \
> +	} while(0)
> +#else 
> +#define MARK_SYM(name)
> +#endif

BTW, this won't work if you put the MARK_SYM in a loop which gcc 
unrolls; you'll only get the mark in the last unrolled iteration 
(because the symbol assignments will override each other).

Do make this work properly, you really need to put the mark entries into 
a separate section, so that if gcc duplicates the code, you get 
duplicated markers too.

    J
