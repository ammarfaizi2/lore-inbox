Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274012AbRI0Whl>; Thu, 27 Sep 2001 18:37:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274002AbRI0Whb>; Thu, 27 Sep 2001 18:37:31 -0400
Received: from [195.223.140.107] ([195.223.140.107]:34043 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S274001AbRI0WhZ>;
	Thu, 27 Sep 2001 18:37:25 -0400
Date: Fri, 28 Sep 2001 00:37:46 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Robert_Macaulay@Dell.com
Cc: riel@conectiva.com.br, ckulesa@as.arizona.edu,
        linux-kernel@vger.kernel.org, bmatthews@redhat.com,
        marcelo@conectiva.com.br, torvalds@transmeta.com
Subject: Re: highmem deadlock fix [was Re: VM in 2.4.10(+tweaks) vs. 2.4.9 -ac14/15(+stuff)]
Message-ID: <20010928003746.Q14277@athlon.random>
In-Reply-To: <8F120FA493CAD743B30EEB8F356985B501A7819D@AUSXMBT102VS1.amer.dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8F120FA493CAD743B30EEB8F356985B501A7819D@AUSXMBT102VS1.amer.dell.com>; from Robert_Macaulay@Dell.com on Thu, Sep 27, 2001 at 05:34:17PM -0500
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 27, 2001 at 05:34:17PM -0500, Robert_Macaulay@Dell.com wrote:
> 
> 
> > -----Original Message-----
> > From: Andrea Arcangeli [mailto:andrea@suse.de]
> > Sent: Thursday, September 27, 2001 5:13 PM
> > To: Macaulay, Robert
> > Cc: Rik van Riel; Craig Kulesa; linux-kernel@vger.kernel.org; Bob
> > Matthews; Marcelo Tosatti; Linus Torvalds
> > Subject: highmem deadlock fix [was Re: VM in 2.4.10(+tweaks) vs.
> > 2.4.9-ac14/15(+stuff)]
> > 
> > @@ -2519,7 +2521,9 @@
> >  	int tryagain = 1;
> >  
> >  	do {
> > -		if (buffer_dirty(p) || buffer_locked(p)) {
> > +		if (unlikely(buffer_pending_IO(p)))
> > +			tryagain = 0;
> > +		else if (buffer_dirty(p) || buffer_locked(p)) {
> >  			if (test_and_set_bit(BH_Wait_IO, &p->b_state)) {
> >  				if (buffer_dirty(p)) {
> >  					ll_rw_block(WRITE, 1, &p);
> > 
> 
> Im getting an undefined reference to the unlikely function in this patch.

ok, try adding #include <linux/compiler.h> to include/linux/kernel.h, I
prefer to have likely/unlikely always available.

Andrea
