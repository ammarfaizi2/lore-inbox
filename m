Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263634AbUC3Mdr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 07:33:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263638AbUC3Mdr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 07:33:47 -0500
Received: from gprs214-82.eurotel.cz ([160.218.214.82]:30337 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S263634AbUC3Mdq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 07:33:46 -0500
Date: Tue, 30 Mar 2004 14:33:31 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Hans-Peter Jansen <hpj@urpla.net>
Cc: Petr Vandrovec <VANDROVE@vc.cvut.cz>, linux-kernel@vger.kernel.org
Subject: Re: VMware-workstation-4.5.1 on linux-2.6.4-x86_64 host fai
Message-ID: <20040330123331.GB461@elf.ucw.cz>
References: <19772436779@vcnet.vc.cvut.cz> <200403241955.38489.hpj@urpla.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200403241955.38489.hpj@urpla.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Hmm, it's a SuSE issue then, nice to know (and easily fixable ;-).
> 
> > On 2.6.x kernels additionally (problem you are hitting now)
> > SIO*BRIDGE ioctls were moved from "compatible" to "not so
> > compatible" group. If you'll just mark them as "compatible", it
> > will work sufficiently well to get networking in VMware.
> 
> I found it. Fixed it with this patch:
> 
> --- include/linux/compat_ioctl.h~	2004-03-12 18:37:26.000000000 +0100
> +++ include/linux/compat_ioctl.h	2004-03-24 12:34:30.000000000 +0100
> @@ -247,10 +247,10 @@
>  COMPATIBLE_IOCTL(SIOCSIFENCAP)
>  COMPATIBLE_IOCTL(SIOCGIFENCAP)
>  COMPATIBLE_IOCTL(SIOCSIFNAME)
> -/* FIXME: not compatible
> +/* FIXME: not compatible */
>  COMPATIBLE_IOCTL(SIOCSIFBR)
>  COMPATIBLE_IOCTL(SIOCGIFBR)
> -*/
> +/* reactivated for vmware */
>  COMPATIBLE_IOCTL(SIOCSARP)
>  COMPATIBLE_IOCTL(SIOCGARP)
>  COMPATIBLE_IOCTL(SIOCDARP)

Marking ioctl compatible when it is not is pretty nasty, right? What
about writing conversion functions?
							Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
