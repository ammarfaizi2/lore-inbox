Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132886AbRD2WlF>; Sun, 29 Apr 2001 18:41:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136399AbRD2Wk4>; Sun, 29 Apr 2001 18:40:56 -0400
Received: from snark.tuxedo.org ([207.106.50.26]:35592 "EHLO snark.thyrsus.com")
	by vger.kernel.org with ESMTP id <S132886AbRD2Wkk>;
	Sun, 29 Apr 2001 18:40:40 -0400
Date: Sun, 29 Apr 2001 18:41:25 -0400
From: "Eric S. Raymond" <esr@thyrsus.com>
To: John Stoffel <stoffel@casc.com>
Cc: CML2 <linux-kernel@vger.kernel.org>, kbuild-devel@lists.sourceforge.net
Subject: Re: CML2 1.3.1, aka "I stick my neck out a mile..."
Message-ID: <20010429184125.C32748@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	John Stoffel <stoffel@casc.com>,
	CML2 <linux-kernel@vger.kernel.org>,
	kbuild-devel@lists.sourceforge.net
In-Reply-To: <20010427193501.A9805@thyrsus.com> <15084.12830.973535.153706@gargle.gargle.HOWL>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <15084.12830.973535.153706@gargle.gargle.HOWL>; from stoffel@casc.com on Sun, Apr 29, 2001 at 11:24:14AM -0400
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Stoffel <stoffel@casc.com>:
> Before on startup it would give:
> 
>     [root@jfs linux]# make config
>     rm -f include/asm
>     ( cd include ; ln -sf asm-i386 asm)
>     python -O scripts/cmlconfigure.py -DX86 -B 2.4.4-pre7 -W -i config.out
>     rules.out
>     ISA=y (deduced from X86)
>     Side effects from config.out:
>     NETDEVICES=m (deduced from ATALK)
>     SOUND_OSS=m (deduced from SOUND_VIA82CXXX)
>     SOUND_OSS=y (deduced from SOUND_YMFPCI_LEGACY)
>     SOUND=y (deduced from SOUND_OSS)
>     python -O scripts/configtrans.py -h include/linux/autoconf.h -s
>     .config config.out
> 
> 
> So I poked around, found the RTC setting, read the help and now I
> understand why I should have had it enabled all along.  No problem.
> So saved my changes and exited.  
> 
> I then restarted, and it came up properly, but I'm now getting the
> following output:
> 
>     [root@jfs linux]# make config
>     rm -f include/asm
>     ( cd include ; ln -sf asm-i386 asm)
>     python -O scripts/cmlconfigure.py -DX86 -B 2.4.4-pre7 -W -i config.out
>     rules.out
>     ISA=y (deduced from X86)
> 
> 
> Notice that it's still setting the ISA=y flag, but not the rest it was
> complaining about.  I think it should have either updated this setting
> by default for the ISA bus, or warned on exit that it still needed to
> be set.
> 
> I think this is a true bug somewhere.

Nope, it's a benign side-effect of the order of evaluation of command-line
switches.  Here's what's happening:

1. X86=y is being set and frozen.
2. ISA=y is deduced from X86
3. config.out is read in.  

In step 3, you don't see any side effects from config.out because they
were calculated last time and wruitten into the saved configuration. 

You still see the ISA=y message because your config.out has not yet been
read in at the time that side effect is computed.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

"Among the many misdeeds of British rule in India, history will look
upon the Act depriving a whole nation of arms as the blackest."
        -- Mohandas Ghandhi, An Autobiography, pg 446
