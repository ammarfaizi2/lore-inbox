Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284318AbRL1XN6>; Fri, 28 Dec 2001 18:13:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284301AbRL1XNt>; Fri, 28 Dec 2001 18:13:49 -0500
Received: from amsfep11-int.chello.nl ([213.46.243.19]:58964 "EHLO
	amsfep11-int.chello.nl") by vger.kernel.org with ESMTP
	id <S284289AbRL1XNi>; Fri, 28 Dec 2001 18:13:38 -0500
Date: Sat, 29 Dec 2001 00:15:11 +0100
From: Jeroen Vreeken <pe1rxq@amsat.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Henk de Groot <henk.de.groot@hetnet.nl>, linux-hams@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: AX25/socket kernel PATCHes
Message-ID: <20011229001511.C278@jeroen.pe1rxq.ampr.org>
In-Reply-To: <5.1.0.14.2.20011228213437.009d1190@pop.hetnet.nl> <E16K68F-00029E-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <E16K68F-00029E-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Sat, Dec 29, 2001 at 00:09:43 +0100
X-Mailer: Balsa 1.1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2001.12.29 00:09:43 +0100 Alan Cox wrote:
> > I just downloaded the latest 2.4.17 kernel and I still do not see the 
> > patches of Jeroen Vreeken, PE1RXQ, applied. Anybody know the reason
> why?
> 
> Because it changes core code in a way that shouldn't be needed
> 
> >    *		Arnaldo C. Melo :       cleanups, use
> skb_queue_purge
> > + *		Jeroen Vreeken	:	Add check for
> sk->dead in sock_def_write_space
> >    *
> >    * To Fix:
> >    *
> > @@ -1146,7 +1147,7 @@
> >   	/* Do not wake up a writer until he can make "significant"
> >   	 * progress.  --DaveM
> >   	 */
> > -	if((atomic_read(&sk->wmem_alloc) << 1) <= sk->sndbuf) {
> > +	if(!sk->dead && (atomic_read(&sk->wmem_alloc) << 1) <=
> sk->sndbuf) {
> >   		if (sk->sleep && waitqueue_active(sk->sleep))
> >   			wake_up_interruptible(sk->sleep);
> 
> Does the fix work without this change ?

The simple fix, no...

However I have started to make a patch for ax25 to use sock_orphan, but
recently we had some trouble with 2.4 kernels that might be related to my
changes or the scc driver, so I am now looking at fixing that, as soon as
that is sorted out I will submit a patch that fixes it the right way.

Jeroen


