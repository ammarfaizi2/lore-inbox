Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129495AbRCZWUJ>; Mon, 26 Mar 2001 17:20:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129506AbRCZWUA>; Mon, 26 Mar 2001 17:20:00 -0500
Received: from snark.tuxedo.org ([207.106.50.26]:12809 "EHLO snark.thyrsus.com")
	by vger.kernel.org with ESMTP id <S129495AbRCZWTl>;
	Mon, 26 Mar 2001 17:19:41 -0500
Date: Mon, 26 Mar 2001 17:22:09 -0500
From: "Eric S. Raymond" <esr@thyrsus.com>
To: Philip Blundell <philb@gnu.org>
Cc: "Eric S. Raymond" <esr@snark.thyrsus.com>, torvalds@transmeta.com,
        alan@lxorguk.ukuu.org.uk, trini@kernel.crashing.org,
        linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
Subject: Re: CML1 cleanup patch, take 3
Message-ID: <20010326172209.A21538@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	Philip Blundell <philb@gnu.org>,
	"Eric S. Raymond" <esr@snark.thyrsus.com>, torvalds@transmeta.com,
	alan@lxorguk.ukuu.org.uk, trini@kernel.crashing.org,
	linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
In-Reply-To: <200103261924.f2QJOwL19694@snark.thyrsus.com> <esr@snark.thyrsus.com> <E14hf0s-0001Cg-00@kings-cross.london.uk.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E14hf0s-0001Cg-00@kings-cross.london.uk.eu.org>; from philb@gnu.org on Mon, Mar 26, 2001 at 10:58:57PM +0100
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Philip Blundell <philb@gnu.org>:
> >    if [ "$CONFIG_PRINTER" != "n" ]; then
> >-      bool '    Support IEEE1284 status readback' CONFIG_PRINTER_READBACK
> >+      bool '    Support IEEE1284 status readback' CONFIG_PARPORT_1284
> >    fi
> 
> This isn't really right.  Although it's true that
> CONFIG_PARPORT_1284 enables the stuff that used to be controlled by
> CONFIG_PRINTER_READBACK, the two aren't synonymous.  The m68k port
> ought to just use drivers/parport/Config.in like everybody else.

Yes, I figured this out.  The CML2 rules file section for m68k already uses
the normal, architecture-independent parallel-port subtree (some of the
individual options in it are suppressed on certain platforms).

At this point, the only place CONFIG_PRINTER_READBACK actually occurs
seems to be in doc files.  So selecting it is a no-op, but one that
obviously means the user wanted the IEEE1284 support.  Even given the
two aren't equivalent, I don't see a better way to handle this than the
above.  Let's be kind to our 2.4.x users.

-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

The right of self-defense is the first law of nature: in most
governments it has been the study of rulers to confine this right
within the narrowest limits possible.  Wherever standing armies
are kept up, and when the right of the people to keep and bear
arms is, under any color or pretext whatsoever, prohibited,
liberty, if not already annihilated, is on the brink of
destruction." 
	-- Henry St. George Tucker (in Blackstone's Commentaries)
