Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131621AbRACNUp>; Wed, 3 Jan 2001 08:20:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131654AbRACNUf>; Wed, 3 Jan 2001 08:20:35 -0500
Received: from latt.if.usp.br ([143.107.129.103]:21005 "HELO latt.if.usp.br")
	by vger.kernel.org with SMTP id <S131621AbRACNUW>;
	Wed, 3 Jan 2001 08:20:22 -0500
Date: Wed, 3 Jan 2001 10:49:54 -0200 (BRST)
From: "Jorge L. deLyra" <delyra@latt.if.usp.br>
To: Andi Kleen <ak@suse.de>
cc: Neil Brown <neilb@cse.unsw.edu.au>,
        Andrzej Krzysztofowicz <ankry@green.mif.pg.gda.pl>,
        Frank.Olsen@stonesoft.com, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Bugs in knfsd -- Problem re-exporting an NFS share
In-Reply-To: <20010103130624.A31209@gruyere.muc.suse.de>
Message-ID: <Pine.LNX.3.96.1010103102308.21599A-100000@latt.if.usp.br>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> That's a bit surprising that you have so many problems with unfsd, I know
> lots of installations where it is (still) used successfully in its limits.
> I did recently some mainteance work on it to fix it for reiserfs.

Well, let me qualify that better. The problems were not really bad before
2.2.18. There where none in 2.0, by the way, as far as I remember. They
first showed up when we switched to 2.2, and were more frequent at the
beginning. When we got to 2.2.17 we had pretty much forgotten about them.
We have NFS exports on many machines around here and it only happened in
some, so it is difficult to pinpoint the problem. We were never quite sure
whether the problem was on the server or client, sometimes it looked one
way, sometimes another. Once there was a certain directory such that an ls
-lR on it was sure-fire to give an I/O error message and hang the mount.
Moving the contents to another directory and deleting the first one solved
it, don't ask me why. Very often a way to produce the problem was to sit
at the mount point and do a find for something. When a hang was produced,
you had to kill autofs, unmount by hand, maybe killing a few programs in
order not to get "busy" messages. Then just mount it again and it's OK.
Note that neither killing and restarting the server nor rebooting the
client seemed necessary. You just had to unmount and remount.

> (when you ignore locking and NFS over TCP ATM) All you need is to forward
> UDP packets. This can either be done by a normal user space daemon that
> uses portmap and just sends the packets out again, or alternatively by using
> UDP masquerading and appropiate routes on the internal boxes.
> Only forwarding packets is very different from full reexport support in knfsd
> and much simpler.

Well, I hope some solution is found, since this is an important feature.
It would be nicer in knfsd, I think, but if that proves unpractical for
some reason, your packet filter/forwarder might just be the answer.

							Best luck,

----------------------------------------------------------------
        Jorge L. deLyra,  Associate Professor of Physics
            The University of Sao Paulo,  IFUSP-DFMA
       For more information: finger delyra@latt.if.usp.br
----------------------------------------------------------------

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
