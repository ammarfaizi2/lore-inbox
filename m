Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264815AbSKEIrW>; Tue, 5 Nov 2002 03:47:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264816AbSKEIrW>; Tue, 5 Nov 2002 03:47:22 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:10258 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S264815AbSKEIrV>; Tue, 5 Nov 2002 03:47:21 -0500
From: Alexander Zarochentcev <zam@namesys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15815.34316.24237.515178@crimson.namesys.com>
Date: Tue, 5 Nov 2002 11:49:16 +0300
To: reiser@namesys.com
Cc: Nikita Danilov <Nikita@namesys.com>, Tomas Szepe <szepe@pinerecords.com>,
       lkml <linux-kernel@vger.kernel.org>, Oleg Drokin <green@namesys.com>,
       umka <umka@namesys.com>
Subject: Re: [BK][PATCH] Reiser4, will double Linux FS performance, pleaseapply
In-Reply-To: <3DC784E3.2090001@namesys.com>
References: <3DC19F61.5040007@namesys.com>
	<200210312334.18146.Dieter.Nuetzel@hamburg.de>
	<3DC1B2FA.8010809@namesys.com>
	<3DC1D63A.CCAD78EF@digeo.com>
	<3DC1D885.6030902@namesys.com>
	<3DC1D9D0.684326AC@digeo.com>
	<3DC1DF02.7060307@namesys.com>
	<20021101102327.GA26306@louise.pinerecords.com>
	<15810.46998.714820.519167@crimson.namesys.com>
	<20021102132421.GJ28803@louise.pinerecords.com>
	<15814.21309.758207.21416@laputa.namesys.com>
	<3DC773B0.4070701@namesys.com>
	<15815.33089.583184.62816@crimson.namesys.com>
	<3DC784E3.2090001@namesys.com>
X-Mailer: VM 7.00 under Emacs 21.2.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

reiser writes:
 > Alexander Zarochentcev wrote:
 > 
 > > > >
 > > > >In reiser4 allocation of disk space is delayed to transaction commit. It
 > > > >is not possible to estimate precisely amount of disk space that will be
 > > > >allocated during commit, and hence statfs(2) results are not updated
 > > > >until one does sync(2) (forcing commit) or transaction is committed due
 > > > >to age (10 minutes by default).
 > > > >
 > > > >  
 > > > >
 > > > The above is badly phrased, and the behavior complained of is indeed a 
 > > > bug not a feature.  Please fix.  
 > > > 
 > > > statfs should be updated immediately in accordance with estimates used 
 > > > by the space reservation code, and then adjusted at commit time in 
 > > > accordance with actual usage.
 > >
 > >We should not do that unless we implement forcing of commits at out of free
 > >space situation.
 > >
 > I thought we had agreed to do forcing of commits at out of free space 
 > quite some time ago?  In any event, we should do forcing of commits at 
 > out of free space.  Yes?

we will control this by a block allocator flag, we set it when we can close
current transaction. I think for most cases it will be set.
 

-- 
Alex.
