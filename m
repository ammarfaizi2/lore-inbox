Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267374AbUGNMpW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267374AbUGNMpW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 08:45:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267375AbUGNMpW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 08:45:22 -0400
Received: from mout1.freenet.de ([194.97.50.132]:32201 "EHLO mout1.freenet.de")
	by vger.kernel.org with ESMTP id S267374AbUGNMpP convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 08:45:15 -0400
From: Michael Buesch <mbuesch@freenet.de>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: explanation of apm_do_idle()
Date: Wed, 14 Jul 2004 14:44:51 +0200
User-Agent: KMail/1.6.2
References: <200407052227.29141.mbuesch@freenet.de>
In-Reply-To: <200407052227.29141.mbuesch@freenet.de>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <200407141444.54850.mbuesch@freenet.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Huh? Nobody out there who could explain it, please?
I'm surprised. 8-}

Quoting Michael Buesch <mbuesch@freenet.de>:
> Hi,
> 
> What's the purpose of
> 	t = jiffies;
> in apm_do_idle()?
> Looks very strange and incorrect to me,
> but I think there's a reason for it.
> Sorry for stealing your time, but I really don't get behind it.
> Thank you!
> 
> 
> static int apm_do_idle(void)
> {
> 	u32	eax;
> 
> 	if (apm_bios_call_simple(APM_FUNC_IDLE, 0, 0, &eax)) {
> 		static unsigned long t;
> 
> 		/* This always fails on some SMP boards running UP kernels.
> 		 * Only report the failure the first 5 times.
> 		 */
> 		if (++t < 5)
> 		{
> 			printk(KERN_DEBUG "apm_do_idle failed (%d)\n",
> 					(eax >> 8) & 0xff);
> 			t = jiffies;
> 		}
> 		return -1;
> 	}
> 	clock_slowed = (apm_info.bios.flags & APM_IDLE_SLOWS_CLOCK) != 0;
> 	return clock_slowed;
> }
> 

- -- 
Regards Michael Buesch  [ http://www.tuxsoft.de.vu ]


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFA9SrEFGK1OIvVOP4RAoG2AJsHeED0ikwA/qBnE82mte1oJRdr4QCgly1i
FOOwCgDMYdV76sXcdH5D5Dk=
=HbDh
-----END PGP SIGNATURE-----
