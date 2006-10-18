Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161313AbWJRT0f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161313AbWJRT0f (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 15:26:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161310AbWJRT0f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 15:26:35 -0400
Received: from pat.uio.no ([129.240.10.4]:62635 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S1161313AbWJRT0e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 15:26:34 -0400
Subject: Re: NFS inconsistent behaviour
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Frank van Maarseveen <frankvm@frankvm.com>
Cc: Mohit Katiyar <katiyar.mohit@gmail.com>, linux-kernel@vger.kernel.org,
       Linux NFS mailing list <nfs@lists.sourceforge.net>
In-Reply-To: <20061018183807.GA12018@janus>
References: <A93BD15112CD05479B1CD204F7F1D4730513DB@exch-04.noida.hcltech.com>
	 <46465bb30610160013v47524589g39c61465b5955f65@mail.gmail.com>
	 <20061016084656.GA13292@janus>
	 <46465bb30610160235m211910b6g2eb074aa23060aa9@mail.gmail.com>
	 <20061016093904.GA13866@janus>
	 <46465bb30610171822h3f747069ge9a170f1759af645@mail.gmail.com>
	 <20061018063945.GA5917@janus> <1161194229.6095.81.camel@lade.trondhjem.org>
	 <20061018183807.GA12018@janus>
Content-Type: text/plain
Date: Wed, 18 Oct 2006 15:26:20 -0400
Message-Id: <1161199580.6095.112.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.687, required 12,
	autolearn=disabled, AWL 1.31, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-10-18 at 20:38 +0200, Frank van Maarseveen wrote:
> I ran out of privileged ports due to treemounting on /net from about 50
> servers. The autofs program map for this uses the "showmount" command and
> that one apparently uses privileged ports too (buried inside RPC client
> libs part of glibc IIRC). The combination broke autofs and a number of
> other services because there were no privileged ports left anymore.

Yeah. The RPC library appears to always try to grab a privileged port if
it can. One solution would be to have the autofs scripts drop all
privileges before calling showmount.

I suppose we could also change the showmount program to create a socket
that is bound to an unprivileged port, then use
clnttcp_create()/clntudp_create().

We could probably do the same in the "mount" program when doing things
like interrogating the portmapper, probing for rpc ports etc. The only
case where mount might actually need to use a privileged port is when
talking to mountd. Even then, it could be trained to first try using an
unprivileged port.

Cheers,
  Trond

