Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263285AbVFXUJ1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263285AbVFXUJ1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Jun 2005 16:09:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263288AbVFXUJ0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Jun 2005 16:09:26 -0400
Received: from zproxy.gmail.com ([64.233.162.201]:3040 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S263285AbVFXUIU convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Jun 2005 16:08:20 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=e4kykOoGLhJSN96874fWzeghCcSx90jcW+DT6dXg+ULbQqbvMwQ3WUQjZ92TOwJGIympcB+Zm0YLR4dtWFFA/GkdKZl+Gh0xLMs/KDS0zKgHJxO6NYZx/juCGXHVCGahPvpLNXi+BtYa5b47Ezs9TLShnZKsOqydc8qfHbrJupk=
Message-ID: <29495f1d050624130874fd03df@mail.gmail.com>
Date: Fri, 24 Jun 2005 13:08:19 -0700
From: Nish Aravamudan <nish.aravamudan@gmail.com>
Reply-To: Nish Aravamudan <nish.aravamudan@gmail.com>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: 2.6.12-mm1 boot failure on NUMA box.
Cc: "Martin J. Bligh" <mbligh@mbligh.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Con Kolivas <kernel@kolivas.org>
In-Reply-To: <20050624195248.GA9663@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050621130344.05d62275.akpm@osdl.org>
	 <51900000.1119622290@10.10.2.4> <20050624170112.GD6393@elte.hu>
	 <320710000.1119632967@flay> <20050624195248.GA9663@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/24/05, Ingo Molnar <mingo@elte.hu> wrote:
> 
> * Martin J. Bligh <mbligh@mbligh.org> wrote:
> 
> > > -   /*
> > > -    * In the NUMA case we dont use the TSC as they are not
> > > -    * synchronized across all CPUs.
> > > -    */
> > > -#ifndef CONFIG_NUMA
> > > -   if (!use_tsc)
> > > -#endif
> > > +   if (!cpu_has_tsc)
> > >             /* no locking but a rare wrong value is not a big deal */
> > >             return jiffies_64 * (1000000000 / HZ);
> >
> > Humpf. That does look dangerous on a NUMA-Q. The TSCs aren't synced,
> > and we can't use them .... have to use PIT, whether the CPUs have TSC
> > or not.
> 
> is the only problem the unsyncedness? That should be fine as far as the
> scheduler is concerned. (we compensate for per-CPU drifts)

I'm pretty sure if the TSC gets used at all in NUMA-Q, the machine
will hang. Whenever I see that "syncronizing TSC across ## CPUs"
message at boot, I know my test is going to fail on NUMA-Q :) It is
not consistent where the hang will occur, either. Sometimes the
machine will boot but then hang in the middle of kernbench. In any
case, the solution is not to use TSC on NUMA-Q. Martin may be able to
give more technical reasons.

Thanks,
Nish
