Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135664AbRAWBsy>; Mon, 22 Jan 2001 20:48:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135751AbRAWBso>; Mon, 22 Jan 2001 20:48:44 -0500
Received: from asbestos.linuxcare.com.au ([203.17.0.30]:60668 "EHLO halfway")
	by vger.kernel.org with ESMTP id <S135664AbRAWBsd>;
	Mon, 22 Jan 2001 20:48:33 -0500
From: Rusty Russell <rusty@linuxcare.com.au>
To: Aaron Lehmann <aaronl@vitelus.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4 and ipmasq modules 
In-Reply-To: Your message of "Sat, 20 Jan 2001 14:46:16 -0800."
             <20010120144616.A16843@vitelus.com> 
Date: Tue, 23 Jan 2001 12:48:20 +1100
Message-Id: <E14KsZI-0006IU-00@halfway>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20010120144616.A16843@vitelus.com> you write:
> It was great to see that 2.4.0 reintroduced ipfwadm support! I had no
> need for ipchains and ended up using the wrapper around it that
> emulated ipfwadm. However, 2.[02].x used to have "special IP
> masquerading modules" such as ip_masq_ftp.o, ip_masq_quake.o, etc. I
> can't find these in 2.4.0. Where have they gone? Without important
> modules such as ip_masq_ftp.o I cannot use non-passive ftp from behind
> the masquerading firewall.

Hi Aaron,

The entire point of the netfilter kernel architecture is that we can
just ask for packets at certain points, no #ifdefs, special hacks,
etc.  Unfortunately, the previous masquerading code (used in 2.0 and
2.2) looked really difficult to extract from the kernel.  Netfilter
has changed a little since then (particularly NF_STOLEN), so it might
be possible now.

So I reimplimented 2.2-style masquerading on top of the new NAT
infrastructure: ideally this would mean that it could use the new
helpers, but there were some minor technical problems, and it was
never tested.  

Those who berated Aaron for not wanting to upgrade: he is the Debian
maintainer for crashme, gtk-theme-switch, koules, pngcrush, and
xdaliclock.  By wasting his time making him convert a perfectly
working system, you are taking away time from those projects.  I'd
rather see him spend time on Cool Stuff(TM) which benefits all of us.

Cheers,
Rusty.
--
Premature optmztion is rt of all evl. --DK
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
