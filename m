Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318922AbSHMD2e>; Mon, 12 Aug 2002 23:28:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318923AbSHMD2e>; Mon, 12 Aug 2002 23:28:34 -0400
Received: from zok.SGI.COM ([204.94.215.101]:51612 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S318922AbSHMD2d>;
	Mon, 12 Aug 2002 23:28:33 -0400
Message-ID: <3D587DFC.76F2C778@alphalink.com.au>
Date: Tue, 13 Aug 2002 13:33:16 +1000
From: Greg Banks <gnb@alphalink.com.au>
Organization: Corpus Canem Pty Ltd.
X-Mailer: Mozilla 4.73 [en] (X11; I; Linux 2.2.15-4mdkfb i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Roman Zippel <zippel@linux-m68k.org.com>
CC: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
       Peter Samuelson <peter@cadcamlab.org>, linux-kernel@vger.kernel.org,
       kbuild-devel@lists.sourceforge.net
Subject: Re: [patch] config language dep_* enhancements
References: <Pine.LNX.4.44.0208121959360.8911-100000@serv>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roman Zippel wrote:
> 
> Most should be fixable. The biggest problem are recursive references like
> this:
> 
> if [ OLD != y ]; then
>   tristate NEW
> fi
> if [ NEW != y ]; then
>   tristate OLD
> fi
> 
> [...]It's possible to fix this:
> 
> tristate DRV
> if [ DRV == y ]; then
>   choice OLD NEW
> fi
> if [ DRV == m ]; then
>   dep_tristate NEW DRV
>   dep_tristate OLD DRV
> fi
> 
> That should look interesting in xconfig, 

It will also give gcml2 conniptions trying to figure out a set of constraints
which will enforce the intended behaviour.  Please please don't.

If there are any loops (and I don't know of any) then the logic is broken and
needs to be fixed, not enforced through clever tricks.

> This should work quite well with config and menuconfig and maybe someone
> fixes xconfig, so a lot can be fixed within cml1, but it won't be
> necessarily nice. :) I didn't make up this example, just look at
> CONFIG_SCSI_AIC7XXX* which would need fixing like this.

I will look, but I seem to remember that this code was just broken when
Keith Owens was trying to make it work in kbuild 2.5.

> The current config is really very limited and can not be easily extended
> (just try adding the help text or build information). At some point we
> have to drop cml1 and replace it with something else. 

<sigh>once more into the breach...

> This doesn't has be
> very painful, I have a tool that can convert most of the current config
> into whatever you want.

The problem is deciding what the original rules were supposed to mean, and
then reproducing that behaviour exactly in the new language.  The alternative
is fixing the problems as we convert, but then we end up with CML2 and the
"there's no way to verify the rulebase is the same" argument.

Greg.
-- 
the price of civilisation today is a courageous willingness to prevail,
with force, if necessary, against whatever vicious and uncomprehending
enemies try to strike it down.     - Roger Sandall, The Age, 28Sep2001.
