Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275410AbTHIUWd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Aug 2003 16:22:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275411AbTHIUWd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Aug 2003 16:22:33 -0400
Received: from pizda.ninka.net ([216.101.162.242]:425 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S275410AbTHIUWb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Aug 2003 16:22:31 -0400
Date: Sat, 9 Aug 2003 13:17:15 -0700
From: "David S. Miller" <davem@redhat.com>
To: Matt Mackall <mpm@selenic.com>
Cc: linux-kernel@vger.kernel.org, jmorris@intercode.com.au
Subject: Re: [RFC][PATCH] Make cryptoapi non-optional?
Message-Id: <20030809131715.17a5be2e.davem@redhat.com>
In-Reply-To: <20030809194627.GV31810@waste.org>
References: <20030809074459.GQ31810@waste.org>
	<20030809010418.3b01b2eb.davem@redhat.com>
	<20030809140542.GR31810@waste.org>
	<20030809103910.7e02037b.davem@redhat.com>
	<20030809194627.GV31810@waste.org>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 9 Aug 2003 14:46:27 -0500
Matt Mackall <mpm@selenic.com> wrote:

> On Sat, Aug 09, 2003 at 10:39:10AM -0700, David S. Miller wrote:
> > All of this analysis nearly requires a working implementation so
> > someone can do a code-size and performance comparison between
> > the two cases.  I know this is what you're trying to avoid, having
> > to code up what might be just thrown away :(
> 
> Ok, can I export some more cryptoapi primitives?
> 
>   __crypto_lookup_alg(const char *name);
>   __crypto_alg_tfm_size(const char *name);
>   __crypto_setup_tfm(struct crypto_alg *alg, char *buf, int size, int flags);
>   __crypto_exit_ops(...)
>   __crypto_alg_put(...);

No, this eliminates the whole point of all the abstractions.
Please just use the APIs properly.

> This would let me do alg lookup in my init and avoid the dynamic
> allocation sleeping and performance hits.

How about allocating the tfm(s) (one per cpu on SMP) at module
init time?  That's how I would implement this.

Please try to implement something using the existing APIs.

It's not the size of the cryptoapi core that I'm worries about
(that's only like 1K or 2K on 32-bit systems), it's the SHA1/MD*
code which is a bit  larger.  This might all cancel out once the
SHA1/MD* code is deleted from random.o, and your implementation
will prove/disprove this, and then we can move onto perf analysis.

> Also, I posted to cryptoapi-devel that I need a way to disable the
> unconditional padding on the hash functions.

James, comments?
