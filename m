Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965095AbWECF1z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965095AbWECF1z (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 May 2006 01:27:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965096AbWECF1z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 May 2006 01:27:55 -0400
Received: from ns9.hostinglmi.net ([213.194.149.146]:54182 "EHLO
	ns9.hostinglmi.net") by vger.kernel.org with ESMTP id S965095AbWECF1y
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 May 2006 01:27:54 -0400
Date: Wed, 3 May 2006 07:27:52 +0200
From: DervishD <lkml@dervishd.net>
To: Nathan Scott <nathans@sgi.com>
Cc: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: O_DIRECT, ext3fs, kernel 2.4.32... again
Message-ID: <20060503052752.GA20657@DervishD>
Mail-Followup-To: Nathan Scott <nathans@sgi.com>,
	Linux-kernel <linux-kernel@vger.kernel.org>
References: <20060427063249.GH761@DervishD> <20060501062058.GA16589@dmt> <20060501112303.GA1951@DervishD> <20060502072808.A1873249@wobbly.melbourne.sgi.com> <20060502172411.GA6112@DervishD> <20060503060336.A1918058@wobbly.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060503060336.A1918058@wobbly.melbourne.sgi.com>
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
> > > Nothing else really make sense due to fcntl...
> > > 	fcntl(fd, F_SETFL, O_DIRECT);
> > > ...can happen at any time, to enable/disable direct I/O.
> > 
> >     I know, but that fcntl call should fail just like the open() one.
> > I mean, I don't find this very different, it's just another point
> > where the flag can be activated and so it should fail if the
> > underlying filesystem doesn't support it (and doesn't ignore it
> > in read()/write()).
> 
> Problem is there is no way to know whether the underlying fs
> supports direct IO or not here (fcntl is implemented outside the
> filesystem, entirely).

    I thought that it was implemented per filesystem.

> Which is not unfixable in itself (could use a superblock flag or
> something similar) but it's way out of scope for the sort of change
> going into 2.4 these days.

    Which approach does 2.6 kernel use? O_DIRECT is correctly handled
for ext3 there, AFAIK :? Are the differences too large?

    I know that this change would be intrusive and probably large,
but IMHO is a quite important bug, because it prevents apps to
selectively disable O_DIRECT (the flag is accepted by open(), so
there's no reason the app should bother about which caused the
read()/write() failures. In fact, is very difficult to know that
those failures are caused by partial/buggy support of O_DIRECT flag).

    Thanks for the information! :)

    Raúl Núñez de Arenas Coronado

-- 
Linux Registered User 88736 | http://www.dervishd.net
http://www.pleyades.net & http://www.gotesdelluna.net
It's my PC and I'll cry if I want to... RAmen!
