Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750930AbWBLApP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750930AbWBLApP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Feb 2006 19:45:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932065AbWBLApP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Feb 2006 19:45:15 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:37062 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1750930AbWBLApO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Feb 2006 19:45:14 -0500
Subject: Re: RCU latency regression in 2.6.16-rc1
From: Lee Revell <rlrevell@joe-job.com>
To: paulmck@us.ibm.com
Cc: Eric Dumazet <dada1@cosmosbay.com>, dipankar@in.ibm.com,
       Ingo Molnar <mingo@elte.hu>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <20060130051156.GK16585@us.ibm.com>
References: <1138224506.3087.22.camel@mindpipe>
	 <20060126191809.GC6182@us.ibm.com> <1138388123.3131.26.camel@mindpipe>
	 <20060128170302.GB5633@in.ibm.com> <1138471203.2799.13.camel@mindpipe>
	 <1138474283.2799.24.camel@mindpipe> <20060128193412.GH5633@in.ibm.com>
	 <43DBCB62.7030308@cosmosbay.com> <20060130043604.GF16585@us.ibm.com>
	 <43DD9C49.4000000@cosmosbay.com>  <20060130051156.GK16585@us.ibm.com>
Content-Type: text/plain
Date: Sat, 11 Feb 2006 19:45:10 -0500
Message-Id: <1139705111.19342.162.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.90 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-01-29 at 21:11 -0800, Paul E. McKenney wrote:
> > Well, if as a bonus we are able to expand the size of the hash
> table, it 
> > could be very very good : As of today, the boot time sizing of this
> hash 
> > table is somewhat problematic.
> > 
> > If the size is expanded by a 2 factor (or a power of too), can your 
> > proposal works ?
> 
> Yep!!!
> 
> Add the following:
> 
> o       Add a size variable for each of the tables.  It works best
>         if the per-table state is stored with the table itself, for
>         example:
> 
>         struct hashtbl {
>                 int size;
>                 int fvl;
>                 struct hash_param params;
>                 struct list_head buckets[0];
>         };
> 
> o       When switching tables, allocate a new one of the desired size
>         and free up the non-current one.  (But remember to wait at
> least
>         one grace period after the last switch before starting
> this!!!)
> 
> o       Compute hash parameters suitable for the new table size.
> 
> o       Continue as before.
> 
> Note that you are not restricted to power-of-two expansion -- the
> hash parameters should handle any desired difference, and in fact
> handle contraction as well as expansion. 

I'd be glad to test any patches whenever someone gets around to working
on this.

Lee

