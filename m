Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136094AbRECEen>; Thu, 3 May 2001 00:34:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136107AbRECEed>; Thu, 3 May 2001 00:34:33 -0400
Received: from alpo.casc.com ([152.148.10.6]:16599 "EHLO alpo.casc.com")
	by vger.kernel.org with ESMTP id <S136094AbRECEe3>;
	Thu, 3 May 2001 00:34:29 -0400
From: John Stoffel <stoffel@casc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15088.27159.630786.913424@gargle.gargle.HOWL>
Date: Wed, 2 May 2001 16:12:07 -0400
To: esr@thyrsus.com
Cc: cate@dplanet.ch, Peter Samuelson <peter@cadcamlab.org>,
        CML2 <linux-kernel@vger.kernel.org>,
        kbuild-devel@lists.sourceforge.net
Subject: Re: Requirement of make oldconfig [was: Re: [kbuild-devel] Re: CML2 1.3.1, aka ...]
In-Reply-To: <20010502134955.A19257@thyrsus.com>
In-Reply-To: <20010427193501.A9805@thyrsus.com>
	<15084.12152.956561.490805@gargle.gargle.HOWL>
	<20010429183526.B32748@thyrsus.com>
	<15085.37569.205459.898540@gargle.gargle.HOWL>
	<20010430133932.B28849@thyrsus.com>
	<20010430141623.A15821@cadcamlab.org>
	<200 <3AF00C53.5EEE8E01@math.ethz.ch>
	<20010502134955.A19257@thyrsus.com>
X-Mailer: VM 6.90 under Emacs 20.6.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Eric> Giacomo Catenazzi <cate@math.ethz.ch>:

>> No. You propmt only one invalid assertion.  After you this prompt
>> you continue to validate rules and you will maybe prompt for another
>> invalid rules. But these invalid rules are generally infrequent.

Eric> I may be having problems with your English.  I don't think I
Eric> understand this.

He's saying that when you find the first invalid assertion, such as
not having CONFIG_RTC defined, when reading the .config file, you
should prompt for a fix.  Then once the input is taken, continue your
checks, prompting for each following problem as needed. 
 
>> It is very unlikely to have constraint on string or on integer.  But
>> anyway, where is the problem?  You simple ask the new value of this
>> symbol.

Eric> The problem is that you're now, in effect, telling me to invent
Eric> a new interactive configurator with different rules than the
Eric> normal one!

Eric> This is a horrible swamp to wander into just to avoid making oldconfig
Eric> users fire up vi occasionally.

No, we're just asking you to make the CML2 parser more tolerant of old
and possibly broken configs.

I haven't looked at the parser in any detail, but I assume that there
are heirarchal configuration settings.  When there is a mis-match,
where a sub-option conflicts with an upper option, how hard would it
be to print a warning, and just reset the sub-option to an acceptable
state?

Going back to the original CONFIG_RTC bug report I filed, all I had to
do was fire up vi and edit the .config file to turn on CONFIG_RTC,
which I think is completely bogus.

CML2 should be able to say "Hey, you need RTC turned on since you've
got SMP on, but it's not.  Should I do this for you?  Yes/No"

For trully broken .configs, maybe it makes sense to just give up and
say "Hey!  This .config is totally bogus, can I just ignore it and
have you redo your config in a sane manner?"

Make the computer do the work, not the user.

John
