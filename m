Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750748AbWEQRYU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750748AbWEQRYU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 May 2006 13:24:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750753AbWEQRYU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 May 2006 13:24:20 -0400
Received: from mx1.redhat.com ([66.187.233.31]:8150 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750748AbWEQRYT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 May 2006 13:24:19 -0400
To: Martin Peschke <mp3@de.ibm.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, ak@suse.de, hch@infradead.org,
       arjan@infradead.org, James.Smart@Emulex.Com,
       James.Bottomley@SteelEye.com, ltt-dev@shafik.org
Subject: Re: [RFC] [Patch 0/8] statistics infrastructure
References: <446A0F77.70202@de.ibm.com>
From: fche@redhat.com (Frank Ch. Eigler)
Date: 17 May 2006 13:23:19 -0400
In-Reply-To: <446A0F77.70202@de.ibm.com>
Message-ID: <y0msln8wooo.fsf@ton.toronto.redhat.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Martin Peschke <mp3@de.ibm.com> writes:

> My patch series is a proposal for a generic implementation of statistics.
> Envisioned exploiters include device drivers, and any other component.
> [...]
> Good places to start reading code are:
>    statistic_create(), statistic_remove()
>    statistic_add(), statistic_inc()
> [...]

It is interesting how many solutions pop up for this sort of problem.
The many tracing tools/patches, systemtap, and now this, all share
some goals and should ideally share some of the technology.

In particular, one of the common points is the designation of points
where significant events take place, and passing their parameters.  In
your case, these are the statitistic_add/inc() calls.  In LTT, these
are macros or inline functions expanding to tracing calls.  In
systemtap, ignoring the slower dynamic kprobes, we now have prototype
support for "markers" are generic statically placed hooks that may be
bound to arbitrary instrumentation code.  (I will be talking more
about this at OLS.)
<http://sourceware.org/ml/systemtap/2006-q1/msg00901.html>

It would be nice if we found a way to agree on one single hooking
mechanism, one that could be accepted here upstream, and used by all
these various projects for their own tracing, probing, or
statistics-collecting backends.

- FChE
