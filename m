Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265875AbUBQCpk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Feb 2004 21:45:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265953AbUBQCpk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Feb 2004 21:45:40 -0500
Received: from fw.osdl.org ([65.172.181.6]:17061 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265875AbUBQCph (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Feb 2004 21:45:37 -0500
Date: Mon, 16 Feb 2004 18:45:35 -0800
From: Chris Wright <chrisw@osdl.org>
To: Valdis.Kletnieks@vt.edu
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH} 2.6 and grsecurity
Message-ID: <20040216184535.D16277@build.pdx.osdl.net>
References: <200402170134.i1H1YIAW016949@turing-police.cc.vt.edu> <20040216181546.A22989@build.pdx.osdl.net> <200402170237.i1H2bb3r008280@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200402170237.i1H2bb3r008280@turing-police.cc.vt.edu>; from Valdis.Kletnieks@vt.edu on Mon, Feb 16, 2004 at 09:37:36PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Valdis.Kletnieks@vt.edu (Valdis.Kletnieks@vt.edu) wrote:
> OK.. I can do that easily enough - only reason I didn't was because that would
> force the inclusion of ip_randomid() and the corresponding call even when the
> feature wasn't selected, making it more intrusive (the 'else' clause is also the
> "when not configured at all" code - moving the whole if/then/else to another
> function was more intrusive, to my thinking..)

could be

	#ifndef CONFIG_RANDID
	#define ip_randomid(x)  (x)
	#else
	int ip_randomid(int id)
	{
		if(security_enable...)
			return random_one();
		return id;
	}
	#endif

or somesuch, you get the idea.

> > > + * 3. All advertising materials mentioning features or use of this softwar
> e
> > > + *    must display the following acknowledgement:
> > > + *    This product includes software developed by Niels Provos.
> > 
> > Advertsing clause...this is not GPL compatible.
> 
> Thanks for spotting that.  It's the same way in grsecurity's patch - do they
> have an issue as well?  Or they OK because they're only doing a separately
> distributed patch?

I suspect yes, but, of course, IANAL ;-)

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
