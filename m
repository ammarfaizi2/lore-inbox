Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317714AbSHHRdz>; Thu, 8 Aug 2002 13:33:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317712AbSHHRdw>; Thu, 8 Aug 2002 13:33:52 -0400
Received: from surf.cadcamlab.org ([156.26.20.182]:35459 "EHLO
	surf.cadcamlab.org") by vger.kernel.org with ESMTP
	id <S317696AbSHHRcy>; Thu, 8 Aug 2002 13:32:54 -0400
Date: Thu, 8 Aug 2002 11:47:42 -0500
To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Cc: linux-kernel@vger.kernel.org, linux-kbuild@lists.sourceforge.net
Subject: Re: 64bit clean drivers was Re: Linux 2.4.20-pre1
Message-ID: <20020808164742.GA5780@cadcamlab.org>
References: <20020808151432.GD380@cadcamlab.org> <Pine.LNX.4.44.0208081142390.23063-100000@chaos.physics.uiowa.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0208081142390.23063-100000@chaos.physics.uiowa.edu>
User-Agent: Mutt/1.4i
From: Peter Samuelson <peter@cadcamlab.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[Kai Germaschewski]
> As you're hacking Configure anyway, what about "fixing"
> 
> 	dep_tristate ' ..' CONFIG_FOO $CONFIG_BAR,

I've thought about that many times.  I think the cleanest solution is
to deprecate the '$' entirely:

	dep_tristate ' ..' CONFIG_FOO CONFIG_BAR

and, while we're at it, deprecate the 'dep_' prefix as well - can't
"tristate" and "bool" unambiguously handle this?

I think the above can be done quite easily with a bit of 'eval' work
(which *will* slow down 'make *config' ... but do we care?)
Supporting the old syntax simultaneously should not be hard either.
I'm just not sure whether or not it's appropriate for 2.4.20.  It *is*
easily testable stuff, but....

And I haven't looked at xconfig.  (I don't usually even run X.)
xconfig *does* do static parsing, and is thus superior to Configure
and Menuconfig, but the whole method of "translate Config.in into TCL
then execute it" makes it (imo) really hard to hack on.

Let me see if I can find time to roll a patch sometime today..

Peter
