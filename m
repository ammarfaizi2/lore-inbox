Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318246AbSHILoC>; Fri, 9 Aug 2002 07:44:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318248AbSHILoC>; Fri, 9 Aug 2002 07:44:02 -0400
Received: from surf.cadcamlab.org ([156.26.20.182]:56961 "EHLO
	surf.cadcamlab.org") by vger.kernel.org with ESMTP
	id <S318246AbSHILoB>; Fri, 9 Aug 2002 07:44:01 -0400
Date: Fri, 9 Aug 2002 06:47:41 -0500
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org,
       kbuild-devel@lists.sf.net
Subject: Re: 64bit clean drivers was Re: Linux 2.4.20-pre1
Message-ID: <20020809114741.GB4818@cadcamlab.org>
References: <20020808174227.GE380@cadcamlab.org> <Pine.LNX.4.44.0208091204360.28515-100000@serv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0208091204360.28515-100000@serv>
User-Agent: Mutt/1.4i
From: Peter Samuelson <peter@cadcamlab.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  [Peter Samuelson]
> > !y == n
> > !m == n
> > !n == y

[Roman Zippel]
> I would define !m as m, e.g. it would allow
> 
> dep_tristate "" CONFIG_OLD !$CONFIG_NEW
> dep_tristate "" CONFIG_NEW !$CONFIG_OLD

You know, that never even occurred to me.  Your scheme is not strictly
"logical", but it is much more practical, since it is perfect for
expressing a relatively common (and currently awkward) case.

I'm convinced.  Now we have
  !y == n
  !m == m	(significant for dep_tristate and dep_mbool)
  !n == n


BTW, does anyone have a problem with my proposal (for 2.5, not
necessarily 2.4) for '/dep_/s/ \$CONFIG/ CONFIG/g' ?  That is,

  -dep_tristate "" CONFIG_FOO_X CONFIG_FOO CONFIG_BAR !CONFIG_BAZ
  +dep_tristate "" CONFIG_FOO_X $CONFIG_FOO $CONFIG_BAR !$CONFIG_BAZ

Advantages:

- the config files are more readable, especially when using "!"

- can support the old syntax with no extra code

and most importantly

- resolves the parsing difficulty with detecting an undefined value
  in dep_* statements.  Currently the undefined value is documented as
  "ignored, but try to avoid the situation".

which leads to

- allows us to drop all those 'define_bool CONFIG_FOO n' statements
  whose main purpose was to avoid the empty value

Eh?  I posted a patch earlier; it was trivial, despite having a syntax
error in Configure (deleted a 'while...do', forgot the 'done') which
only proves that I don't test stuff very rigorously.  Menuconfig
actually shrunk, due to factoring.  If and when I get my head around
xconfig, we'll see how ugly this stuff does or doesn't get, but then
again, if xconfig were made uglier, would anyone notice?

Peter
