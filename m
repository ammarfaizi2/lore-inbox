Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314396AbSHIPet>; Fri, 9 Aug 2002 11:34:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314403AbSHIPet>; Fri, 9 Aug 2002 11:34:49 -0400
Received: from ns.suse.de ([213.95.15.193]:55310 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S314396AbSHIPes>;
	Fri, 9 Aug 2002 11:34:48 -0400
To: Greg Banks <gnb@alphalink.com.au>
Cc: Peter Samuelson <peter@cadcamlab.org>,
       Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
       linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
Subject: Re: [kbuild-devel] [patch] config language dep_* enhancements
References: <20020808151432.GD380@cadcamlab.org>
	<Pine.LNX.4.44.0208081142390.23063-100000@chaos.physics.uiowa.edu>
	<20020808164742.GA5780@cadcamlab.org>
	<20020809041543.GA4818@cadcamlab.org>
	<3D53D50D.7FA48644@alphalink.com.au>
X-Yow: Yes, but will I see the EASTER BUNNY in skintight leather
 at an IRON MAIDEN concert?
From: Andreas Schwab <schwab@suse.de>
Date: Fri, 09 Aug 2002 17:38:30 +0200
In-Reply-To: <3D53D50D.7FA48644@alphalink.com.au> (Greg Banks's message of
 "Sat, 10 Aug 2002 00:43:25 +1000")
Message-ID: <jey9bg2gax.fsf@sykes.suse.de>
User-Agent: Gnus/5.090007 (Oort Gnus v0.07) Emacs/21.3.50 (ia64-suse-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg Banks <gnb@alphalink.com.au> writes:

|> > --- 2.4.20pre1/scripts/Configure        2001-07-02 15:56:40.000000000 -0500
|> > +++ 2.4.20pre1p/scripts/Configure       2002-08-08 22:31:49.000000000 -0500
|> > @@ -232,6 +241,28 @@
|> >  }
|> > 
|> >  #
|> > +# dep_calc reduces a dependency line down to a single char [ymn]
|> > +#
|> > +function dep_calc () {
|> > +       local neg arg
|> > +       cur_dep=y       # return value
|> > +       for arg; do
|> > +         neg=;
|> > +         case "$arg" in
|> > +           !*) neg=N; arg=${arg#?} ;;
|> > +         esac
|> > +         case "$arg" in
|> > +           y|m|n) ;;
|> > +           *) arg=$(eval echo \$$arg) ;;
|> 
|> Don't you want to check at this point that arg starts with CONFIG_?
|> Also, how about quoting \$$arg  ?

The Right Way to write that is like this, assuming that $arg has already
been verified to be a valid identifier:

          eval arg=\$$arg

No need for further quoting.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux AG, Deutschherrnstr. 15-19, D-90429 Nürnberg
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
