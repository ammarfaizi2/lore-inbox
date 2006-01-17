Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751321AbWAQBd6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751321AbWAQBd6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 20:33:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751322AbWAQBd6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 20:33:58 -0500
Received: from 217-133-42-200.b2b.tiscali.it ([217.133.42.200]:45123 "EHLO
	opteron.random") by vger.kernel.org with ESMTP id S1751321AbWAQBd5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 20:33:57 -0500
Date: Tue, 17 Jan 2006 02:33:47 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: Badari Pulavarty <pbadari@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, hugh@veritas.com, dvhltc@us.ibm.com,
       linux-mm@kvack.org, jdike@addtoit.com
Subject: Re: differences between MADV_FREE and MADV_DONTNEED
Message-ID: <20060117013347.GR15897@opteron.random>
References: <20051029025119.GA14998@ccure.user-mode-linux.org> <43757263.2030401@us.ibm.com> <20060116130649.GE15897@opteron.random> <200601170206.10212.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200601170206.10212.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 17, 2006 at 02:06:09AM +0100, Blaisorblade wrote:
> I.e. it's a restriction of MADV_REMOVE. Is there anything conceivable
> relying on errors or no behaviour on file-backed memory? If relying on
> errors we could need an API, but if relying only on the NO-OP thing the
> correctness semantics are already implemented. I.e. data are retained on both
> Solaris MADV_FREE and Linux MADV_REMOVE for file-backed case, they get a
> different semantics for caching.

Not sure to understand but merging MADV_REMOVE into MADV_FREE apparently
would break freebsd apps that might expect a noop instead. And it could
break Solaris apps if they execpt a -EINVAL (though the latter is more
dubious, but I doubt making differences is worth it and if freebsd makes
it a noop I'd stick with the noop and leave MADV_REMOVE alone).

> are the Solaris ones. Don't know past behaviour about "breaking existing to 
> comply to standards" (new syscall slot?).

The change I suggested would be backwards compatible because it can only
affect performance.

The only thing that can break right now, is running a non-linux (and
apparently posix too) app on a linux system that will corrupt memory
with potential data loss.

> Provide our fine-grained semantics with new, not misunderstandable identifiers 
> (MADV_FREE_DISCARD, MADV_FREE_CACHE, for instance).

Why should we deviate for the sake of porting pain, when we can comply
at no tangible risk for us?

> Making their apps work by causing the same breakage to Linux apps is a better 
> idea?

Again: if an app breaks it means it's working by pure luck because it's
depending on fragile timings in the first place.

Call it a potential lower performance or less efficient memory
utilization, a breakage not.

If we were to make MADV_DONTNEED more aggressive, then we'd be risking a
breakage, but we're going to relax it instead.
