Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263137AbSKTXYw>; Wed, 20 Nov 2002 18:24:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263276AbSKTXYv>; Wed, 20 Nov 2002 18:24:51 -0500
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:2981 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S263137AbSKTXYt>; Wed, 20 Nov 2002 18:24:49 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Joel Becker <Joel.Becker@oracle.com>
Date: Thu, 21 Nov 2002 10:31:47 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15836.7011.785444.979392@notabene.cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org
Subject: Re: RFC - new raid superblock layout for md driver
In-Reply-To: message from Joel Becker on Wednesday November 20
References: <15835.2798.613940.614361@notabene.cse.unsw.edu.au>
	<20021120160259.GW806@nic1-pc.us.oracle.com>
X-Mailer: VM 7.07 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday November 20, Joel.Becker@oracle.com wrote:
> On Wed, Nov 20, 2002 at 03:09:18PM +1100, Neil Brown wrote:
> > The interpretation of the 'name' field would be up to the user-space
> > tools and the system administrator.
> > I imagine having something like:
> > 	host:name
> > where if "host" isn't the current host name, auto-assembly is not
> > tried, and if "host" is the current host name then:
> >   if "name" looks like "md[0-9]*" then the array is assembled as that
> >     device
> >   else the array is assembled as /dev/mdN for some large, unused N,
> >     and a symlink is created from /dev/md/name to /dev/mdN
> > If the "host" part is empty or non-existant, then the array would be
> > assembled no-matter what the hostname is.  This would be important
> > e.g. for assembling the device that stores the root filesystem, as we
> > may not know the host name until after the root filesystem were loaded.
> 
> 	Hmm, what is the intended future interaction of DM and MD?  Two
> ways at the same problem?  Just curious.

I see MD and DM as quite different, though I haven't looked much as DM
so I could be wrong.

I see raid1 and raid5 as being the key elements of MD.  i.e. handling
redundancy, rebuilding hot spares, stuff like that.  raid0 and linear
are almost optional frills.

DM on the other hand doesn't do redundancy (I don't think) but helps
to chop devices up into little bits and put them back together into
other devices.... a bit like a filesystem really, but it provided block
devices instead of files.

So raid0 and linear are more the domain of DM than MD in my mind.
But they are currently supported by MD and there is no real need to
change that.


> 	Assuming MD as a continually used feature, the "name" bits above
> seem to be preparing to support multiple shared users of the array.  If
> that is the case, shouldn't the superblock contain everything needed for
> "clustered" operation?

Only if I knew what 'everything needed for clustered operation' was....
There is room for expansion in the superblock so stuff could be added.
If there were some specific things that you think would help clustered
operation, I'd be happy to hear the details.

Thanks,
NeilBrown
