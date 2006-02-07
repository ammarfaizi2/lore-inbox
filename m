Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964844AbWBGSbE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964844AbWBGSbE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 13:31:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964849AbWBGSbE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 13:31:04 -0500
Received: from e33.co.us.ibm.com ([32.97.110.151]:30658 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S964844AbWBGSbD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 13:31:03 -0500
Date: Wed, 8 Feb 2006 00:00:18 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, dada1@cosmosbay.com,
       heiko.carstens@de.ibm.com, linux-kernel@vger.kernel.org,
       davem@davemloft.net, James.Bottomley@steeleye.com, mingo@elte.hu,
       axboe@suse.de, anton@samba.org, wli@holomorphy.com, ak@muc.de
Subject: Re: [PATCH] percpu data: only iterate over possible CPUs
Message-ID: <20060207183018.GA29056@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <200602051959.k15JxoHK001630@hera.kernel.org> <20060207151541.GA32139@osiris.boeblingen.de.ibm.com> <43E8CA10.5070501@cosmosbay.com> <Pine.LNX.4.64.0602070833590.3854@g5.osdl.org> <20060207093458.176ac271.akpm@osdl.org> <Pine.LNX.4.64.0602070946190.3854@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0602070946190.3854@g5.osdl.org>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 07, 2006 at 09:48:41AM -0800, Linus Torvalds wrote:
> 
> 
> On Tue, 7 Feb 2006, Andrew Morton wrote:
> > 
> > This one:
> > 
> > --- devel/fs/file.c~reduce-size-of-percpudata-and-make-sure-per_cpuobject	2006-02-04 23:27:17.000000000 -0800
> > +++ devel-akpm/fs/file.c	2006-02-04 23:27:17.000000000 -0800
> > @@ -379,7 +379,6 @@ static void __devinit fdtable_defer_list
> >  void __init files_defer_init(void)
> >  {
> >  	int i;
> > -	/* Really early - can't use for_each_cpu */
> > -	for (i = 0; i < NR_CPUS; i++)
> > +	for_each_cpu(i)
> >  		fdtable_defer_list_init(i);
> >  }
> > 
> > And yes, me too - when I saw that comment disappear I checked and decided
> > that the comment was both wrong and undesirable.
> 
> Ahh, yes. The comment is totally incorrect, we must have done the CPU 
> setup much too later a long long time ago ;)

One would think so, but I recall not all archs did that. Alpha for
example sets up cpu_possible_map in smp_prepare_cpus(). It however
makes more sense to fix the arch then use NR_CPUS, IMO.

Thanks
Dipankar
