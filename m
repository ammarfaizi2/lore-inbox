Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262462AbUDTJYY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262462AbUDTJYY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Apr 2004 05:24:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262424AbUDTJYY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Apr 2004 05:24:24 -0400
Received: from mail3.codesense.com ([213.132.104.154]:48029 "EHLO
	mail3.codesense.com") by vger.kernel.org with ESMTP id S262468AbUDTJVT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Apr 2004 05:21:19 -0400
Subject: Re: Failing back to INSANE timesource :) Time stopped today.
From: Niclas Gustafsson <niclas.gustafsson@codesense.com>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: john stultz <johnstul@us.ibm.com>, linux-kernel@vger.kernel.org,
       Patricia Gaughen <gone@us.ibm.com>
In-Reply-To: <1082048278.17234.144.camel@gmg.codesense.com>
References: <1081416100.6425.45.camel@gmg.codesense.com>
	 <1081465114.4705.4.camel@cog.beaverton.ibm.com>
	 <1081932857.17234.37.camel@gmg.codesense.com>
	 <Pine.LNX.4.55.0404151633100.17365@jurand.ds.pg.gda.pl>
	 <1082048278.17234.144.camel@gmg.codesense.com>
Content-Type: text/plain
Message-Id: <1082452873.20179.34.camel@gmg.codesense.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 20 Apr 2004 11:21:14 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi again,

I've now been running the system since last week, about 6 days now with
sometimes quite high load, both in regard to CPU usage and network
traffic.
And it seems to be running just fine with the patch from Maciej.

I've got a couple of questions, 

When was this bug introduced? Was it 2.6.1 ( or rather somewhere in
2.5)? Or was it already present in 2.4?

When will this patch be merged into the 2.6-tree?  I don't have to
stress the impact of this problem on IBM servers as they are rendered
quite useless.

Which other IBM models are affected? Can I run 2.6.5 on my 345:s or
335:s?  Do they use the same buggy SMM firmware?




Cheers,

Niclas 


tor 2004-04-15 klockan 18.57 skrev Niclas Gustafsson:
> Hello and thanks,
> 
> I've compiled and deployed a kernel with the patch below.
> I'm about to start some more tests on the machine - it's going to be
> interesting to see how it works out, I'll let you know.
> 
> 
> Cheers,
> 
> Niclas
>   
> 
> tor 2004-04-15 klockan 16.47 skrev Maciej W. Rozycki:
> > On Wed, 14 Apr 2004, Niclas Gustafsson wrote:
> > 
> > > Watching the /proc/interrupts with 10s apart after the "stop".
> > > 
> > > [root@s151 root]# more /proc/interrupts
> > >            CPU0
> > >   0:   66413955  local-APIC-edge  timer
> > [...]
> > > LOC:   67355837
> > > ERR:          0
> > > MIS:          0
> > > [root@s151 root]# more /proc/interrupts
> > >            CPU0
> > >   0:   66413955  local-APIC-edge  timer
> > [...]
> > > LOC:   67379568
> > > ERR:          0
> > > MIS:          0
> > 
> >  This may be because buggy SMM firmware messes with the 8259A (configured
> > for a transparent mode -- yes that rare "local-APIC-edge" mode is tricky
> > ;-) ) insanely.  You've written this is an IBM box previously -- this 
> > would be no surprise.  The following patch should help -- I think it's 
> > already included in the -mm series.

