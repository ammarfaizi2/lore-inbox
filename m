Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264986AbSKVCPb>; Thu, 21 Nov 2002 21:15:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264823AbSKVCPb>; Thu, 21 Nov 2002 21:15:31 -0500
Received: from TYO201.gate.nec.co.jp ([210.143.35.51]:55962 "EHLO
	TYO201.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id <S264986AbSKVCPa>; Thu, 21 Nov 2002 21:15:30 -0500
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Adrian Bunk <bunk@fs.tum.de>, linux-kernel@vger.kernel.org
Subject: Re: New kconfig: Please add define_*
References: <20021121133320.GD18869@fs.tum.de>
	<Pine.LNX.4.44.0211211740130.2113-100000@serv>
Reply-To: Miles Bader <miles@gnu.org>
System-Type: i686-pc-linux-gnu
Blat: Foop
From: Miles Bader <miles@lsi.nec.co.jp>
Date: 22 Nov 2002 11:22:13 +0900
In-Reply-To: <Pine.LNX.4.44.0211211740130.2113-100000@serv>
Message-ID: <buon0o2fine.fsf@mcspd15.ucom.lsi.nec.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roman Zippel <zippel@linux-m68k.org> writes:
> Also note that the role of the default has changed, a default cannot 
> override a prompt anymore (it only provides a default value to the 
> prompt). The define_* syntax might imply that this is possible, but it 
> won't.

I'd like to be able to override a prompt.

The reason is that in general it's nice for the arch-specific Kconfig
file to include various other Kconfig files (using `source'), but
sometimes an option that usually makes sense as user-definable -- and
thus has a prompt -- _doesn't_ make sense on that particular
architecture.

Currently it seems as if the arch-specific Kconfig can do several things
in this case:

  (1) Inline the more general Kconfig into the arch-specific Kconfig
      (with the offending option removed, and omit the `source').  This
      is undesirable for all the usual reasons (code duplication causes
      bit-rot etc).

  (2) Document somewhere that users shouldn't ever set option FOO, even
      though it asks the question.  This is confusing for users.

  (3) Add a dependency on ARCH_BLAH or something to the definition of
      FOO.  This is probably the cleanest solution, but tends to result in
      arch-specific knowledge being littered all over the place (though
      this is already a general problem with the config system).

It would nice if I could just say in my arch-specific Kconfig:

   option FOO
           bool
           set n

which would force FOO to `n' regardless of any later declarations.

-Miles
-- 
`Life is a boundless sea of bitterness'
