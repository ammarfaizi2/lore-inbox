Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284289AbRL1XPI>; Fri, 28 Dec 2001 18:15:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284285AbRL1XPA>; Fri, 28 Dec 2001 18:15:00 -0500
Received: from dsl254-112-233.nyc1.dsl.speakeasy.net ([216.254.112.233]:55003
	"EHLO snark.thyrsus.com") by vger.kernel.org with ESMTP
	id <S284335AbRL1XOn>; Fri, 28 Dec 2001 18:14:43 -0500
Date: Fri, 28 Dec 2001 17:58:32 -0500
From: "Eric S. Raymond" <esr@thyrsus.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Legacy Fishtank <garzik@havoc.gtf.org>, Dave Jones <davej@suse.de>,
        "Eric S. Raymond" <esr@snark.thyrsus.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
Subject: Re: [kbuild-devel] Re: State of the new config & build system
Message-ID: <20011228175832.C20254@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	Linus Torvalds <torvalds@transmeta.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Legacy Fishtank <garzik@havoc.gtf.org>, Dave Jones <davej@suse.de>,
	"Eric S. Raymond" <esr@snark.thyrsus.com>,
	Marcelo Tosatti <marcelo@conectiva.com.br>,
	linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
In-Reply-To: <20011228170840.A20254@thyrsus.com> <Pine.LNX.4.33.0112281429010.23445-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0112281429010.23445-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Fri, Dec 28, 2001 at 02:29:44PM -0800
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@transmeta.com>:
> Eric, this is the _wrong_approach_. I want /local/ files, not global ones.

I hear you.  There are some problems with that, however.

First: where should the prompt-string definitions for capability
symbols that occur in multiple port trees live?

(This is an important question. Right now, most options are low-level
and platform-specific, which makes it easy to decide what directory
their symbol declaration(s) should live in.  But that's not good;
there are lots of excellent reasons we want there to be *more*
cross-platform capability symbols rather than fewer.  So the
percentage of "roving" symbols without an obvious home is likely
to go up over time.)

Second: Forward references, and references across the tree, mean that
there is a class of symbols that have theoretically natural home directories
but which would have to be declared elsewhere in order to be defined at
the point of first reference.

(A potential solution to this would be to improve the CML2 compiler's
handling of forward references.)

Third: I could hack my installer to break Configure.help up into
a bunch of little component CML files distributed through the tree...
but Configure.help doesn't currently contain any markup that says
where to direct each entry to.

(The logical time to split up symbols.cml would be immediately after
CML2 goes into the tree, because at that point Configure.help won't
be an issue any more.)

Fourth: There's still the localization issue.  If it's your ukase 
that this is not an important problem, then I'll accept that -- but
I haven't heard you say that yet, so I'm not sure you've considered 
it enough.

So, I can and will put this in the transition plan if that's what you 
direct.  But you need to be aware that it's not a snap-of-the-fingers
change, and not something best done before CML1 goes away.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

"As to the species of exercise, I advise the gun. While this gives [only]
moderate exercise to the body, it gives boldness, enterprise, and independence
to the mind.  Games played with the ball and others of that nature, are too
violent for the body and stamp no character on the mind. Let your gun,
therefore, be the constant companion to your walks."
        -- Thomas Jefferson, writing to his teenaged nephew.
