Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267683AbUHFEWb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267683AbUHFEWb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 00:22:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267684AbUHFEWa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 00:22:30 -0400
Received: from mx1.redhat.com ([66.187.233.31]:18662 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S267683AbUHFEW2 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 00:22:28 -0400
Date: Thu, 5 Aug 2004 21:21:52 -0700
From: "David S. Miller" <davem@redhat.com>
To: yoshfuji@linux-ipv6.org
Cc: jmorris@redhat.com, jlcooke@certainkey.com, mludvig@suse.cz,
       cryptoapi@lists.logix.cz, linux-kernel@vger.kernel.org,
       yoshfuji@linux-ipv6.org
Subject: Re: [PATCH]
Message-Id: <20040805212152.3a4a0d2b.davem@redhat.com>
In-Reply-To: <20040805.203623.60258238.yoshfuji@linux-ipv6.org>
References: <20040805194914.GC23994@certainkey.com>
	<Xine.LNX.4.44.0408052245380.20516-100000@dhcp83-76.boston.redhat.com>
	<20040805.203623.60258238.yoshfuji@linux-ipv6.org>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 05 Aug 2004 20:36:23 -0700 (PDT)
YOSHIFUJI Hideaki / 吉藤英明 <yoshfuji@linux-ipv6.org> wrote:

> In article <Xine.LNX.4.44.0408052245380.20516-100000@dhcp83-76.boston.redhat.com> (at Thu, 5 Aug 2004 22:47:12 -0400 (EDT)), James Morris <jmorris@redhat.com> says:
> 
> > > Would you be against a patch to cryptoapi to have access to a
> > > non-scatter-list set of calls?
> :
> > level.  Can you demonstrate a compelling need for raw access to the
> > algorithms via the API?
> 
> I would use them for
>  - Privacy Extensions (RFC3041) support
>  - upcoming TCP MD5 signature (RFC2385) support
> since I don't see the advantage(s) of sg for allocated memories there.

But here is the problem, it's going to be implemented as a scatter-
gather list on the stack to pass on to the actual crypto layer.

If you just blindly use this new interface, you may not be aware
of this overhead and thus not consider moving to sg-based methods.
This is what I want to avoid.

Yes, it is social engineering. :-)

I see nothing wrong with explicitly coding things out, as we do
now.
