Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267571AbUI2S7U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267571AbUI2S7U (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 14:59:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267507AbUI2S57
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 14:57:59 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:44256 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S268831AbUI2S40 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 14:56:26 -0400
Subject: Re: 2.6.9-rc2-mm4 drm and XFree oopses
From: Lee Revell <rlrevell@joe-job.com>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: Dave Airlie <airlied@gmail.com>, Borislav Petkov <petkov@uni-muenster.de>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <200409292143.18847.vda@port.imtp.ilyichevsk.odessa.ua>
References: <20040929102840.GA11325@none>
	 <21d7e99704092905284f48af35@mail.gmail.com>
	 <200409292143.18847.vda@port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain
Message-Id: <1096484185.1600.50.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 29 Sep 2004 14:56:25 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-09-29 at 14:43, Denis Vlasenko wrote:
> On Wednesday 29 September 2004 15:28, Dave Airlie wrote:
> > It might help if you enabled AGP for your chipset, you have no agp
> > compiled in for your Intel motherboard, you need intel agp chipset
> > support..
> 
> However kernel shouldn't use using smp_processor_id() in preemptible
> regions, with or without Intel AGP support compuled in.
>  
> > > Sep 29 12:03:07 zmei kernel: [drm:radeon_cp_init] *ERROR* radeon_cp_init called without lock held
> > > Sep 29 12:03:07 zmei kernel: [drm:radeon_unlock] *ERROR* Process 2807 using kernel context 0
> > > Sep 29 12:03:07 zmei kernel: using smp_processor_id() in preemptible code: XFree86/2807

It looks like that code that uses smp_processor_id assumes that it has
the DRM lock, but for whatever reason you don't have it.

Lee

