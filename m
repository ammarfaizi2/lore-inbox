Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261875AbULGSVE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261875AbULGSVE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Dec 2004 13:21:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261877AbULGSVD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Dec 2004 13:21:03 -0500
Received: from hirsch.in-berlin.de ([192.109.42.6]:39808 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S261875AbULGSU0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Dec 2004 13:20:26 -0500
X-Envelope-From: kraxel@bytesex.org
To: Eyal Lebedinsky <eyal@eyal.emu.id.au>,
       Michael Hunold <hunold@convergence.de>, Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.10-rc3 oops when 'modprobe -r dvb-bt8xx'
References: <Pine.LNX.4.58.0412031611460.22796@ppc970.osdl.org>
	<41B1BD24.4050603@eyal.emu.id.au>
From: Gerd Knorr <kraxel@bytesex.org>
Organization: SUSE Labs, Berlin
Date: 07 Dec 2004 19:03:57 +0100
In-Reply-To: <41B1BD24.4050603@eyal.emu.id.au>
Message-ID: <87653ex9wy.fsf@bytesex.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eyal Lebedinsky <eyal@eyal.emu.id.au> writes:

> Linus Torvalds wrote:
> > Please do test this - and don't send me anything but bug-fixes. Let's aim
> > for a real 2.6.10 before xmas (or hanukkah, or whatever your favourite
> > holiday happens to be).
> 
> In the spirit of festive testing I would like to say that the oops that I
> enjoyed throughout rc2-bk* is still present in -rc3. -mm series does not
> have this problem.

Oh joy.  I think thats a different one.  And I suspect there are a few
more of that kind which simply didn't show up yet because the user
base is too small.  The current way of doing the initialization of the
frontend devices (in Linus' tree) is simply a big mess and you may get
all sorts of strange effects depending on the order you load or unload
the modules if one of the parties involved doesn't get it right.

> 	modprobe -r dvb-bt8xx

>   [<f90e2634>] mt352_detach_client+0x52/0x54 [mt352]

What happens if you "rmmod mt352" first?  Guess it works without
oopsing then?

I somehow feel the best way to deal with that is to merge the
redesigned frontend handing pending in -mm at the moment into Linus
tree _now_, that should kill that whole class of bugs.

That may result in the dvb subsystem not being that stable in 2.6.10.
But dvb not being rock solid in 2.6.10 will very likely happen anyway
as the code currently in Linus' tree isn't very stable as well.  I
think the chance that it gets even worse is small enougth that we can
take the risk.

Additional bonus would be that we don't get bugreports for the old
code base which is already obsolete (and nobody wants to work on
because of that).

Michael?

  Gerd

-- 
#define printk(args...) fprintf(stderr, ## args)
