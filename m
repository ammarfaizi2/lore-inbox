Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289030AbSANUgm>; Mon, 14 Jan 2002 15:36:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289012AbSANUfR>; Mon, 14 Jan 2002 15:35:17 -0500
Received: from dsl254-112-233.nyc1.dsl.speakeasy.net ([216.254.112.233]:36486
	"EHLO snark.thyrsus.com") by vger.kernel.org with ESMTP
	id <S289026AbSANUe4>; Mon, 14 Jan 2002 15:34:56 -0500
Date: Mon, 14 Jan 2002 15:17:48 -0500
From: "Eric S. Raymond" <esr@thyrsus.com>
To: Alexander Viro <viro@math.psu.edu>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        "Mr. James W. Laferriere" <babydr@baby-dragons.com>,
        Giacomo Catenazzi <cate@debian.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: Hardwired drivers are going away?
Message-ID: <20020114151748.B19776@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	Alexander Viro <viro@math.psu.edu>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	"Mr. James W. Laferriere" <babydr@baby-dragons.com>,
	Giacomo Catenazzi <cate@debian.org>,
	Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <20020114131050.E14747@thyrsus.com> <Pine.GSO.4.21.0201141337580.224-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.4.21.0201141337580.224-100000@weyl.math.psu.edu>; from viro@math.psu.edu on Mon, Jan 14, 2002 at 02:09:16PM -0500
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro <viro@math.psu.edu>:
> But it still leaves you with tristate - instead of yes/module/no it's
> yes/yes, but don't put it on initramfs/no.  However, dependencies become
> simpler - all you need is "I want this, that and that on initramfs" and
> the rest can be found by depmod (i.e. configurator doesn't have to deal
> with "FOO goes on initramfs (== old Y), so BAR and BAZ must go there
> (== can't be M)").

Actually I think we may no longer be in tristate-land.  Instead, some
devices have the property "This belongs in initramfs if it's configured
at all" -- specifically, drivers for potential boot devices.  Everything
else can dynamic-load after boot time.  

In CML2 you can assign a symbol properties, which are written into
trailing comments in the config file on the same line as the symbol
value assignment.  One such property, "PRIVATE", is already
interpreted by the postprocessor that generates autoconf.h from the
configuration output; it prevents the symbol from being written to
autoconf.h.

The critical-for-boot property could be interpreted by the same
postprocessor script and turned into a manifest for initramfs.  There
would be no need for the inference engine or configurator to know
about this property at all, just as it doesn't need to know anything
about PRIVATE.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

"To disarm the people... was the best and most effectual way to enslave them."
        -- George Mason, speech of June 14, 1788
