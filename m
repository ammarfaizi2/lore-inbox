Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261989AbTEVPyq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 May 2003 11:54:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261998AbTEVPyq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 May 2003 11:54:46 -0400
Received: from meryl.it.uu.se ([130.238.12.42]:36058 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S261989AbTEVPyp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 May 2003 11:54:45 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16076.62927.525714.113342@gargle.gargle.HOWL>
Date: Thu, 22 May 2003 18:07:43 +0200
From: mikpe@csd.uu.se
To: William Lee Irwin III <wli@holomorphy.com>
Cc: akpm@digeo.com, linux-kernel@vger.kernel.org
Subject: Re: arch/i386/kernel/mpparse.c warning fixes
In-Reply-To: <20030522155320.GP29926@holomorphy.com>
References: <20030522155320.GP29926@holomorphy.com>
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III writes:
 > diff -prauN mm8-2.5.69-1/arch/i386/kernel/mpparse.c mm8-2.5.69-2/arch/i386/kernel/mpparse.c
 > --- mm8-2.5.69-1/arch/i386/kernel/mpparse.c	2003-05-22 04:54:48.000000000 -0700
 > +++ mm8-2.5.69-2/arch/i386/kernel/mpparse.c	2003-05-22 08:06:13.000000000 -0700
 > @@ -171,7 +171,7 @@ void __init MP_processor_info (struct mp
 >  
 >  	num_processors++;
 >  
 > -	if (m->mpc_apicid > MAX_APICS) {
 > +	if (MAX_APICS - m->mpc_apicid <= 0) {
 >  		printk(KERN_WARNING "Processor #%d INVALID. (Max ID: %d).\n",
 >  			m->mpc_apicid, MAX_APICS);
 >  		--num_processors;

Eeew. Whatever the original problem is, this "fix" is just too obscure and ugly.
