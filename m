Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317665AbSFLIAs>; Wed, 12 Jun 2002 04:00:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317666AbSFLIAr>; Wed, 12 Jun 2002 04:00:47 -0400
Received: from ausmtp01.au.ibm.COM ([202.135.136.97]:53231 "EHLO
	ausmtp01.au.ibm.com") by vger.kernel.org with ESMTP
	id <S317665AbSFLIAr>; Wed, 12 Jun 2002 04:00:47 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org,
        k-suganuma@mvj.biglobe.ne.jp
Subject: Re: [PATCH] 2.5.21 Nonlinear CPU support 
In-Reply-To: Your message of "Wed, 12 Jun 2002 08:57:52 +0100."
             <E17I30q-00077h-00@the-village.bc.nu> 
Date: Wed, 12 Jun 2002 18:01:28 +1000
Message-Id: <E17I34K-0004dp-00@wagner.rustcorp.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <E17I30q-00077h-00@the-village.bc.nu> you write:
> > --- linux-2.5.21.24110/fs/ntfs/compress.c	Sat May 25 14:34:53 2002
> >  		return -ENOMEM;
> > -	for (i = 0; i < smp_num_cpus; i++) {
> > +	for (i = 0; i < NR_CPUS; i++) {
> >  		ntfs_compression_buffers[i] = (u8*)vmalloc(NTFS_MAX_CB_SIZE);
> >  		if (!ntfs_compression_buffers[i])
> >  			break;
> 
> 2Mbytes !!!!!!
> 
> Add a cpu count changed notifier ?

There is one in the next patch, of course.  But with that patch you
also get cpu_possible():

	for (i = 0; i < NR_CPUS; i++) {
		if (!cpu_possible(i)) {
			ntfs_compression_buffers[i] = NULL;
			continue;
		}

Hope that clarifies,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
