Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272261AbRHXRB5>; Fri, 24 Aug 2001 13:01:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272262AbRHXRBr>; Fri, 24 Aug 2001 13:01:47 -0400
Received: from sproxy.gmx.net ([213.165.64.20]:29272 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S272261AbRHXRBe>;
	Fri, 24 Aug 2001 13:01:34 -0400
Message-ID: <3B868874.B89B04DE@gmx.at>
Date: Fri, 24 Aug 2001 19:01:40 +0200
From: Wilfried Weissmann <Wilfried.Weissmann@gmx.at>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.7-ac3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: software raid does not do parallel reads under 2.4?
In-Reply-To: <20010823234218.B12873@cerebro.laendle> <15238.11161.492557.264988@notabene.cse.unsw.edu.au>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Brown wrote:
> 
> On Thursday August 23, pcg( Marc)@goof(A.).(Lehmann )com wrote:
> > It seems that the md driver in striped mode does not parallelize any reads
> > under 2.4. The scenario is that I have 3 disks on different controllers
> > (different pci slots), so there should not be any ide bus contention.
> >
> > When I read any single disk (e.g. using hdparm or dd), I get 32MB/s. When
> > I read two of them at the same time, I get about 28MB/s for each disk.
> >
> > Under linux-2.2 using md and striping I get about 40-50MB/s, whereas, under
> > 2.4, the same raid gives about 30MB/s.
> >
> > I then reformatted the raid to have 2MB chunksize. If I look at the disk
> > LED's while reading from them (e.g. dd if=/dev/md3 bs=1024x1024x8), I see
> > that each disk is read in turn, while the other two disks are idle.
> >
> > so it looks as if md under 2.4 only reads disks in turn, which makes
> > striping useless as a performance tool.
> 
> For raid0, the md driver just redirects requests to the right drive.
> It doesn't explicitly serialise or parallelise anything. 2.4 works in
> exactly the same was as 2.2.
> 
> With a 2MB chunksize, I would expect a linear read to touch just one
> drive at a time.
> With a 4K chunk size, I suspect that an linear read would read from
> all the drives in parallel.
> You say that you reformatted to 2MB chunksize.  What did you reformat
> from?
> 
> NeilBrown

I experienced some performance loss when moving from kernel 2.4.4 to
2.4.7-ac3 regarding ide harddisks. I am useing the hpt ataraid driver
which does pretty much the same thing as the md disk striping driver.
I/O speed of the raid volume is about as fast as accessing a single
drive.
There were a lot of ide reports some time ago. Maybe they where problems
with concurrent I/O operations...?

Wilfried
