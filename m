Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265465AbUAJVno (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jan 2004 16:43:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265467AbUAJVnn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jan 2004 16:43:43 -0500
Received: from pop.gmx.net ([213.165.64.20]:5852 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S265465AbUAJVnl convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jan 2004 16:43:41 -0500
X-Authenticated: #20450766
Date: Sat, 10 Jan 2004 21:04:03 +0100 (CET)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
cc: Mike Fedyk <mfedyk@matchmail.com>, <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0 NFS-server low to 0 performance
In-Reply-To: <1073745028.1146.13.camel@nidelv.trondhjem.org>
Message-ID: <Pine.LNX.4.44.0401102100180.5835-100000@poirot.grange>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=koi8-r
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 10 Jan 2004, Trond Myklebust wrote:

> På lau , 10/01/2004 klokka 06:10, skreiv Guennadi Liakhovetski:
> > Yes. The reason for the problem seems to be the increased default size of
> > the transfer unit of NFS from 2.4 to 2.6. 8K under 2.4 was still ok, 16K
> > is too much - only the first 5 fragments pass fine, then data starts to
> > get lost. If it is a hardware limitation (not all platforms can manage
> > 16K), it should be probably set back to 8K. If the reason is that some
> > buffer size was not increased correspondingly, then this should be done.
>
> No! People who have problems with the support for large rsize/wsize
> under UDP due to lost fragments can
>
>   a) Reduce r/wsize themselves using mount
>   b) Use TCP instead
>
> The correct solution to this problem is (b). I.e. we convert mount to
> use TCP as the default if it is available. That is consistent with what
> all other modern implementations do.
>
> Changing a hard maximum on the server in order to fit the lowest common
> denominator client is simply wrong.

Not change - keep (from 2.4). You see, the problem might be - somebody
updates the NFS-server from 2.4 to 2.6 and then suddenly some clients fail
to work with it. Seems a non-obvious fact, that after upgrading the server
clients' configuration might have to be changed. At the very least this
must be documented in Kconfig.

Thanks
Guennadi
---
Guennadi Liakhovetski


