Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261353AbTBCUJI>; Mon, 3 Feb 2003 15:09:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264936AbTBCUHF>; Mon, 3 Feb 2003 15:07:05 -0500
Received: from phobos.hpl.hp.com ([192.6.19.124]:36833 "EHLO phobos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S267027AbTBCTyp>;
	Mon, 3 Feb 2003 14:54:45 -0500
Date: Mon, 3 Feb 2003 11:49:23 -0800
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org, discuss@x86-64.org,
       jt@hpl.hp.com
Subject: Re: two x86_64 fixes for 2.4.21-pre3
Message-ID: <20030203194923.GA27997@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
References: <15921.37163.139583.74988@harpo.it.uu.se> <20030124193721.GA24876@wotan.suse.de> <15926.60767.451098.218188@harpo.it.uu.se> <20030128212753.GA29191@wotan.suse.de> <15927.62893.336010.363817@harpo.it.uu.se> <20030129162824.GA4773@wotan.suse.de> <15934.49235.619101.789799@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15934.49235.619101.789799@harpo.it.uu.se>
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 03, 2003 at 08:17:39PM +0100, Mikael Pettersson wrote:
> Andi Kleen writes:
>  > > 1. One unknown ioctl is logged from RH8.0 init:
>  > > 
>  > > ioctl32(iwconfig:185): Unknown cmd fd(3) cmd(00008b01){00} arg(ffffda90) on socket:[389]
>  > 
>  > Probably harmless, but if you figure it out please send me a patch.
> 
> The ioctl is SIOCGIWNAME, which is used by iwconfig from the wireless-tools
> package to check if a given net dev is a wireless thing or not (called from
> ifup in RedHat as a type test on the net dev).
> 
> Unfortunately, include/linux/wireless.h has a big pile of ioctls and arg/res
> types that would need to be checked, so I'll defer this to Jean Tourrilhes (cc:d).
> 
> /Mikael

	Why don't you just recompile the Wireless Tools (iwconfig and
friends) for 64 bits ?
	The source of Wireless Tools should be 64 bit clean (was
working on Alpha), and I don't think it's worth adding a whole pile of
cruft in the kernel when it's used by a few system utilities that you
can simply recompile. Personally, I expect every distribution to ship
the base system compiled natively.
	With regards to this specific problem, just return an
error. The Wireless Tools should gracefully handle it and report to
the user. I would appreciate if you would use a "distinctive" error
message, such as ENOEXEC, so that I can point users in the correct
direction.

	Just food for thought... I you think the wireless ioctls are
bad, there is worse. The linux-wlan-ng driver defines it's own driver
specific ioctls, and it has 3 times the number of ioctls. Just for one
driver. And the ioctl format sometimes changes with revision.
	So, clearly you can't expect to deal with every ioctl under
the sun, that's just not practical.

	Have fun...

	Jean

