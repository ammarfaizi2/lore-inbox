Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267081AbTAZXs3>; Sun, 26 Jan 2003 18:48:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267083AbTAZXs2>; Sun, 26 Jan 2003 18:48:28 -0500
Received: from 200-206-134-238.async.com.br ([200.206.134.238]:5760 "EHLO
	anthem.async.com.br") by vger.kernel.org with ESMTP
	id <S267081AbTAZXs0>; Sun, 26 Jan 2003 18:48:26 -0500
Date: Sun, 26 Jan 2003 21:56:50 -0200
From: Christian Reis <kiko@async.com.br>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Neil Brown <neilb@cse.unsw.edu.au>, linux-kernel@vger.kernel.org,
       NFS@lists.sourceforge.net
Subject: Re: [NFS] Re: NFS client locking hangs for period
Message-ID: <20030126215650.A26147@blackjesus.async.com.br>
References: <20030124184951.A23608@blackjesus.async.com.br> <15922.2657.267195.355147@notabene.cse.unsw.edu.au> <20030126140200.A25438@blackjesus.async.com.br> <shs8yx7lgyt.fsf@charged.uio.no> <20030126204711.A25997@blackjesus.async.com.br> <15924.26856.298449.357899@charged.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <15924.26856.298449.357899@charged.uio.no>; from trond.myklebust@fys.uio.no on Mon, Jan 27, 2003 at 12:02:00AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 27, 2003 at 12:02:00AM +0100, Trond Myklebust wrote:
> >>>>> " " == Christian Reis <kiko@async.com.br> writes:
> 
>      > statd(8) does indicate that /var/lib/nfs is private, so I just
>      > mount it as tmpfs. Should I make it persistent, or is the fact
>      > those files disappear on an unclean reboot a sign of trouble?
> 
> If you want locking to work, then /var/lib/nfs *MUST* be
> persistent and unique for each client.

I had never realized this; things are symmetric in an odd way with NFS,
and this bit with locking can trick you. I've changed the clients to
mount private nfs directories (the perks of shared root for diskless ;)
and I do hope things will work out from now on.

One thing worth noting is that the private /var/lib/nfs directory has to
be mounted a) with nolock (I assume) and b) *before* statd and lockd
have gone up.

> That again will typically cause a deadlock the next time you try to
> access your mailspool (if the server thinks it is already holding a
> lock on your behalf).

I am now left wondering how it bit us so little here. Is there a way of
finding out exactly *which* files are being locked at a certain time for
a certain client? 

Take care,
--
Christian Reis, Senior Engineer, Async Open Source, Brazil.
http://async.com.br/~kiko/ | [+55 16] 261 2331 | NMFL
