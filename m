Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262062AbUGaUbV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262062AbUGaUbV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Jul 2004 16:31:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262114AbUGaUbU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Jul 2004 16:31:20 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:53255 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S262062AbUGaUbP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Jul 2004 16:31:15 -0400
Date: Sat, 31 Jul 2004 22:23:10 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Ben Greear <greearb@candelatech.com>,
       Matti Aarnio <matti.aarnio@zmailer.org>,
       Jeff Garzik <jgarzik@pobox.com>,
       Herbert Xu <herbert@gondor.apana.org.au>, Andrew Morton <akpm@osdl.org>,
       alan@redhat.com, jgarzik@redhat.com,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: PATCH: VLAN support for 3c59x/3c90x
Message-ID: <20040731202310.GA28074@alpha.home.local>
References: <20040730121004.GA21305@alpha.home.local> <E1BqkzY-0003mK-00@gondolin.me.apana.org.au> <20040731083308.GA24496@alpha.home.local> <410B67B1.4080906@pobox.com> <20040731101152.GG1545@alpha.home.local> <20040731141222.GJ2429@mea-ext.zmailer.org> <410BD0E3.2090302@candelatech.com> <20040731170551.GA27559@alpha.home.local> <410BD525.3010102@candelatech.com> <1091304989.1677.329.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1091304989.1677.329.camel@mindpipe>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 31, 2004 at 04:16:29PM -0400, Lee Revell wrote:
> On Sat, 2004-07-31 at 13:21, Ben Greear wrote:
> > Willy Tarreau wrote:
> > > I've seen several drivers which silently add 4 bytes to the hardware
> > > config when CONFIG_VLAN is set. I find it better than fooling the IP
> > > stack into using 1504 bytes, which is a disaster on UDP !
> > 
> > It would be a disaster with any IP protocol, not just UDP.
> 
> UDP is prone to *much* weirded behavior than TCP in the face of things
> like this.  I once had an NFS server and client using UDP.  A had its
> block size set to 8K, B to 32K.  For some reason the mount succeeded
> with these options, but when you copied a file from A to B (like, oh,
> say, /etc/passwd), it "worked", but the file was truncated to 8K!  The
> only indication that anything was wrong (other than hundreds of users
> unable to log in) was a mild warning in the logs.
> 
> I am not sure what would have happened with a TCP mount, but not that!

TCP negociates the MSS which is in some sort the min of both MTU - headers.
So TCP between hosts with MTUs of 1504 and 1500 bytes will negociate an
MSS of 1460 because it's what the smaller can do. TCP is far less sensible
to MTU problems, although it often takes lors of retransmits to fix the
problem when it's not local.

Willy

