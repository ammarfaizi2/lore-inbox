Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276708AbRJVPej>; Mon, 22 Oct 2001 11:34:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277029AbRJVPea>; Mon, 22 Oct 2001 11:34:30 -0400
Received: from cs6625129-123.austin.rr.com ([66.25.129.123]:31236 "HELO
	dragon.taral.net") by vger.kernel.org with SMTP id <S276708AbRJVPeQ>;
	Mon, 22 Oct 2001 11:34:16 -0400
Date: Mon, 22 Oct 2001 10:36:57 -0500
From: Taral <taral@taral.net>
To: Robert Love <rml@tech9.net>
Cc: Andrew Morton <akpm@zip.com.au>, Colin Phipps <cph@cph.demon.co.uk>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] updated preempt-kernel
Message-ID: <20011022103657.B24814@taral.net>
In-Reply-To: <1003562833.862.65.camel@phantasy>, <1003562833.862.65.camel@phantasy> <20011021120539.A1197@cph.demon.co.uk> <3BD2E89C.78D757A2@zip.com.au> <1003688179.1085.17.camel@phantasy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 21, 2001 at 02:16:18PM -0400, Robert Love wrote:
> Colin, can you try Andrew's patch and report back?  This problem has
> been reported before -- its a tty bug that preempt (and SMP I wager)
> just aggravate.  I have a patch that I know fixes it, but Andrew's is
> _much_ simpler.  I will send you that if this fails.  Please let me
> know.

This also looks a bit wrong:
> > +	if (vt) {
> > +		/*
> > +		 * If we raced with con_close(), `vt' may be null.
> > +		 * Hence this bandaid.   - akpm
> > +		 */
> > +		acquire_console_sem();
> > +		set_cursor(vt->vc_num);
> > +		release_console_sem();
> > +	}

Maybe should be:

acquire_console_sem();
if (vt) set_cursor(vt->vc_num);
release_console_sem();

??

-- 
Taral <taral@taral.net>
This message is digitally signed. Please PGP encrypt mail to me.
"Any technology, no matter how primitive, is magic to those who don't
understand it." -- Florence Ambrose
