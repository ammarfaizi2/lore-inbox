Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135768AbRAGFTg>; Sun, 7 Jan 2001 00:19:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135783AbRAGFTZ>; Sun, 7 Jan 2001 00:19:25 -0500
Received: from cx97923-a.phnx3.az.home.com ([24.9.112.194]:16392 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S135768AbRAGFTT>;
	Sun, 7 Jan 2001 00:19:19 -0500
Message-ID: <3A580B31.7998C783@candelatech.com>
Date: Sat, 06 Jan 2001 23:22:41 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.16 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: linux-kernel <linux-kernel@vger.kernel.org>,
        "netdev@oss.sgi.com" <netdev@oss.sgi.com>
Subject: Re: [PATCH] hashed device lookup (Does NOT meet Linus' sumission 
 policy!)
In-Reply-To: <3A578F27.D2A9DF52@candelatech.com> <20010107042959.A14330@gruyere.muc.suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> 
> On Sat, Jan 06, 2001 at 02:33:27PM -0700, Ben Greear wrote:
> > I'm hoping that I can get a few comments on this code.  It was added
> > to (significantly) speed up things like 'ifconfig -a' when running with
> > 4000 or so VLAN devices.  It should also help other instances with lots
> > of (virtual) devices, like FrameRelay, ATM, and possibly virtual IP
> > interfaces.  It probably won't help 'normal' users much, and in it's final
> > form, should probably be a selectable option in the config process.
> >
> > Anyway, let me know what you think!
> 
> Does it make any significant different with the ifconfig from newest nettools? I
> removed a quadratic algorithm from ifconfig's device parsing, and with that I was
> able to display a few thousand alias devices on a unpatched kernel in reasonable time.
> 
> -Andi

At the time I was doing this, I downloaded the latest nettools version.
The hashing made a very noticable difference on 4000 interfaces, but
I haven't run any real solid benchmarkings at other levels.  Can
you tell me some distinguishing mark (version?) on ifconfig that I
can look for?

I'm willing to run such benchmarks, but what would make a good benchmark,
other than ifconfig -a?

And a question for the socket gurus:

Suppose I bind a raw socket to device vlan4001 (ie I have 4k in the list
before that one!!).  Currently, that means a linear search on all devices,
right?  In that extreme example, I would expect the hash to be very
useful.

Binding to IP addresses have the same issue??

Also, though hashing by name is not horribly exact, hashing on the device
index should be nearly perfect, so finding device 666 might take a search
through only 5 or so devices (find the hash-bucket, walk down the list in
that bucket).

-- 
Ben Greear (greearb@candelatech.com)  http://www.candelatech.com
Author of ScryMUD:  scry.wanfear.com 4444        (Released under GPL)
http://scry.wanfear.com               http://scry.wanfear.com/~greear
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
