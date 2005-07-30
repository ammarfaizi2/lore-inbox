Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262864AbVG3BTC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262864AbVG3BTC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 21:19:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262845AbVG3BRT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 21:17:19 -0400
Received: from vivaldi.madbase.net ([81.173.6.10]:35009 "HELO
	vivaldi.madbase.net") by vger.kernel.org with SMTP id S262825AbVG3AxD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 20:53:03 -0400
Date: Fri, 29 Jul 2005 20:53:02 -0400 (EDT)
From: Eric Lammerts <eric@lammerts.org>
X-X-Sender: eric@vivaldi.madbase.net
To: Arjan van de Ven <arjan@infradead.org>
cc: Andrew Morton <akpm@osdl.org>, Dave Jones <davej@redhat.com>,
       davem@davemloft.net, pmarques@grupopie.com,
       linux-kernel@vger.kernel.org
Subject: Re: Slowdown with randomize_va_space in 2.6.12.2
In-Reply-To: <1120718229.3198.8.camel@laptopd505.fenrus.org>
Message-ID: <Pine.LNX.4.58.0507292040530.1819@vivaldi.madbase.net>
References: <42CBE97C.2060208@grupopie.com> <20050706.125719.08321870.davem@davemloft.net>
 <20050706205315.GC27630@redhat.com> <20050706181220.3978d7f6.akpm@osdl.org>
 <1120718229.3198.8.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 7 Jul 2005, Arjan van de Ven wrote:
> On Wed, 2005-07-06 at 18:12 -0700, Andrew Morton wrote:
> > Dave Jones <davej@redhat.com> wrote:
> > > On Transmeta CPUs that probably triggers a retranslation of
> > > x86->native bytecode, if it thinks it hasn't seen code at that
> > > address before.
> >
> > ouch.   What do we do?  Default to off?  Default to off on xmeta?
>
> off-on-xmeta would be my preference; I'll cook up a patch for that.

It would be nice if a fix for this could get in before 2.6.13 comes
out. What about this patch?

cheers,
Eric

--- linux-2.6.13-rc4/arch/i386/kernel/cpu/transmeta.c.orig	2005-06-17 15:48:29.000000000 -0400
+++ linux-2.6.13-rc4/arch/i386/kernel/cpu/transmeta.c	2005-07-29 20:46:54.000000000 -0400
@@ -76,6 +76,10 @@
 #define USER686 (X86_FEATURE_TSC|X86_FEATURE_CX8|X86_FEATURE_CMOV)
         if ( c->x86 == 5 && (c->x86_capability[0] & USER686) == USER686 )
 		c->x86 = 6;
+
+	/* randomize_va_space slows us down enormously;
+	   it probably triggers retranslation of x86->native bytecode */
+	randomize_va_space = 0;
 }

 static void transmeta_identify(struct cpuinfo_x86 * c)
