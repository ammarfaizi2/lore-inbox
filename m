Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311898AbSEPLkC>; Thu, 16 May 2002 07:40:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312411AbSEPLkB>; Thu, 16 May 2002 07:40:01 -0400
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:11231 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S311898AbSEPLkB>; Thu, 16 May 2002 07:40:01 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Sverker Wiberg <Sverker.Wiberg@uab.ericsson.se>
Date: Thu, 16 May 2002 21:39:36 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15587.39544.81694.975593@notabene.cse.unsw.edu.au>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: PROBLEM: knfsd misses occasional writes
In-Reply-To: message from Sverker Wiberg on Thursday May 16
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday May 16, Sverker.Wiberg@uab.ericsson.se wrote:
> Neil Brown wrote:
> > 
> > On Wednesday May 15, Sverker.Wiberg@uab.ericsson.se wrote:
> > >
> > > Hello everyone,
> > >
> > > When copying lots of small files from multiple NFS clients to a kNFSd
> > > filesystem (i.e. doing backup of a cluster), exported with `sync', I
> > > find that some few files (1 out of 1000) were silently truncated to zero
>                                                   ^^^^^^^^
>                                                   no errors reported 
> 
> > > size when checking locally with `ls' (the clients reported total
> > > success). With `asynch' instead, all files were correctly copied.
> > 
> > How are you mounting the file systems on the clients?
> > The symptoms sound exactly like you are using "soft" mounts.  "soft"
> > is a very bad mount option.  Use "hard".
> >
> > If you aren't using "soft", let me know and I will look harder.
> 
> Errrm, I am using "soft" mounts, as I (we) want the clients to survive
> server restarts.

What do you mean by "survive"?  What you probably want is
   hard,intr
so that clients will wait for the server to come back, but you can
interrupt processes successfully.

> But shouldn't those timeouts become errors over at the clients?

Yes... but "write" won't see an error.  Only 'fsync' or maybe 'close',
and many applications ignore errors from these operations.

NeilBrown
