Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313204AbSDDOKt>; Thu, 4 Apr 2002 09:10:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313183AbSDDOKj>; Thu, 4 Apr 2002 09:10:39 -0500
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:32645
	"EHLO opus.bloom.county") by vger.kernel.org with ESMTP
	id <S313182AbSDDOKZ>; Thu, 4 Apr 2002 09:10:25 -0500
Date: Thu, 4 Apr 2002 07:10:35 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86 Boot enhancements, boot protocol 2.04 7/9
Message-ID: <20020404141035.GB7211@opus.bloom.county>
In-Reply-To: <m1ofh0spik.fsf@frodo.biederman.org> <20020403191538.GA7211@opus.bloom.county> <m13cycrvsh.fsf@frodo.biederman.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 03, 2002 at 08:23:58PM -0700, Eric W. Biederman wrote:
> Tom Rini <trini@kernel.crashing.org> writes:
> 
> > On Wed, Apr 03, 2002 at 09:41:55AM -0700, Eric W. Biederman wrote:
> > 
> > > In imitation of the arm and ppc ports a CONFIG_CMDLINE option is also
> > > implemented.
> > 
> > Just wondering, why didn't you do it with a
> > CONFIG_CMDLINE_BOOL/CONFIG_CMDLINE set of options?  The way you did it,
> > I _think_ you can't actually get a help msg from 'config' or
> > 'oldconfig', you'll just set the commandline to '?'.
> 
> I just tested it and oldconfig at least works.

That's sort of supprising.

> > Also, on current PPC, if we have a compiled-in commandline we put it in
> > arch/ppc/kernel/setup.c and allow it to be overridden.  This even makes
> > it semi-useful outside of the self-containted {b,}zImage situation.
> 
> I currently allow a compiled in command line to be appended to.  lilo
> also does this when you specify a command line, and to my knowledge all
> boot options prefer the last value specified so that should be good
> enough.  As the decision happens in C code it isn't to hard to change
> either way.

The way you're doing it now, you're sticking it into final image itself
tho, and passing it along.  If you're not going to be able to change the
commandline, why not handle it all in C? eg:
strcpy(cmd_line, CONFIG_CMDLINE);
if ( passed a new commandline )
   strcpy(cmd_line, new_cmdline);

Tho I have to admit I'm not sure where x86 ends up passing the
commandline in now..

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
