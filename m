Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263903AbTLXVU0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Dec 2003 16:20:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263904AbTLXVU0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Dec 2003 16:20:26 -0500
Received: from fed1mtao01.cox.net ([68.6.19.244]:1745 "EHLO fed1mtao01.cox.net")
	by vger.kernel.org with ESMTP id S263903AbTLXVUY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Dec 2003 16:20:24 -0500
Date: Wed, 24 Dec 2003 14:20:22 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Meelis Roos <mroos@linux.ee>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PPC & 2.6.0-test3: wrong mem size & hang on ifconfig
Message-ID: <20031224212022.GN4023@stop.crashing.org>
References: <20031210161142.GE23731@stop.crashing.org> <Pine.GSO.4.44.0312111357130.24419-100000@math.ut.ee>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.44.0312111357130.24419-100000@math.ut.ee>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 11, 2003 at 03:51:34PM +0200, Meelis Roos wrote:
> > ===== arch/ppc/boot/prep/misc.c 1.14 vs edited =====
> > --- 1.14/arch/ppc/boot/prep/misc.c	Mon Oct 20 11:49:35 2003
> > +++ edited/arch/ppc/boot/prep/misc.c	Wed Dec 10 09:11:05 2003
> > @@ -251,15 +251,21 @@
> >  		{
> >  			phandle dev_handle;
> >  			int mem_info[2];
> > +			int n;
> > +			puts("Trying OF\n");
> >
> >  			/* get handle to memory description */
> >  			if (!(dev_handle = finddevice("/memory@0")))
> >  				break;
> > +			puts("Found /memory@0\n");
> >
> >  			/* get the info */
> >  			if (getprop(dev_handle, "reg", mem_info,
> > -						sizeof(mem_info) != 8))
> > +						sizeof(mem_info) != 8)) {
> > +				puts("n = 0x");puthex(n);puts("\n");
> >  				break;
> > +			}
> > +			puts("Found reg prop\n");
> 
> Are you sure that n really gets a value?
> 
> It prints
> Found /memory@0
> n = 0x00000000
> 
> and nothinf about reg prop as the code tells. What do you actually mean
> by n?

Sorry for such a late reply.  What I ment to do in there was:
	if ((n = getprop(dev_handle, "reg", mem_info, sizeof(mem_info))
	!= 8) {
		puts("n = 0x";puthex(n);puts("\n");
		break;
	}

-- 
Tom Rini
http://gate.crashing.org/~trini/
