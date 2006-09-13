Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750700AbWIMQf6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750700AbWIMQf6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Sep 2006 12:35:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750705AbWIMQf6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Sep 2006 12:35:58 -0400
Received: from mx1.redhat.com ([66.187.233.31]:42653 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750700AbWIMQf5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Sep 2006 12:35:57 -0400
Date: Wed, 13 Sep 2006 12:42:51 -0400
From: Dave Jones <davej@redhat.com>
To: Jarek Poplawski <jarkao2@o2.pl>
Cc: linux-kernel@vger.kernel.org, ak@suse.de
Subject: Re: [PATCH] mpparse.c:231: warning: comparison is always false
Message-ID: <20060913164251.GD13956@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Jarek Poplawski <jarkao2@o2.pl>, linux-kernel@vger.kernel.org,
	ak@suse.de
References: <20060913065010.GA2110@ff.dom.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060913065010.GA2110@ff.dom.local>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 13, 2006 at 08:50:10AM +0200, Jarek Poplawski wrote:
 
 > Probably after 2.6.18-rc6-git1 there is this cc warning: 
 > "arch/i386/kernel/mpparse.c:231: warning: comparison is
 > always false due to limited range of data type".
 > Maybe this patch will be helpful.
 > 
 > diff -Nurp linux-2.6.18-rc6-git4-/arch/i386/kernel/mpparse.c linux-2.6.18-rc6-git4/arch/i386/kernel/mpparse.c
 > --- linux-2.6.18-rc6-git4-/arch/i386/kernel/mpparse.c	2006-09-13 00:01:00.000000000 +0200
 > +++ linux-2.6.18-rc6-git4/arch/i386/kernel/mpparse.c	2006-09-13 00:01:00.000000000 +0200
 > @@ -228,12 +228,14 @@ static void __init MP_bus_info (struct m
 >  
 >  	mpc_oem_bus_info(m, str, translation_table[mpc_record]);
 >  
 > +#if 0xFF >= MAX_MP_BUSSES
 >  	if (m->mpc_busid >= MAX_MP_BUSSES) {
 >  		printk(KERN_WARNING "MP table busid value (%d) for bustype %s "
 >  			" is too large, max. supported is %d\n",
 >  			m->mpc_busid, str, MAX_MP_BUSSES - 1);
 >  		return;
 >  	}
 > +#endif

mpc_busid is a uchar. I don't see how this can ever be > 0xff, yet
mach-summit and mach-generic have MAX_MP_BUSSES set to 260.

I don't see how this can possibly work.

	Dave
