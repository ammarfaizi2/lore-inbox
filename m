Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129026AbQJ3Grb>; Mon, 30 Oct 2000 01:47:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129029AbQJ3GrW>; Mon, 30 Oct 2000 01:47:22 -0500
Received: from Cantor.suse.de ([194.112.123.193]:18701 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S129026AbQJ3GrC>;
	Mon, 30 Oct 2000 01:47:02 -0500
Date: Mon, 30 Oct 2000 07:47:00 +0100
From: Andi Kleen <ak@suse.de>
To: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: 2.2.18Pre Lan Performance Rocks!
Message-ID: <20001030074700.A31783@gruyere.muc.suse.de>
In-Reply-To: <39FCB09E.93B657EC@timpanogas.org> <E13q2R7-0006S7-00@the-village.bc.nu> <20001029183531.A7155@vger.timpanogas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20001029183531.A7155@vger.timpanogas.org>; from jmerkey@vger.timpanogas.org on Sun, Oct 29, 2000 at 06:35:31PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 29, 2000 at 06:35:31PM -0700, Jeff V. Merkey wrote:
> On Mon, Oct 30, 2000 at 12:04:23AM +0000, Alan Cox wrote:
> > > It's still got some problems with NFS (I am seeing a few RPC timeout
> > > errors) so I am backreving to 2.2.17 for the Ute-NWFS release next week,
> > > but it's most impressive.
> > 
> > Can you send a summary of the NFS reports to nfs-devel@linux.kernel.org
> 
> Yes.  I just went home, so I am emailing from my house.  I'll post late 
> tonight or in the morning.  Performance on 100Mbit with NFS going 
> Linux->Linux is getting better throughput than IPX NetWare Client -> 
> NetWare 5.x on the same network by @ 3%.  When you start loading up a 
> Linux server, it drops off sharply and NetWare keeps scaling, however, 
> this does indicate that the LAN code paths are equivalent relative to 
> latency vs. MSM/TSM/HSM in NetWare.  NetWare does better caching 
> (but we'll fix this in Linux next).  I think the ring transitions to 
> user space daemons are what are causing the scaling problems 
> Linux vs. NetWare.

There are no user space daemons involved in the knfsd fast path, only in slow paths
like mounting.
The main problem I think in knfsd are the numerous copies of the data (e.g. 2+checksumming for
RX with fragments, upto 4 in some specific configurations). They're unfortunately 
not trivial to fix. TX is a bit better, it does only one copy usually out of
the page cache. For RX it also helps to have a network card that supports hardware
checksumming.



-Andi
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
