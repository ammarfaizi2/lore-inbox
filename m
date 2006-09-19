Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751054AbWISVJi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751054AbWISVJi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Sep 2006 17:09:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751058AbWISVJi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Sep 2006 17:09:38 -0400
Received: from mx1.redhat.com ([66.187.233.31]:32904 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750906AbWISVJh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Sep 2006 17:09:37 -0400
Date: Tue, 19 Sep 2006 17:07:03 -0400
From: "Frank Ch. Eigler" <fche@redhat.com>
To: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
Cc: linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@redhat.com>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>,
       Douglas Niehaus <niehaus@eecs.ku.edu>, Tom Zanussi <zanussi@us.ibm.com>,
       Paul Mundt <lethal@linux-sh.org>, Jes Sorensen <jes@sgi.com>,
       Richard J Moore <richardj_moore@uk.ibm.com>,
       William Cohen <wcohen@redhat.com>,
       "Martin J. Bligh" <mbligh@mbligh.org>,
       Michel Dagenais <michel.dagenais@polymtl.ca>,
       systemtap@sources.redhat.com, ltt-dev@shafik.org
Subject: Re: [PATCH] Linux Kernel Markers 0.2 for Linux 2.6.17
Message-ID: <20060919210703.GD18646@redhat.com>
References: <20060919183447.GA16095@Krystal> <y0m4pv3ek49.fsf@ton.toronto.redhat.com> <20060919193623.GA9459@Krystal> <20060919194515.GB18646@redhat.com> <20060919202802.GB552@Krystal>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="d9ADC0YsG2v16Js0"
Content-Disposition: inline
In-Reply-To: <20060919202802.GB552@Krystal>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--d9ADC0YsG2v16Js0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi -

On Tue, Sep 19, 2006 at 04:28:02PM -0400, Mathieu Desnoyers wrote:

> [...]
> > In order to have what we appear to need, we cannot avoid having some
> > impact.  (Even NOPs have impact.)

> I am all for giving this decision to the end-user or the
> distribution which will configure the kernel. [...]

If the decision you're talking about is whether all markers in the
system should behave one way or another, then this is a degree of
central control that we have not contemplated during the entire
thread, until now.

It is an end-user such as an administrator who will figure out which
probes/markers/tracing elements need what kind of processing attached.
They don't want to recompile the kernel to switch.  They will want
different types of processing, or none at all, for different markers
during a system lifetime.


> * Users debugging servers will more likely want the kprobe or jprobe opti=
on.
> * Users interested in high performance tracing will want fprobe
> and/or jprobe.
> * Users interested in embedded systems will want to avoid tools
> outside the kernel that rely on module loading: their kernel often
> not even support modules. -> fprobe

This line of thinking makes me worry that we've forgotten all that we
learned during the weekend.  Amongst the insights apparently agreed
was that on *any given system*, a mixture of static an dynamic probing
was likely necessary.  For the static part of the instrumentation, a
marker that could be hooked up to either type of probing system was
desirable, which implies some sort of run-time changeability.

(Regarding module loading being considered a blocker for a tool like
systemtap, don't.  We will support pre-compiled boot-time
instrumentation loaded from e.g. initrd or linked right into vmlinux.)


> M. Bligh's idea is an interesting use of fprobes through modules
> that could make dynamic tracing more effective for accessing local
> variables. [...]

That's if it works, if it can be implemented, if it does not create
conflicts between multiple tracing/probing systems, if ... =20

Yes, in theory it might bridge the gulf between compile-time and
run-time configuration, but aren't these all big "if"s right now?


> With or without his idea, the goal of this marker mechanism is to
> meet all those user's different needs.

I don't understand how this new compile-time configured style of
marker is to serve anyone who wants to use something other than a
single distribution-picked tracing/probing tool.  I though we had
abandoned that model some time ago.


- FChE

--d9ADC0YsG2v16Js0
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQFFEFv3VZbdDOm/ZT0RAoQ7AJoDsJ5BuOsi5nXRgqqboQk2JrlpTgCfab0W
OeZ3Q/JmwlurvITo+alKOns=
=Wdnz
-----END PGP SIGNATURE-----

--d9ADC0YsG2v16Js0--
