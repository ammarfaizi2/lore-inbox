Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135777AbRAGF6n>; Sun, 7 Jan 2001 00:58:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135763AbRAGF6Y>; Sun, 7 Jan 2001 00:58:24 -0500
Received: from pizda.ninka.net ([216.101.162.242]:6036 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S135751AbRAGF6O>;
	Sun, 7 Jan 2001 00:58:14 -0500
Date: Sat, 6 Jan 2001 21:40:36 -0800
Message-Id: <200101070540.VAA24665@pizda.ninka.net>
From: "David S. Miller" <davem@redhat.com>
To: greearb@candelatech.com, linux-kernel@vger.kernel.org, netdev@oss.sgi.com
In-Reply-To: <20010107162905.B1804@metastasis.f00f.org> (message from Chris
	Wedgwood on Sun, 7 Jan 2001 16:29:05 +1300)
Subject: Re: [PATCH] hashed device lookup (Does NOT meet Linus' sumission policy!)
In-Reply-To: <3A578F27.D2A9DF52@candelatech.com> <20010107162905.B1804@metastasis.f00f.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


   On Sat, Jan 06, 2001 at 02:33:27PM -0700, Ben Greear wrote:

       I'm hoping that I can get a few comments on this code.  It was
       added to (significantly) speed up things like 'ifconfig -a' when
       running with 4000 or so VLAN devices.  It should also help other
       instances with lots of (virtual) devices, like FrameRelay, ATM,
       and possibly virtual IP interfaces.  It probably won't help
       'normal' users much, and in it's final form, should probably be a
       selectable option in the config process.

Ben, if ifconfig uses /proc/net/dev to list devices, how can your
changes speed up ifconfig?  Andi mentioned in another email how he has
fixed the quadratic behavior in ifconfig, you should check if it fixes
your problem.  Jamal has suggested dumping ifconfig and making a dummy
"ifconfig" which just wrappers around "ip".  I like this idea the most.

Really, what I'm concerned about is what calls dev_get_by_{name,index}
so often and in such critical places that optimizing it makes any
sense?

I don't mind optimizing stuff like this where needed, in fact I'm the
most guilty of this, check out the complex TCP hash tables we have :-)
But if it's only a problem because of poorly implemented user
applications, let's fix the apps instead of adding the complexity to
the kernel.

Later,
David S. Miller
davem@redhat.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
