Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262308AbVHAFXU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262308AbVHAFXU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 01:23:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262298AbVHAFXU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 01:23:20 -0400
Received: from smtp.osdl.org ([65.172.181.4]:56492 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262308AbVHAFWh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 01:22:37 -0400
Date: Sun, 31 Jul 2005 22:21:25 -0700
From: Andrew Morton <akpm@osdl.org>
To: "David S. Miller" <davem@davemloft.net>
Cc: linux-kernel@vger.kernel.org, laforge@gnumonks.org
Subject: Re: git-net-fixup.patch added to -mm tree
Message-Id: <20050731222125.37ab12e8.akpm@osdl.org>
In-Reply-To: <20050731.221246.68159198.davem@davemloft.net>
References: <200508010504.j7154m5B022440@shell0.pdx.osdl.net>
	<20050731.221246.68159198.davem@davemloft.net>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" <davem@davemloft.net> wrote:
>
> From: akpm@osdl.org
> Date: Sun, 31 Jul 2005 22:03:47 -0700
> 
> > From: Andrew Morton <akpm@osdl.org>
> > 
> > Signed-off-by: Andrew Morton <akpm@osdl.org>
>  ...
> >  /* decrement reference count on a conntrack */
> > -extern void ip_conntrack_put(struct ip_conntrack *ct);
> > +static inline void
> > +ip_conntrack_put(struct ip_conntrack *ct)
> > +{
> > +	IP_NF_ASSERT(ct);
> > +	nf_conntrack_put(&ct->ct_general);
> > +}
> 
> You can instead just kill the EXPORT_SYMBOL_GPL() in
> ip_conntrack_standalone.c as that's the only reference outside of
> ip_conntrack_core.c
> 
> Harald?

Actually, that patch is just a fixup for a patch reject from the net-2.6.14
diff.  I do that sometimes when I get sick of fixing up the same reject
each time I pull the various trees.

(I'm not sure _why_ I'm getting a reject applying that diff.  Nothing else
touches that file.  git is not quite yet generating the linus->davem diff
which I want..)
