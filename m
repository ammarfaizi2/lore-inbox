Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130548AbRAPLiO>; Tue, 16 Jan 2001 06:38:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130645AbRAPLiD>; Tue, 16 Jan 2001 06:38:03 -0500
Received: from Cantor.suse.de ([194.112.123.193]:60690 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S130548AbRAPLht>;
	Tue, 16 Jan 2001 06:37:49 -0500
Date: Tue, 16 Jan 2001 12:37:43 +0100
From: Andi Kleen <ak@suse.de>
To: Ingo Molnar <mingo@elte.hu>
Cc: Andi Kleen <ak@suse.de>, Linus Torvalds <torvalds@transmeta.com>,
        dean gaudet <dean-list-linux-kernel@arctic.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Jonathan Thackray <jthackray@zeus.com>
Subject: Re: 'native files', 'object fingerprints' [was: sendpath()]
Message-ID: <20010116123743.A32075@gruyere.muc.suse.de>
In-Reply-To: <20010116121323.A31583@gruyere.muc.suse.de> <Pine.LNX.4.30.0101161217001.2352-100000@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.30.0101161217001.2352-100000@elte.hu>; from mingo@elte.hu on Tue, Jan 16, 2001 at 12:26:12PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 16, 2001 at 12:26:12PM +0100, Ingo Molnar wrote:
> 
> On Tue, 16 Jan 2001, Andi Kleen wrote:
> 
> > On Tue, Jan 16, 2001 at 10:48:34AM +0100, Ingo Molnar wrote:
> > > this is a safe, very fast [ O(1) ] object-permission model. (it's a
> > > variation of a former idea of yours.) A process can pass object
> > > fingerprints and kernel pointers to other processes too - thus the other
> > > process can access the object too. Threads will 'naturally' share objects,
> > >...
> >
> > Just setuid etc. doesn't work with that because access cannot be
> > easily revoked without disturbing other clients.
> 
> well, you cannot easily close() an already shared file descriptor in
> another process's context either. Is revocation so important? Why is
> setuid() a problem? A native file is just like a normal file, with the
> difference that not an integer but a fingerprint identifies it, and that
> access and usage counts are not automatically inherited across some
> explicit sharing interface.

Actually on second thought exec() is more a problem than setuid(), because
it requires closing for file descriptors.

So if you could devise a security model that doesn't depend on exec giving
you a clean plate -- then it could work, but would probably not be very
unixy. 

I'm amazed how non flamed you can present radical API ideas though, I even
get flamed for much smaller things (like using text errors to replace
the hundreds of EINVALs in the rtnetlink message interface)  ;);)

> 
> perhaps we could get most of the advantages by allowing the relaxation of
> the 'allocate first free file descriptor number' rule for normal Unix
> files?
Not sure I follow. You mean dup2() ? 

-Andi

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
