Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964770AbWJJRBE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964770AbWJJRBE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 13:01:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750947AbWJJRBE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 13:01:04 -0400
Received: from a222036.upc-a.chello.nl ([62.163.222.36]:33486 "EHLO
	laptopd505.fenrus.org") by vger.kernel.org with ESMTP
	id S1750921AbWJJRBC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 13:01:02 -0400
Subject: Re: [patch 2/2] round_jiffies users
From: Arjan van de Ven <arjan@linux.intel.com>
To: Ingo Oeser <netdev@axxeo.de>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, jgarzik@pobox.com,
       akpm@osdl.org, mingo@elte.hu
In-Reply-To: <200610101847.39604.netdev@axxeo.de>
References: <1160496165.3000.308.camel@laptopd505.fenrus.org>
	 <1160496210.3000.310.camel@laptopd505.fenrus.org>
	 <1160496263.3000.312.camel@laptopd505.fenrus.org>
	 <200610101847.39604.netdev@axxeo.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 10 Oct 2006 18:59:50 +0200
Message-Id: <1160499590.3000.323.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-10-10 at 18:47 +0200, Ingo Oeser wrote:
> Hi Arjan,
> 
> Arjan van de Ven wrote:
> > Index: linux-2.6.19-rc1-git6/mm/slab.c
> > ===================================================================
> > --- linux-2.6.19-rc1-git6.orig/mm/slab.c
> > +++ linux-2.6.19-rc1-git6/mm/slab.c
> > @@ -926,7 +926,7 @@ static void __devinit start_cpu_timer(in
> >  	if (keventd_up() && reap_work->func == NULL) {
> >  		init_reap_node(cpu);
> >  		INIT_WORK(reap_work, cache_reap, NULL);
> > -		schedule_delayed_work_on(cpu, reap_work, HZ + 3 * cpu);
> > +		schedule_delayed_work_on(cpu, reap_work, __round_jiffies_relative(HZ, cpu));
> >  	}
> >  }
> >  
> 
> Did you changed the behavior by intention?
> You seem to miss the factor "3" here. This hunk should read:

Hi,

actually.. not really; the __round_jiffies_relative function just takes
a CPU number, and internally takes care of spreading things around based
on CPU number (eg it does the *3 internally); it's cleaner that way, the
callers don't need to bother by how much to spread for each cpu etc
etc... So the patch is correct as is.


Greetings,
   Arjan van de Ven


