Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272817AbRI0Mvo>; Thu, 27 Sep 2001 08:51:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272818AbRI0Mvf>; Thu, 27 Sep 2001 08:51:35 -0400
Received: from ns.suse.de ([213.95.15.193]:51982 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S272817AbRI0MvX> convert rfc822-to-8bit;
	Thu, 27 Sep 2001 08:51:23 -0400
To: James Antill <james@and.org>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.10-pre11 -- __builtin_expect
In-Reply-To: <20010918031813.57E1062ABC@oscar.casa.dyndns.org.suse.lists.linux.kernel>
	<E15jBLy-0008UF-00@the-village.bc.nu.suse.lists.linux.kernel>
	<9o6j9l$461$1@cesium.transmeta.com.suse.lists.linux.kernel>
	<oup4rq0bwww.fsf_-_@pigdrop.muc.suse.de>
	<jeelp4rbtf.fsf@sykes.suse.de>
	<20010918143827.A16003@gruyere.muc.suse.de>
	<nn3d59qzho.fsf@code.and.org>
X-Yow: Do you need any MOUTH-TO-MOUTH resuscitation?
From: Andreas Schwab <schwab@suse.de>
Date: 27 Sep 2001 14:51:44 +0200
In-Reply-To: <nn3d59qzho.fsf@code.and.org> (James Antill's message of "26 Sep 2001 19:54:59 -0400")
Message-ID: <jezo7gu78f.fsf@sykes.suse.de>
User-Agent: Gnus/5.090003 (Oort Gnus v0.03) Emacs/21.0.107
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Antill <james@and.org> writes:

|> Andi Kleen <ak@suse.de> writes:
|> 
|> > Good point. I somehow assumed that __builtin_expect would just signify
|> > a boolean, but if I read gcc source correctly this was wrong.
|> 
|>  Yeh, it's a long so you'll get no cast warnings too.
|> 
|> > Here is an updated patch.
|> 
|> [snip ... ]
|> 
|> > --- include/linux/kernel.h-LIKELY	Tue Sep 18 11:12:20 2001
|> > +++ include/linux/kernel.h	Tue Sep 18 14:35:17 2001
|> > @@ -171,4 +171,14 @@
|> >  	char _f[20-2*sizeof(long)-sizeof(int)];	/* Padding: libc5 uses this.. */
|> >  };
|> >  
|> > +
|> > +/* This loses on a few early 2.96 snapshots, but hopefully nobody uses them anymore. */ 
|> > +#if __GNUC__ > 2 || (__GNUC__ == 2 && _GNUC_MINOR__ == 96)
|> > +#define likely(x)  __builtin_expect(!!(x), 1) 
|> > +#define unlikely(x)  __builtin_expect((x), 0) 
|> 
|>  unlikely() also needs to be...
|> 
|> #define unlikely(x)  __builtin_expect(!(x), 1) 
|> 
|> ...or...
|> 
|> #define unlikely(x)  __builtin_expect(!!(x), 0) 

This is not needed, since only 0 is the likely value and !! does not
change that.

Andreas.

-- 
Andreas Schwab                                  "And now for something
Andreas.Schwab@suse.de				completely different."
SuSE Labs, SuSE GmbH, Schanzäckerstr. 10, D-90443 Nürnberg
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
