Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132330AbRCZG3v>; Mon, 26 Mar 2001 01:29:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132341AbRCZG3b>; Mon, 26 Mar 2001 01:29:31 -0500
Received: from snark.tuxedo.org ([207.106.50.26]:50949 "EHLO snark.thyrsus.com")
	by vger.kernel.org with ESMTP id <S132340AbRCZG3Z>;
	Mon, 26 Mar 2001 01:29:25 -0500
Date: Mon, 26 Mar 2001 01:32:28 -0500
From: "Eric S. Raymond" <esr@thyrsus.com>
To: Peter Samuelson <peter@cadcamlab.org>
Cc: "Eric S. Raymond" <esr@snark.thyrsus.com>, linux-kernel@vger.kernel.org,
        kbuild-devel@lists.sourceforge.net
Subject: Re: CML1 cleanup patch
Message-ID: <20010326013228.A11181@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	Peter Samuelson <peter@cadcamlab.org>,
	"Eric S. Raymond" <esr@snark.thyrsus.com>,
	linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
In-Reply-To: <200103260001.f2Q01Yt09387@snark.thyrsus.com> <15038.56527.591553.87791@wire.cadcamlab.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <15038.56527.591553.87791@wire.cadcamlab.org>; from peter@cadcamlab.org on Mon, Mar 26, 2001 at 12:08:15AM -0600
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Samuelson <peter@cadcamlab.org>:
> > CONFIG_8139TOO			CONFIG_RTL8139TOO
> > CONFIG_8139TOO_PIO		CONFIG_RTL8139TOO_PIO
> > CONFIG_8139TOO_TUNE_TWISTER	CONFIG_RTL8139TOO_TUNE_TWISTER
> 
> The -TOO suffix was to distinguish between this and the former 8139
> driver, as the two coexisted in 2.2 and 2.3.  As the old driver has
> been dropped from 2.4, I propose likewise dropping the -TOO.

I'm preparing an updated version of the patch for 2.4.3-pre8.  I'll
incorporate this change.
 
> Oh, BTW -- an alternate approach to making the kernel tree compatible
> with CML2 would be to make CML2 compatible with the kernel tree.
> Define a character (say '%') as an optional prefix for a configuration
> symbol.  This character would only be required where the symbol would
> otherwise by misparsed, as with '[0-9].*'.

I considered two workarounds:

1. Adding some cruft to the language to support this case, as you suggest.

I might have gone this route, until I tripped over the two bugs and
the bad config symbols in the CRIS port tree.  That meant there was
going to have to be a cleanup patch anyway, so why not fix those 20 
symbols (out of 1831) rather than grubbifying the language?

2. Hacking the CML2 lexical analyzer to handle this case.

I could have done this, allowing tokens to be recognized as numeric only
if all chars are digits.  I didn't, for two reasons: (1) Lexical analysis
is, as it turns out, a hotspot in the CML2 compiler code -- the last thing
it needs is more overhead, and (2) interpreting symbols with leading digits
as nonnumeric tokens is just *wrong*.  Ugh.  Violates the Principle of Least
Surprise big-time.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

Every election is a sort of advance auction sale of stolen goods. 
	-- H.L. Mencken 
