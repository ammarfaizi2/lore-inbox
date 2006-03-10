Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750944AbWCJLFg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750944AbWCJLFg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 06:05:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752163AbWCJLFg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 06:05:36 -0500
Received: from mx2.tue.nl ([131.155.3.6]:31198 "EHLO mx2.tue.nl")
	by vger.kernel.org with ESMTP id S1750944AbWCJLFf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 06:05:35 -0500
Message-ID: <44115D62.6000100@etpmod.phys.tue.nl>
Date: Fri, 10 Mar 2006 12:05:06 +0100
From: Bart Hartgers <bart@etpmod.phys.tue.nl>
User-Agent: Thunderbird 1.5 (X11/20060111)
MIME-Version: 1.0
To: Carlos Munoz <carlos@kenati.com>
Cc: Denis Vlasenko <vda@ilport.com.ua>, Lee Revell <rlrevell@joe-job.com>,
       Valdis.Kletnieks@vt.edu, linux-kernel@vger.kernel.org,
       alsa-devel <alsa-devel@lists.sourceforge.net>
Subject: Re: How can I link the kernel with libgcc ?
References: <4410D9F0.6010707@kenati.com> <1141961152.13319.118.camel@mindpipe> <4410F6CB.8070907@kenati.com> <200603101237.35687.vda@ilport.com.ua>
In-Reply-To: <200603101237.35687.vda@ilport.com.ua>
Content-Type: text/plain; charset=KOI8-R
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Denis Vlasenko wrote:
> On Friday 10 March 2006 05:47, Carlos Munoz wrote:
>> Lee Revell wrote:
> 
> What? You are using log10 only twice!
> 
>         if (!(siu_obj_status & ST_OPEN)) {
> 		...
>                 /* = log2(over) */
>                 ydef[22] = (u_int32_t)(log10((double)(over & 0x0000003f)) /
>                                        log10(2));
> 		...
>         }
>         else {
> 		...
>                 if (coef) {
>                         ydef[16] = 0x03045000 | (over << 26) | (tap - 4);
>                         ydef[17] = (tap * 2 + 1);
>                         /* = log2(over) */
>                         ydef[22] = (u_int32_t)
>                                 (log10((double)(over & 0x0000003f)) / log10(2));
>                 }
> 
> Don't you think that log10((double)(over & 0x0000003f)) / log10(2)
> can have only 64 different values depending on the result of (over & 0x3f)?
> 
> Obtain them from precomputed uint32_t log10table[64].

And since you're actually trying to do log2 [log10(x)/log10(2) =
log2(x)] and casting the result to an integer, aren't you really looking
for the position of the highest 1 bit or something like that? That
doesn't need FP at all.

Groeten,
Bart

> --
> vda
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


-- 
Bart Hartgers - TUE Eindhoven - http://plasimo.phys.tue.nl/bart/contact/
