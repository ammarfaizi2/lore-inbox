Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131458AbRACMhL>; Wed, 3 Jan 2001 07:37:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131613AbRACMhC>; Wed, 3 Jan 2001 07:37:02 -0500
Received: from Cantor.suse.de ([194.112.123.193]:4370 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S131458AbRACMgw>;
	Wed, 3 Jan 2001 07:36:52 -0500
Date: Wed, 3 Jan 2001 13:06:24 +0100
From: Andi Kleen <ak@suse.de>
To: "Jorge L. deLyra" <delyra@latt.if.usp.br>
Cc: Andi Kleen <ak@suse.de>, Neil Brown <neilb@cse.unsw.edu.au>,
        Andrzej Krzysztofowicz <ankry@green.mif.pg.gda.pl>,
        Frank.Olsen@stonesoft.com, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Bugs in knfsd -- Problem re-exporting an NFS share
Message-ID: <20010103130624.A31209@gruyere.muc.suse.de>
In-Reply-To: <20010103115236.A29799@gruyere.muc.suse.de> <Pine.LNX.3.96.1010103090203.20935A-100000@latt.if.usp.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.3.96.1010103090203.20935A-100000@latt.if.usp.br>; from delyra@latt.if.usp.br on Wed, Jan 03, 2001 at 09:14:21AM -0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 03, 2001 at 09:14:21AM -0200, Jorge L. deLyra wrote:
> > Date: Wed, 3 Jan 2001 11:52:36 +0100
> > From: Andi Kleen <ak@suse.de>
> > To: "Jorge L. deLyra" <delyra@latt.if.usp.br>
> > Cc: Neil Brown <neilb@cse.unsw.edu.au>,
> >     Andrzej Krzysztofowicz <ankry@green.mif.pg.gda.pl>,
> >     Frank.Olsen@stonesoft.com, kernel list <linux-kernel@vger.kernel.org>
> > Subject: Re: Bugs in knfsd -- Problem re-exporting an NFS share
> > 
> > On Wed, Jan 03, 2001 at 08:37:08AM -0200, Jorge L. deLyra wrote:
> > > It would be nice if a way was found to implement this feature on knfsd.
> > 
> > There is: just run unfsd too, bound to an own IP address to not conflict. 
> 
> Hum, interesting, I didn't know you could run both servers at the same
> time. The problem is that the old server is not being developed any more,
> as dully advised on the 2.2.18 kernel help messages. In fact, we have been
> having some problems with it for some time, I/O errors and mounts hanging,
> mostly. In fact, upgrading to 2.2.18 broke old NFS exports in some cases
> around here, until we migrated to knfsd: gave us sure-fire I/O errors and
> hangs. So this might be a stopgap measure for some time, but no permanent
> solution. In any case, knfsd seems so much more solid, we want to use it!

That's a bit surprising that you have so many problems with unfsd, I know
lots of installations where it is (still) used successfully in its limits.
I did recently some mainteance work on it to fix it for reiserfs.

> 
> > More efficient would probably be a proxy though that just forwards packets.
> > I see no reason in core NFS why multiple clients could not share a single 
> > multiplexed mount. It could need some lockd support though. 
> 
> I'm afraid you lost me here... If this would have to be some kind of new
> daemon or kernel module that filters out NFS packets and forwards them,
> wouldn't this be equivalent to making knfsd do the same thing? Humm, on
> second thoughts, maybe not, because this beast would not have to interpret
> the mount as a filesystem on the front end. Am I following you correctly?

(when you ignore locking and NFS over TCP ATM) All you need is to forward
UDP packets. This can either be done by a normal user space daemon that
uses portmap and just sends the packets out again, or alternatively by using
UDP masquerading and appropiate routes on the internal boxes.
Only forwarding packets is very different from full reexport support in knfsd
and much simpler.


-Andi
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
