Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964942AbWEBRYS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964942AbWEBRYS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 13:24:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964944AbWEBRYR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 13:24:17 -0400
Received: from ns9.hostinglmi.net ([213.194.149.146]:26320 "EHLO
	ns9.hostinglmi.net") by vger.kernel.org with ESMTP id S964942AbWEBRYP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 13:24:15 -0400
Date: Tue, 2 May 2006 19:24:11 +0200
From: DervishD <lkml@dervishd.net>
To: Nathan Scott <nathans@sgi.com>
Cc: Marcelo Tosatti <marcelo@kvack.org>,
       Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: O_DIRECT, ext3fs, kernel 2.4.32... again
Message-ID: <20060502172411.GA6112@DervishD>
Mail-Followup-To: Nathan Scott <nathans@sgi.com>,
	Marcelo Tosatti <marcelo@kvack.org>,
	Linux-kernel <linux-kernel@vger.kernel.org>
References: <20060427063249.GH761@DervishD> <20060501062058.GA16589@dmt> <20060501112303.GA1951@DervishD> <20060502072808.A1873249@wobbly.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060502072808.A1873249@wobbly.melbourne.sgi.com>
User-Agent: Mutt/1.4.2.1i
Organization: DervishD
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - ns9.hostinglmi.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - dervishd.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hi Nathan :)

 * Nathan Scott <nathans@sgi.com> dixit:
> On Mon, May 01, 2006 at 01:23:03PM +0200, DervishD wrote:
> >  * Marcelo Tosatti <marcelo@kvack.org> dixit:
> > > >     Shouldn't ext3fs return an error when the O_DIRECT flag is
> > > > used in the open call? Is the open call userspace only and thus
> > > > only libc can return such error? Am I misunderstanding the entire
> > > > issue and this is a perfectly legal behaviour (allowing the open,
> > > > failing in the read operation)?
> > > 
> > > Your interpretation is correct. It would be nicer for open() to
> > > fail on fs'es which don't support O_DIRECT, but v2.4 makes such
> > > check later at read/write unfortunately ;(
> > 
> >     Oops :(
> 
> Nothing else really make sense due to fcntl...
> 	fcntl(fd, F_SETFL, O_DIRECT);
> ...can happen at any time, to enable/disable direct I/O.

    I know, but that fcntl call should fail just like the open() one.
I mean, I don't find this very different, it's just another point
where the flag can be activated and so it should fail if the
underlying filesystem doesn't support it (and doesn't ignore it in
read()/write()).

    Raúl Núñez de Arenas Coronado

-- 
Linux Registered User 88736 | http://www.dervishd.net
http://www.pleyades.net & http://www.gotesdelluna.net
It's my PC and I'll cry if I want to... RAmen!
