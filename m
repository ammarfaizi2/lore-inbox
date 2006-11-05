Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932604AbWKEX4L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932604AbWKEX4L (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Nov 2006 18:56:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932754AbWKEX4L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Nov 2006 18:56:11 -0500
Received: from mx1.suse.de ([195.135.220.2]:40904 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932604AbWKEX4J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Nov 2006 18:56:09 -0500
From: Neil Brown <neilb@suse.de>
To: Willy Tarreau <w@1wt.eu>
Date: Mon, 6 Nov 2006 10:55:44 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17742.31232.907908.330955@cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 30/61] knfsd: Fix race that can disable NFS server.
In-Reply-To: message from Willy Tarreau on Saturday November 4
References: <20061101053340.305569000@sous-sol.org>
	<20061101054028.568862000@sous-sol.org>
	<20061101071111.GB543@1wt.eu>
	<20061104210641.GA4778@1wt.eu>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday November 4, w@1wt.eu wrote:
> Hi Neil, 
> 
> I don't know if you noticed my request for ACK as I did not get any
> response. I think that your patch here is a good candidate for 2.4
> too, I would just like to get your confirmation before merging it.

Sorry, I went to grab a copy of the latest 2.4 to double-check and the
got distracted.

Yes: this patch is definitely appropriate for 2.4.

Thanks,
NeilBrown

> > ---
> >  net/sunrpc/svcsock.c |    2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > --- linux-2.6.18.1.orig/net/sunrpc/svcsock.c
> > +++ linux-2.6.18.1/net/sunrpc/svcsock.c
> > @@ -902,7 +902,7 @@ svc_tcp_recvfrom(struct svc_rqst *rqstp)
> >  		return 0;
> >  	}
> >  
> > -	if (test_bit(SK_CONN, &svsk->sk_flags)) {
> > +	if (svsk->sk_sk->sk_state == TCP_LISTEN) {
> >  		svc_tcp_accept(svsk);
> >  		svc_sock_received(svsk);
> >  		return 0;
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
