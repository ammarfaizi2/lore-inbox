Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318460AbSH1App>; Tue, 27 Aug 2002 20:45:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318468AbSH1App>; Tue, 27 Aug 2002 20:45:45 -0400
Received: from dsl-213-023-020-028.arcor-ip.net ([213.23.20.28]:19141 "EHLO
	starship") by vger.kernel.org with ESMTP id <S318460AbSH1Apn>;
	Tue, 27 Aug 2002 20:45:43 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Andreas Dilger <adilger@clusterfs.com>
Subject: Re: [PATCH] sched.c
Date: Wed, 28 Aug 2002 02:51:52 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Andrew Morton <akpm@zip.com.au>, Lahti Oy <rlahti@netikka.fi>,
       linux-kernel@vger.kernel.org
References: <000b01c24df5$aacc7ed0$d20a5f0a@deldaran> <E17jqSE-0002jN-00@starship> <20020828004154.GS19435@clusterfs.com>
In-Reply-To: <20020828004154.GS19435@clusterfs.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17jr3o-0002k1-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 28 August 2002 02:41, Andreas Dilger wrote:
> On Aug 28, 2002  02:13 +0200, Daniel Phillips wrote:
> > On Tuesday 27 August 2002 20:35, Andrew Morton wrote:
> > > Lahti Oy wrote:
> > > > - for (i = 0; i < NR_CPUS; i++)
> > > > + for (i = NR_CPUS; i; i--)
> > > >    sum += cpu_rq(i)->nr_running;
> > > 
> > > Off-by-one there.  You'd want
> > > 
> > > 	for (i = NR_CPUS; --i >= 0; )
> > > 
> > > or something similarly foul ;)
> > 
> > 	int i = NR_CPUS;
> > 
> > 	while (--i)
	       ^^^ i--
> 
> Actually, I prefer the following to avoid wrap-around conditions in
> strange circumstances (i.e. if 'i' is manipulated between setting
> and the while loop):
> 
> 	while (i-- > 0) {
> 		...
> 	}

Hi Andreas,

If this counter goes negative you have other, much bigger problems
and you better not try to cover them up.

Daniel
