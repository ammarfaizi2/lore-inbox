Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316695AbSGBKYL>; Tue, 2 Jul 2002 06:24:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316705AbSGBKYK>; Tue, 2 Jul 2002 06:24:10 -0400
Received: from vladimir.pegasys.ws ([64.220.160.58]:16388 "HELO
	vladimir.pegasys.ws") by vger.kernel.org with SMTP
	id <S316693AbSGBKYI>; Tue, 2 Jul 2002 06:24:08 -0400
Date: Tue, 2 Jul 2002 03:26:27 -0700
From: jw schultz <jw@pegasys.ws>
To: Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: lilo/raid?
Message-ID: <20020702032627.D28771@pegasys.ws>
Mail-Followup-To: jw schultz <jw@pegasys.ws>,
	Kernel mailing list <linux-kernel@vger.kernel.org>
References: <3D216157.FC60B17E@aitel.hist.no> <Pine.LNX.4.44.0207021111050.21320-100000@netfinity.realnet.co.sz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <Pine.LNX.4.44.0207021111050.21320-100000@netfinity.realnet.co.sz>; from zwane@mwaikambo.name on Tue, Jul 02, 2002 at 11:12:03AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 02, 2002 at 11:12:03AM +0200, Zwane Mwaikambo wrote:
> On Tue, 2 Jul 2002, Helge Hafting wrote:
> 
> > > > /dev/md1                swap                    swap    defaults        0 0
> > > 
> > > One small thing, you do know that you can interleave swap?
> > 
> > There are sometimes reasons not to do that.
> > Heavy swapping may be caused by attempts to cache 
> > massive io on some fs.  You better not have swap
> > on that heavily accessed spindle - because then
> > everything ends up waiting on that io.
> > 
> > Keeping swap somewhere else means other programs
> > just wait a little for swap - undisturbed by the massive
> > io also going on.
> 
> True, but what i meant was that instead of creating a RAID device to swap 
> to, he could have just interleaved normal swap partitions and gotten the 
> same effect.

Not a config i would recommend.  While spreading swap over
multiple spindles that way is good for speed it multiplies the
likelihood that a disk failure will down the system.  If you
think a dead filesystem is a mess, just watch what happens
when swap goes dead.

Much better to put swap on several RAID-1 volumes if
you want to spread it around.  Disks just aren't that
expensive anymore.  RAID-5 though would be a bad move since
swap gets an order of magnitude more writes than reads.  On
account of the heavy write tendencies i lean toward
so-called hardware RAID for swap in order to offload the PCI
buss.

-- 
________________________________________________________________
	J.W. Schultz            Pegasystems Technologies
	email address:		jw@pegasys.ws

		Remember Cernan and Schmitt
