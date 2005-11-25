Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751462AbVKYTdb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751462AbVKYTdb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Nov 2005 14:33:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751465AbVKYTda
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Nov 2005 14:33:30 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:61583 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751462AbVKYTd2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Nov 2005 14:33:28 -0500
Subject: Re: 2.6.14-rt4: via DRM errors
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Arjan van de Ven <arjan@infradead.org>,
       Jesse Barnes <jbarnes@virtuousgeek.org>,
       dri-devel@lists.sourceforge.net,
       Thomas =?ISO-8859-1?Q?Hellstr=F6m?= <unichrome@shipmail.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1132946629.20390.51.camel@mindpipe>
References: <1132807985.1921.82.camel@mindpipe>
	 <1132829378.3473.11.camel@mindpipe>
	 <19379.192.138.116.230.1132836621.squirrel@192.138.116.230>
	 <200511240731.56147.jbarnes@virtuousgeek.org>
	 <1132945536.20390.39.camel@mindpipe>
	 <1132946020.8990.7.camel@laptopd505.fenrus.org>
	 <1132946629.20390.51.camel@mindpipe>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 25 Nov 2005 20:06:12 +0000
Message-Id: <1132949172.7987.2.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2005-11-25 at 14:23 -0500, Lee Revell wrote:
> On Fri, 2005-11-25 at 20:13 +0100, Arjan van de Ven wrote:
> > of course sometimes having less but more coarse locks is actually
> > faster. Taking/dropping a lock is not free. far from it. 
> 
> True but couldn't it be a problem for devices like unichrome where you
> have 3D and MPEG acceleration and they have to play nice?  It just seems
> like there may have been an implicit assumption that devices only
> support one type of hardware acceleration.

Not really. The DRI locking is what the driver makes of it. Generally
GPUs are internally very coarse grained and don't like doing different
jobs at the same time anyway.

The nearest thing I think to look at it as would be futex locks, and DRI
could probably use futex locks with some glue for the X authentication
side of things. However futex locks are not in FreeBSD and may never be
(IBM patent questions for non-GPL), and DRI predates futexes by a large
margin.

