Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752050AbWCJKiI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752050AbWCJKiI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 05:38:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752167AbWCJKiH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 05:38:07 -0500
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:63450 "HELO
	ilport.com.ua") by vger.kernel.org with SMTP id S1752050AbWCJKiG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 05:38:06 -0500
From: Denis Vlasenko <vda@ilport.com.ua>
To: Carlos Munoz <carlos@kenati.com>
Subject: Re: How can I link the kernel with libgcc ?
Date: Fri, 10 Mar 2006 12:37:35 +0200
User-Agent: KMail/1.8.2
Cc: Lee Revell <rlrevell@joe-job.com>, Valdis.Kletnieks@vt.edu,
       linux-kernel@vger.kernel.org,
       alsa-devel <alsa-devel@lists.sourceforge.net>
References: <4410D9F0.6010707@kenati.com> <1141961152.13319.118.camel@mindpipe> <4410F6CB.8070907@kenati.com>
In-Reply-To: <4410F6CB.8070907@kenati.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603101237.35687.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 10 March 2006 05:47, Carlos Munoz wrote:
> Lee Revell wrote:
> 
> >On Thu, 2006-03-09 at 19:25 -0800, Carlos Munoz wrote:
> >  
> >
> >>I figured out how to get the driver to use floating point operations.
> >>I included source code (from an open source math library) for the
> >>log10 function in the driver. Then I added the following lines to the
> >>file arch/sh/kernel/sh_ksyms.c: 
> >>    
> >>
> >
> >Where is the source code to your driver?
> >
> >Lee
> >
> >  
> >
> Hi Lee,
> 
> Be warned. This driver is in the early stages of development. There is 
> still a lot of work that needs to be done (interrupt, dma, etc, etc).

What? You are using log10 only twice!

        if (!(siu_obj_status & ST_OPEN)) {
		...
                /* = log2(over) */
                ydef[22] = (u_int32_t)(log10((double)(over & 0x0000003f)) /
                                       log10(2));
		...
        }
        else {
		...
                if (coef) {
                        ydef[16] = 0x03045000 | (over << 26) | (tap - 4);
                        ydef[17] = (tap * 2 + 1);
                        /* = log2(over) */
                        ydef[22] = (u_int32_t)
                                (log10((double)(over & 0x0000003f)) / log10(2));
                }

Don't you think that log10((double)(over & 0x0000003f)) / log10(2)
can have only 64 different values depending on the result of (over & 0x3f)?

Obtain them from precomputed uint32_t log10table[64].
--
vda
