Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751447AbWGaEQr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751447AbWGaEQr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 00:16:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751445AbWGaEQq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 00:16:46 -0400
Received: from ns.suse.de ([195.135.220.2]:23993 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751447AbWGaEQp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 00:16:45 -0400
From: Neil Brown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Mon, 31 Jul 2006 14:16:38 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17613.33830.510025.59046@cse.unsw.edu.au>
Cc: nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 007 of 11] knfsd: add svc_get
In-Reply-To: message from Andrew Morton on Sunday July 30
References: <20060731103458.29040.patches@notabene>
	<1060731004219.29255@suse.de>
	<20060730210507.12e33f56.akpm@osdl.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday July 30, akpm@osdl.org wrote:
> On Mon, 31 Jul 2006 10:42:19 +1000
> NeilBrown <neilb@suse.de> wrote:
> 
> >  /*
> > + * We use sv_nrthreads as a reference count.  svc_destroy() drops
> > + * this refcount, so we need to bump it up around operations that
> > + * change the number of threads.  Horrible, but there it is.
> > + * Should be called with the BKL held.
> > + */
> > +static inline void svc_get(struct svc_serv *serv)
> > +{
> > +	serv->sv_nrthreads++;
> > +}
> 
> It's a bit odd for a numa-scalability patch to be increasing our dependency
> upon lock_kernel()...

It just looks odd.
This patch doesn't change generated code - it just puts a
post-increment into an inline function so that it can be documented
and well understood.

We don't change the number of threads very often (mainly at bootup and
shutdown) so having that under the BKL isn't a big cost.

NeilBrown
