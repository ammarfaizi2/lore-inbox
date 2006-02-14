Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161036AbWBNMjN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161036AbWBNMjN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 07:39:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161038AbWBNMjM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 07:39:12 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:15540 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1161036AbWBNMjM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 07:39:12 -0500
Date: Tue, 14 Feb 2006 13:37:27 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Olaf Hering <olh@suse.de>, Hannes Reinecke <hare@suse.de>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: calibrate_migration_costs takes ages on s390
Message-ID: <20060214123727.GA5451@elte.hu>
References: <20060213102634.GA4677@osiris.boeblingen.de.ibm.com> <20060213104645.GA17173@elte.hu> <20060213234254.GA5368@suse.de> <20060214000807.GA6188@suse.de> <20060214080942.GC19896@osiris.boeblingen.de.ibm.com> <20060214105608.GD19896@osiris.boeblingen.de.ibm.com> <20060214123521.GB3138@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060214123521.GB3138@elte.hu>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.2
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.2 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.6 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Ingo Molnar <mingo@elte.hu> wrote:

> * Heiko Carstens <heiko.carstens@de.ibm.com> wrote:
> 
> > --- a/arch/s390/lib/delay.c
> > +++ b/arch/s390/lib/delay.c
> > @@ -30,7 +30,7 @@ void __delay(unsigned long loops)
> >           */
> >          __asm__ __volatile__(
> >                  "0: brct %0,0b"
> > -                : /* no outputs */ : "r" (loops/2) );
> > +                : /* no outputs */ : "r" ((loops/2) + 1));
> >  }
> 
> ahh ... that explains the delays indeed!

just to make sure, i've checked all the other __delay() implementations 
in the kernel, and none seems to have such problems.

	Ingo
