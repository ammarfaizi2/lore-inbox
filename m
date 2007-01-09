Return-Path: <linux-kernel-owner+w=401wt.eu-S932546AbXAIXpY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932546AbXAIXpY (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 18:45:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932548AbXAIXpY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 18:45:24 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:55843 "EHLO amd.ucw.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932546AbXAIXpW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 18:45:22 -0500
Date: Wed, 10 Jan 2007 00:45:11 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@redhat.com>, Greg Kroah-Hartman <gregkh@suse.de>,
       Christoph Hellwig <hch@infradead.org>, ltt-dev@shafik.org,
       systemtap@sources.redhat.com, Douglas Niehaus <niehaus@eecs.ku.edu>,
       "Martin J. Bligh" <mbligh@mbligh.org>,
       Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] local_t : Documentation - update
Message-ID: <20070109234511.GB7798@elf.ucw.cz>
References: <20061221001545.GP28643@Krystal> <20061223093358.GF3960@ucw.cz> <20070109031446.GA29426@Krystal> <20070109224100.GB6555@elf.ucw.cz> <20070109232155.GA25387@Krystal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070109232155.GA25387@Krystal>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > AFAICT this fails to mention... Is local_t as big as int? As big as
> > long? Or perhaps smaller because high bits may be needed for locking?
> 
> Hi Pavel,
> 
> Here is an update that adds the information you mentionned in this reply and the
> one to Andrew. Thanks for the comments.
> 
> Mathieu
> 
> 
> index dfeec94..bd854b3 100644
> --- a/Documentation/local_ops.txt
> +++ b/Documentation/local_ops.txt
> @@ -22,6 +22,13 @@ require disabling interrupts to protect from interrupt handlers and it permits
>  coherent counters in NMI handlers. It is especially useful for tracing purposes
>  and for various performance monitoring counters.
>  
> +Local atomic operations only guarantee variable modification atomicity wrt the
> +CPU which owns the data. Therefore, care must taken to make sure that only one
> +CPU writes to the local_t data. This is done by using per cpu data and making
> +sure that we modify it from within a preemption safe context. It is however
> +permitted to read local_t data from any CPU : it will then appear to be written
> +out of order wrt other memory writes on the owner CPU.

So it is "one cpu may write, other cpus may read", and as big as
long. Are you sure obscure architectures (sparc?) can implement this
in useful way? ... maybe yes, unless obscure architecture exists where
second other cpu can see garbage data when first cpu writes into long
...?


								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
