Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267217AbTBDKst>; Tue, 4 Feb 2003 05:48:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267224AbTBDKst>; Tue, 4 Feb 2003 05:48:49 -0500
Received: from mail.bmlv.gv.at ([193.171.152.37]:59276 "HELO mail.bmlv.gv.at")
	by vger.kernel.org with SMTP id <S267217AbTBDKss>;
	Tue, 4 Feb 2003 05:48:48 -0500
From: "Ph. Marek" <philipp.marek@bmlv.gv.at>
To: alexander.riesen@synopsys.COM
Subject: Re: [PATCHes available] printk() without KERN_ prefixes? (in 2.5.59) (again)
Date: Tue, 4 Feb 2003 11:58:20 +0100
User-Agent: KMail/1.5
References: <200302031656.h13Gu7lV029203@napali.hpl.hp.com> <200302040836.04151.philipp.marek@bmlv.gv.at> <20030204104017.GL5239@riesen-pc.gr05.synopsys.com>
In-Reply-To: <20030204104017.GL5239@riesen-pc.gr05.synopsys.com>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200302041158.20607.philipp.marek@bmlv.gv.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > 	#ifdef LITTLE_ENDIAN
> >                            (wptr[(((win + 1)*4)^4)/4] != 0)) {
> > 	#else
> >                            (wptr[win + 1] != 0)) {
> > 	#endif /* LITTLE_ENDIAN */
> > (the braces { and } don't add up in the file).
>
> they do, but your script doesn't use c preprocessor with right flags,
> which it probably should.
>
> The two braces above should be counted as one depending on LITTLE_ENDIAN
> defined.
# wc change_printk.pl
    141     268    2361 change_printk.pl
I don't use the preprocessor - after all, which -D should I give? all? none? a 
part? So my script just reads the files.

I know that my script could parse the #if's also - but that's a lot of work 
with little use.

How about that?

	#if defined(FORCE_ERRORS)
	        if (0) {
	#elif !DEBUG
	        if (kdebug) {
	#endif
	...
	#if !DEBUG || defined(FORCE_ERRORS)
	        }
	#endif
(seen in arch/ia64/sn/io/sn2/pcibr/pcibr_error.c: pcibr_pioerror() )

It's just too complex to look on the #if's and gives not enough advantages.


Regards,

Phil


