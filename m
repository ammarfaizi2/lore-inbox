Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261439AbUE3AsN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261439AbUE3AsN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 May 2004 20:48:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261418AbUE3AsM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 May 2004 20:48:12 -0400
Received: from mx1.redhat.com ([66.187.233.31]:17814 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261358AbUE3AsF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 May 2004 20:48:05 -0400
Subject: Re: iowait problems on 2.6, not on 2.4
From: Doug Ledford <dledford@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Antonio Larrosa =?ISO-8859-1?Q?Jim=E9nez?= <antlarr@tedial.com>,
       linux-kernel@vger.kernel.org,
       linux-scsi mailing list <linux-scsi@vger.kernel.org>
In-Reply-To: <20040528154525.6ed5f7b9.akpm@osdl.org>
References: <200405261743.28111.antlarr@tedial.com>
	 <20040526205225.7a0866aa.akpm@osdl.org>
	 <200405281516.41901.antlarr@tedial.com>
	 <20040528154525.6ed5f7b9.akpm@osdl.org>
Content-Type: text/plain; charset=UTF-8
Message-Id: <1085877991.18642.336.camel@compaq.xsintricity.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-1) 
Date: Sat, 29 May 2004 20:46:31 -0400
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-05-28 at 18:45, Andrew Morton wrote:
> Antonio Larrosa Jiménez <antlarr@tedial.com> wrote:
> >
> > On Thursday 27 May 2004 05:52, you wrote:
> > > Antonio Larrosa Jiménez <antlarr@tedial.com> wrote:
> > > > My next test will be to do the "dd tests" on one of the internal hard
> > > > disks and use it for the data instead of the external raid.
> > >
> > > That's a logical next step.  The reduced read bandwith on the raid array
> > > should be fixed up before we can go any further.  I don't recall any
> > > reports of qlogic fc-scsi performance regressions though.
> > 
> > Ok, let's analyze that first.
> > 
> > The dd tests gave the following results:
> 
> Let me cc linux-scsi.
> 
> Guys: poke.  Does anyone know why this:
> 
>   The machine is a 4 cpu Pentium III (Cascades) system with four SCSI
>   SEAGATE ST336704 hard disks connected to an Adaptec AIC-7899P U160/m, and
>   a external RAID connected to a QLA2200/QLA2xxx FC-SCSI Host Bus Adapter. 
>   The machine has 1Gb RAM.
> 
> got all slow at reads?

My first guess would be read ahead values.  Try poking around with
those.  When using a hard disk vs. a raid array, it's easier to trigger
firmware read ahead since all reads go to a single physical device and
that in turn compensates for lack of reasonable OS read ahead.  On a
raid array, depending on the vendor, there may be next to no firmware
initiated read ahead and that can drastically reduce read performance on
sequential reads.


> > So yes, I suppose there's a regression on the qlogic fc-scsi module.

A regression, yes.  In the qlogic-fc driver?  I doubt it.  Performance
tuning is what I think this basically boils down to.

But, I could be wrong.  Give it a try and see what happens.  In the 2.4
kernels I would tell you to tweak /proc/sys/vm/{min,max}-readahead,
don't know if those two knobs still exist in 2.6 and if they have the
same effect.  Andrew?

-- 
  Doug Ledford <dledford@redhat.com>     919-754-3700 x44233
         Red Hat, Inc.
         1801 Varsity Dr.
         Raleigh, NC 27606


