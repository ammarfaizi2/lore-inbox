Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263274AbTDGGKQ (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 02:10:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263273AbTDGGKQ (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 02:10:16 -0400
Received: from phoenix.mvhi.com ([195.224.96.167]:35337 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S263274AbTDGGKO (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 7 Apr 2003 02:10:14 -0400
Date: Mon, 7 Apr 2003 07:21:44 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Paul Mackerras <paulus@au1.ibm.com>
Cc: Rusty Russell <rusty@rustcorp.com.au>,
       Fabrice Bellard <fabrice.bellard@free.fr>, linux-kernel@vger.kernel.org,
       Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: [PATCH] Qemu support for PPC
Message-ID: <20030407072144.A28096@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Paul Mackerras <paulus@au1.ibm.com>,
	Rusty Russell <rusty@rustcorp.com.au>,
	Fabrice Bellard <fabrice.bellard@free.fr>,
	linux-kernel@vger.kernel.org,
	Marcelo Tosatti <marcelo@conectiva.com.br>
References: <20030407024858.C32422C014@lists.samba.org> <20030407065813.A27933@infradead.org> <16017.2065.635724.992168@argo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <16017.2065.635724.992168@argo.ozlabs.ibm.com>; from paulus@au1.ibm.com on Mon, Apr 07, 2003 at 03:09:37PM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 07, 2003 at 03:09:37PM +1000, Paul Mackerras wrote:
> sys_personality will fail if there isn't an exec_domain registered for
> the personality you want.

But there already is one registered :)  Okay, you\re right.

> Why?  It's a well-contained patch that affects very little outside its
> own area, and is quite similar to other things that have been there
> for ages.

Because stuff should go into 2.5 first.    And even if it looks trivial
there's an important policy decision here:  do we want to clutter up
our personality system for userspace emulators?   If you look at the
current list of personalities they all have kernel implementations, even
if not all of them are currently merged, qemu OTOH is a purely userspace
thing (and still very new!).  Personally I'd rather prefer qemu doing
pathname translation in userspace instead of bloating the kernel.  This
gets even more important when we get qemu-style emulators for other
architectures - the number of personalities needed just for this ugly
pathname-translation scheme will get very high.

> Anyway, it's not your call.

if you look at MAINTAINERS I'm responsible for personality handling, so
maybe it actually _is_ my call?
