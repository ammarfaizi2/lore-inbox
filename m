Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271421AbRIFQ5q>; Thu, 6 Sep 2001 12:57:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270823AbRIFQ5h>; Thu, 6 Sep 2001 12:57:37 -0400
Received: from castle.nmd.msu.ru ([193.232.112.53]:14857 "HELO
	castle.nmd.msu.ru") by vger.kernel.org with SMTP id <S270797AbRIFQ5W>;
	Thu, 6 Sep 2001 12:57:22 -0400
Message-ID: <20010906210431.B23410@castle.nmd.msu.ru>
Date: Thu, 6 Sep 2001 21:04:31 +0400
From: Andrey Savochkin <saw@saw.sw.com.sg>
To: Andi Kleen <ak@suse.de>
Cc: Wietse Venema <wietse@porcupine.org>,
        Matthias Andree <matthias.andree@gmx.de>, linux-kernel@vger.kernel.org
Subject: Re: notion of a local address [was: Re: ioctl SIOCGIFNETMASK: ip alias bug 2.4.9 and 2.2.19]
In-Reply-To: <20010906193750.B22187@castle.nmd.msu.ru> <20010906155811.BC78DBC06C@spike.porcupine.org> <20010906204423.B23109@castle.nmd.msu.ru> <20010906184742.A10228@gruyere.muc.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93.2i
In-Reply-To: <20010906184742.A10228@gruyere.muc.suse.de>; from "Andi Kleen" on Thu, Sep 06, 2001 at 06:47:42PM
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 06, 2001 at 06:47:42PM +0200, Andi Kleen wrote:
> On Thu, Sep 06, 2001 at 08:44:23PM +0400, Andrey Savochkin wrote:
> > The question was which ip.address in user@[ip.address] should be treated as
> > local.
> > My comment was that the only reasonable solution on Linux is to treat this
> > way addresses explicitly specified in the configuration file.
> > Postfix may show its guess at the installation time.
> > 
> > Now the question of recognizing user@[ip.address] as local is a question of a
> > simple table lookup.
> 
> It would be at least possible to ask the routing engine via RTM_GETROUTE
> and checking for RTN_LOCAL if it considers an address local.
> It won't cover all cases with netfilter rules etc.; but probably be a good
> enough approximation.

Well, you need to enlist local addresses, not to verify, so I would suggest
inspecting `local' routing table.

But it doesn't help with the other example I provided a couple of messages
earlier: several MTAs on one system listening on their own IP addresses.
Some time ago, when I was engaged in system administration activity, almost
all my mail relays had several MTAs, each in its own chroot environments...

So, using routing in the post-install script to provide suggestion what
should be written in the configuration file is very reasonable, probably,
it's the best guess that the script can make.

	Andrey
