Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751161AbWIYRsa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751161AbWIYRsa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 13:48:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751393AbWIYRsa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 13:48:30 -0400
Received: from mx1.redhat.com ([66.187.233.31]:59341 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751161AbWIYRs3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 13:48:29 -0400
Date: Mon, 25 Sep 2006 13:45:25 -0400
From: "Frank Ch. Eigler" <fche@redhat.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: "Frank Ch. Eigler" <fche@redhat.com>,
       Mathieu Desnoyers <compudj@krystal.dyndns.org>,
       Martin Bligh <mbligh@google.com>,
       Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, prasanna@in.ibm.com,
       Andrew Morton <akpm@osdl.org>,
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
Subject: Re: [PATCH] Linux Kernel Markers 0.5 for Linux 2.6.17 (with probe management)
Message-ID: <20060925174525.GF25296@redhat.com>
References: <20060921160009.GA30115@Krystal> <20060921175648.GB22226@redhat.com> <20060921185029.GB12048@elte.hu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="kA1LkgxZ0NN7Mz3A"
Content-Disposition: inline
In-Reply-To: <20060921185029.GB12048@elte.hu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--kA1LkgxZ0NN7Mz3A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi -

On Thu, Sep 21, 2006 at 08:50:29PM +0200, Ingo Molnar wrote:

> [...]  let me qualify that: parameters must be prepared there too -
> but no actual function call inserted. (at most a NOP
> inserted). [...]  Does a simple asm() that takes read-only
> parameters but only adds a NOP achieve this result?

You mean something like this?

#define MARK(n,v1,v2,v3) asm ("__mark_" #n ": nop" ::  \
                              "X" (v1), "X" (v2), "X" (v3))

I haven't been able to get gcc to emit any better debuginfo for
parameters pseudo-passed like this.=20

(I've tested such a marker inserted into an inner loop of dhrystone.
It was compiled with "-ggdb -O3".  Neither gdb nor systemtap could
resolve the same values/symbols being passed as MARK() arguments,
though at least the breakpoint address was nicely marked.)

- FChE

--kA1LkgxZ0NN7Mz3A
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQFFGBW1VZbdDOm/ZT0RArIGAJ0Us3G4aBh/3d05EIjzZvpHqK57GgCfaLrv
w8I7yrCv1SCCg8QnwBYCQsA=
=xMiZ
-----END PGP SIGNATURE-----

--kA1LkgxZ0NN7Mz3A--
