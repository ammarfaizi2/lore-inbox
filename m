Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136618AbRECOeQ>; Thu, 3 May 2001 10:34:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136620AbRECOeH>; Thu, 3 May 2001 10:34:07 -0400
Received: from 205-CORU-X5.libre.retevision.es ([62.83.56.205]:9896 "HELO
	trasno.mitica") by vger.kernel.org with SMTP id <S136618AbRECOd7>;
	Thu, 3 May 2001 10:33:59 -0400
To: esr@thyrsus.com
Cc: Urban Widmark <urban@teststation.com>, John Stoffel <stoffel@casc.com>,
        cate@dplanet.ch, Peter Samuelson <peter@cadcamlab.org>,
        CML2 <linux-kernel@vger.kernel.org>,
        kbuild-devel@lists.sourceforge.net
Subject: Re: Hierarchy doesn't solve the problem
In-Reply-To: <20010503030431.A25141@thyrsus.com>
	<Pine.LNX.4.30.0105030907470.28400-100000@cola.teststation.com>
	<20010503034620.A27880@thyrsus.com>
X-Url: http://www.lfcia.org/~quintela
From: Juan Quintela <quintela@mandrakesoft.com>
In-Reply-To: <20010503034620.A27880@thyrsus.com>
Date: 03 May 2001 16:33:33 +0200
Message-ID: <m2bspa7b9e.fsf@trasno.mitica>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "eric" == Eric S Raymond <esr@thyrsus.com> writes:

eric> Urban Widmark <urban@teststation.com>:
>> Then it must somehow handle me trying to (incorrectly) answer X86=Y,
>> SMP=Y, RTC=N in some order?

eric> What it does is (a) always start with a valid config, and (b) not permit
eric> any change that would make it invalid.

eric> So, you froze X86 at startup.  SMP gets asked early.  If you specify 
eric> SMP=y, and then later try to set RTC=n, the configurator will not let
eric> you do it and will explain why.  At that point if you want you can go
eric> back and change SMP.
 
>> Perhaps I have missed something, but I really prefer the old oldconfig
>> over the new oldconfig.

eric> What's to prefer?  You get essentially the same behavior unless you start
eric> with a broken config.

Here is what I prefer (and need).

There are two cases that I need to solve, and that actually this are
the two uses that I had for make oldconfig (I never use xconfig nor
menuconfig).

1st scenary:

I have the .config of linux-2.4.x
Linus release linux-2.4.(x+1)

linux 2.4.(x+1) has more drivers/options/whatever that linux-2.4.x.  I
want to be prompted only for the new drivers/options/whatever it
chooses the old ones from the .config file.  Note that my old .config
file is not a valid configuration because it misses symbols (or I am
wrong and this is a valid configuration ?).

2nd scenery:

I have found a bug in my actual kernel and then I decided to turn some
feature off.  I don't want to surf over all the menus in make
{menu,x}config, because I _know_ the name of the feature.  I go to the
.config file and remove the needed line.  I can remove a line that
has no dependencies, or a line that has a lot of dependencies
(i.e. CONFIG_SCSI).  The actual menuconfig will do exactly what I
expect, it will ask only CONFIG_SCSI, and nothing else.

Notice that I am putting the .config in an invalid state, but it is
the easier way to change that feature.  Otherwise I will be happy if
you provide me something like:

    make "CONFIG_SCSI=n" oldconfig

or similar, i.e. _I_ know what I want to change, and I want to change
only that.  Notice that I want also be able to do the other way
around:

    make "CONFIG_SCSI=m" oldconfig

and then be prompted for all the SCSI drivers (because they was not in
the .config before).

Later, Juan.

-- 
In theory, practice and theory are the same, but in practice they 
are different -- Larry McVoy
