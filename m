Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318345AbSH1Ajb>; Tue, 27 Aug 2002 20:39:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318368AbSH1Ajb>; Tue, 27 Aug 2002 20:39:31 -0400
Received: from h24-67-14-151.cg.shawcable.net ([24.67.14.151]:23548 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S318345AbSH1Aj2>; Tue, 27 Aug 2002 20:39:28 -0400
From: Andreas Dilger <adilger@clusterfs.com>
Date: Tue, 27 Aug 2002 18:41:54 -0600
To: Daniel Phillips <phillips@arcor.de>
Cc: Andrew Morton <akpm@zip.com.au>, Lahti Oy <rlahti@netikka.fi>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched.c
Message-ID: <20020828004154.GS19435@clusterfs.com>
Mail-Followup-To: Daniel Phillips <phillips@arcor.de>,
	Andrew Morton <akpm@zip.com.au>, Lahti Oy <rlahti@netikka.fi>,
	linux-kernel@vger.kernel.org
References: <000b01c24df5$aacc7ed0$d20a5f0a@deldaran> <3D6BC685.216B5B67@zip.com.au> <E17jqSE-0002jN-00@starship>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E17jqSE-0002jN-00@starship>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Aug 28, 2002  02:13 +0200, Daniel Phillips wrote:
> On Tuesday 27 August 2002 20:35, Andrew Morton wrote:
> > Lahti Oy wrote:
> > > - for (i = 0; i < NR_CPUS; i++)
> > > + for (i = NR_CPUS; i; i--)
> > >    sum += cpu_rq(i)->nr_running;
> > 
> > Off-by-one there.  You'd want
> > 
> > 	for (i = NR_CPUS; --i >= 0; )
> > 
> > or something similarly foul ;)
> 
> 	int i = NR_CPUS;
> 
> 	while (--i)

Actually, I prefer the following to avoid wrap-around conditions in
strange circumstances (i.e. if 'i' is manipulated between setting
and the while loop):

	while (i-- > 0) {
		...
	}

Cheers, Andreas
--
Andreas Dilger
http://www-mddsp.enel.ucalgary.ca/People/adilger/
http://sourceforge.net/projects/ext2resize/

