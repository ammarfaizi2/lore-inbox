Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422849AbWJRUJn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422849AbWJRUJn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 16:09:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422858AbWJRUJm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 16:09:42 -0400
Received: from frankvm.xs4all.nl ([80.126.170.174]:9157 "EHLO
	janus.localdomain") by vger.kernel.org with ESMTP id S1422849AbWJRUJh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 16:09:37 -0400
Date: Wed, 18 Oct 2006 22:09:36 +0200
From: Frank van Maarseveen <frankvm@frankvm.com>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Mohit Katiyar <katiyar.mohit@gmail.com>,
       Linux NFS mailing list <nfs@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org
Subject: Re: [NFS] NFS inconsistent behaviour
Message-ID: <20061018200936.GA14733@janus>
References: <A93BD15112CD05479B1CD204F7F1D4730513DB@exch-04.noida.hcltech.com> <46465bb30610160013v47524589g39c61465b5955f65@mail.gmail.com> <20061016084656.GA13292@janus> <46465bb30610160235m211910b6g2eb074aa23060aa9@mail.gmail.com> <20061016093904.GA13866@janus> <46465bb30610171822h3f747069ge9a170f1759af645@mail.gmail.com> <20061018063945.GA5917@janus> <1161194229.6095.81.camel@lade.trondhjem.org> <20061018183807.GA12018@janus> <1161199580.6095.112.camel@lade.trondhjem.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1161199580.6095.112.camel@lade.trondhjem.org>
User-Agent: Mutt/1.4.1i
X-BotBait: val@frankvm.com, kuil@frankvm.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18, 2006 at 03:26:20PM -0400, Trond Myklebust wrote:
> On Wed, 2006-10-18 at 20:38 +0200, Frank van Maarseveen wrote:
> > I ran out of privileged ports due to treemounting on /net from about 50
> > servers. The autofs program map for this uses the "showmount" command and
> > that one apparently uses privileged ports too (buried inside RPC client
> > libs part of glibc IIRC). The combination broke autofs and a number of
> > other services because there were no privileged ports left anymore.
> 
> Yeah. The RPC library appears to always try to grab a privileged port if
> it can. One solution would be to have the autofs scripts drop all
> privileges before calling showmount.
> 
> I suppose we could also change the showmount program to create a socket
> that is bound to an unprivileged port, then use
> clnttcp_create()/clntudp_create().
> 
> We could probably do the same in the "mount" program when doing things
> like interrogating the portmapper, probing for rpc ports etc. The only
> case where mount might actually need to use a privileged port is when
> talking to mountd. Even then, it could be trained to first try using an
> unprivileged port.

If we could fix why there are that many connections in state TIME_WAIT
then using privileged ports would not be a problem either.

-- 
Frank
