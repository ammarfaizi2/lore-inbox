Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266499AbUHIL65@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266499AbUHIL65 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 07:58:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266498AbUHIL65
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 07:58:57 -0400
Received: from delerium.kernelslacker.org ([81.187.208.145]:17282 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S266499AbUHIL6w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 07:58:52 -0400
Date: Mon, 9 Aug 2004 12:48:14 +0100
From: Dave Jones <davej@redhat.com>
To: Sven-Haegar Koch <haegar@sdinet.de>
Cc: Linux-Kernel-Mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: Suspend/Resume support for ati-agp
Message-ID: <20040809114814.GA2640@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Sven-Haegar Koch <haegar@sdinet.de>,
	Linux-Kernel-Mailinglist <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.58.0408080331490.15568@mercury.sdinet.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0408080331490.15568@mercury.sdinet.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 08, 2004 at 03:39:33AM +0200, Sven-Haegar Koch wrote:

 > while trying to debug a strange resume problem with 2.6.8-rc3-mm1 and
 > software suspend 2 I suspeced ati-agp, and created the following attached
 > patch to add powermanagement support for it.
 > 
 > I don't know if it's the completely right thing to do, I just copied the
 > way via-agp and intel-agp do it - but perhaps you like it and want to send
 > it upstream.

I'll have to dig out the specs for this chipset to double check a
reconfigure is enough (or even needed).  Does this patch definitly make
a difference to you on resume ?

 > ps:
 > this did not fix the strange "weird vertical bars instead of movie in
 > mplayer after resume" I have, but does not do any bad things either ;)

That wouldn't be using AGP anyway. The only difference this could make
would be if you were using 3D applications.

 > +
 > +	/* reconfigure AGP hardware again */
 > +	if (bridge->driver == &ati_generic_bridge)
 > +		return ati_configure();
 > +
 > +	return 0;

If bridge->driver _isn't_ ati_generic_bridge, I don't think we can
ever get here, so you can probably just make this unconditional.

		Dave

