Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313457AbSDJSN7>; Wed, 10 Apr 2002 14:13:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313476AbSDJSN6>; Wed, 10 Apr 2002 14:13:58 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:7409
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S313457AbSDJSN5>; Wed, 10 Apr 2002 14:13:57 -0400
Date: Wed, 10 Apr 2002 11:16:06 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: linux-kernel@vger.kernel.org, Jeff Garzik <jgarzik@mandrakesoft.com>,
        "David S. Miller" <davem@redhat.com>, Andrew Morton <akpm@zip.com.au>,
        Lennert Buytenhek <buytenh@gnu.org>
Subject: Re: [BUG] DEADLOCK when removing a bridge on 2.4.19-pre6
Message-ID: <20020410181606.GD23513@matchmail.com>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Jeff Garzik <jgarzik@mandrakesoft.com>,
	"David S. Miller" <davem@redhat.com>,
	Andrew Morton <akpm@zip.com.au>,
	Lennert Buytenhek <buytenh@gnu.org>
In-Reply-To: <20020410015311.GA31952@matchmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 09, 2002 at 06:53:11PM -0700, Mike Fedyk wrote:
> Hi,
> 
> *read below for a problem report against the tulip network driver[1]
> 
> It looks like the bridging feature of the kernel has changed between 2.4.17
> and 18.
> 
> I have a machine running 2.4.16 running as a bride without problem.  While

Oh, yes s/bride/bridge/ ... Nice one Andreas. Women age so much better
than computers, but are just as much harder to change also.  ;)

> testing the network cards for another bridge I had to restart.
> Unfortunately, it didn't complete.  Nothing would respond except for sysrq.
> I was able to sync, unmount, and reboot successfully.
> 
> Debian does this for you automatically, but if you do it manually it does
> the same thing.
> 
> o Setup a bridge like normal
> o start it up
> o ifconfig br0 down
> o brctl delbr br0
> *boom*
> 
> 2.4.16,17 work just fine, but 2.4.18 does not.  Looking through the
> changelog, 2.4.18-pre4, or 5 look suspect.  Also, it is not fixed in
> 2.4.19-pre6.  I can test the 2.4.18-pre kernels if you'd like, just let me
> know.
> 
> [1] Also several times I was able to get my tulip network card to stop
> forwarding packets after a soft-reboot from the lockup mentioned above.  I

I forgot to mention that on each occourance, if I turn the power off, wait a
few seconds, and turn it back on, all network cards work normally including
tulip.  It just looks like the chip isn't setup correctly[2] if it wasn't
already in a known state.

[2] I only say this because a power-down "fixes" the problem whereas a
sysctl-s-u-b soft-reset does not.  It could be the bios on this old machine
too.

As requested by Jeff Garzik, I'm going to copy the latest tulip driver from
2.4.19-pre6 to 2.4.17 and test it there.  Lennert, I'll test the three
bridgeing patches on top of that and let you know which one(s) cause the
problem with bridge removal. 

Mike
