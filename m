Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133120AbRDLMLJ>; Thu, 12 Apr 2001 08:11:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133113AbRDLMK7>; Thu, 12 Apr 2001 08:10:59 -0400
Received: from p108.usslc13.stsn.com ([208.32.226.108]:62225 "EHLO
	hoteldns02.stsn.com") by vger.kernel.org with ESMTP
	id <S135172AbRDLMKn>; Thu, 12 Apr 2001 08:10:43 -0400
Date: Wed, 11 Apr 2001 22:06:46 -0400
From: esr@thyrsus.com
To: jeff millar <jeff@wa1hco.mv.com>
Cc: esr@snark.thyrsus.com, linux-kernel@vger.kernel.org,
        kbuild-devel@lists.sourceforge.net
Subject: Re: CML2 1.0.0 doesn't remember configuration changes
Message-ID: <20010411220646.A12550@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: esr@thyrsus.com, jeff millar <jeff@wa1hco.mv.com>,
	esr@snark.thyrsus.com, linux-kernel@vger.kernel.org,
	kbuild-devel@lists.sourceforge.net
In-Reply-To: <20010411191940.A9081@thyrsus.com> <E14nU6n-0007po-00@the-village.bc.nu> <20010411204523.C9081@thyrsus.com> <002701c0c2f1$fc672960$0201a8c0@home> <20010411225055.A11009@thyrsus.com> <003c01c0c312$73713300$0201a8c0@home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <003c01c0c312$73713300$0201a8c0@home>; from jeff@wa1hco.mv.com on Thu, Apr 12, 2001 at 01:35:55AM -0400
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jeff millar <jeff@wa1hco.mv.com>:
> From what's in the various documentation and reading about 1% of the cml2
> traffic...  cml2's  various "make *config" invocations use config.out as a
> database for remembering configuration, and then on exit they all generate a
> fresh copy of .config.

Actually CML2's behavior is a bit more orthogonal than that.  It normally
reads nothing and writes to config.out.  You can give it -i and -I options
telling it to read in files at startup, or a -o option to issue output to
a different filename. 

Now here's where it gets a little tricky.  The config.out format is different
from a CML1 .config in that it sores FOO=n settings explicitly, rather than in
the form of "# FOO is not set" comments.  The reason for this is so we can pass
around partial configurations (a particular set of APM options, say) with 
explicit no values in them.  

Eventually (like, when Keith's Makefile stuff goes in) the CML1
.config format will go away.  In the meantime, after each configurator
run, a shim script called "configtrans.py" takes the config.out and
generates both .config and include/kernel/autoconf.h from it.

>     Apparently it's too hard to read the existing
> .config to generate an initial config.out, 

Actually it's easy.  I can feed .configs to cmlconfigure with a -i option and
they'll be read in just fine.  

>                                      so I think "make *config" the
> first time, starts with some default and then on exit _should_ write that to
> config.out.  Then any other invocationn of *make *config". needs to use
> config.out.  "make xconfig", "make config" and "make editconfig" need to
> operate the same way.  I've never use anything but "make xconfig",  "make
> menuconfig" and "make oldconfig" and they currently all operate on the same
> information.  I've never used editconfig and don't know what it's for.

Editconfig was a mistake.  OK, I think I understand the rules now.  Is it:

(1) First, try to read from .config
(2) If .config doesn't exist, read from $(ARCH)/defconfig

?

> 1.0.3 feels faster, btw.

That's because it is.  I am continuing to tune.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

You need only reflect that one of the best ways to get yourself 
a reputation as a dangerous citizen these days is to go about 
repeating the very phrases which our founding fathers used in the 
great struggle for independence.
	-- Attributed to Charles Austin Beard (1874-1948)
