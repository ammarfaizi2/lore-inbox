Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268098AbTGIKLX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jul 2003 06:11:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267828AbTGIKLX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jul 2003 06:11:23 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:21676 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S268098AbTGIKF3
	(ORCPT <rfc822;Linux-Kernel@vger.kernel.org>);
	Wed, 9 Jul 2003 06:05:29 -0400
From: Nikita Danilov <Nikita@Namesys.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16139.60502.110693.175421@laputa.namesys.com>
Date: Wed, 9 Jul 2003 14:20:06 +0400
To: Andrew Morton <akpm@osdl.org>
Cc: Linux-Kernel@vger.kernel.org
Subject: Re: [PATCH] 1/5 VM changes: zone-pressure.patch
In-Reply-To: <20030709031203.3971d9b4.akpm@osdl.org>
References: <16139.54887.932511.717315@laputa.namesys.com>
	<20030709031203.3971d9b4.akpm@osdl.org>
X-Mailer: ed | telnet under Fuzzball OS, emulated on Emacs 21.5  (beta14) "cassava" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton writes:
 > Nikita Danilov <Nikita@Namesys.COM> wrote:
 > >
 > > Add zone->pressure field. It estimates scanning intensity for this zone and
 > >  is calculated as exponentially decaying average of the scanning priority
 > >  required to free enough pages in this zone (mm/vmscan.c:zone_adj_pressure()).
 > > 
 > >  zone->pressure is supposed to be used in stead of scanning priority by
 > >  vmscan.c. This is used by later patches in a series.
 > > 
 > 
 > OK, fixes a bug.

What bug?

 > 
 > > 
 > >  diff -puN include/linux/mmzone.h~zone-pressure include/linux/mmzone.h
 > >  --- i386/include/linux/mmzone.h~zone-pressure	Wed Jul  9 12:24:50 2003
 > >  +++ i386-god/include/linux/mmzone.h	Wed Jul  9 12:24:50 2003
 > >  @@ -84,11 +84,23 @@ struct zone {
 > >   	atomic_t		refill_counter;
 > >   	unsigned long		nr_active;
 > >   	unsigned long		nr_inactive;
 > >  -	int			all_unreclaimable; /* All pages pinned */
 > >  +	int			all_unreclaimable:1; /* All pages pinned */
 > 
 > I'll revert this change.  Once we start adding bitfields in there they all
 > need common locking and it gets messy.  integers are simpler.

OK.

 > 

Nikita.
