Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271032AbRHXKZ7>; Fri, 24 Aug 2001 06:25:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271029AbRHXKZj>; Fri, 24 Aug 2001 06:25:39 -0400
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.29]:32784 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S271023AbRHXKZc>; Fri, 24 Aug 2001 06:25:32 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: <pcg@goof.com ( Marc) (A.) (Lehmann )>
Date: Fri, 24 Aug 2001 20:25:29 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15238.11161.492557.264988@notabene.cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org, oesi@plan9.de
Subject: Re: software raid does not do parallel reads under 2.4?
In-Reply-To: message from pcg( Marc)@goof(A.).(Lehmann )com on Thursday August 23
In-Reply-To: <20010823234218.B12873@cerebro.laendle>
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday August 23, pcg( Marc)@goof(A.).(Lehmann )com wrote:
> It seems that the md driver in striped mode does not parallelize any reads
> under 2.4. The scenario is that I have 3 disks on different controllers
> (different pci slots), so there should not be any ide bus contention.
> 
> When I read any single disk (e.g. using hdparm or dd), I get 32MB/s. When
> I read two of them at the same time, I get about 28MB/s for each disk.
> 
> Under linux-2.2 using md and striping I get about 40-50MB/s, whereas, under
> 2.4, the same raid gives about 30MB/s.
> 
> I then reformatted the raid to have 2MB chunksize. If I look at the disk
> LED's while reading from them (e.g. dd if=/dev/md3 bs=1024x1024x8), I see
> that each disk is read in turn, while the other two disks are idle.
> 
> so it looks as if md under 2.4 only reads disks in turn, which makes
> striping useless as a performance tool.

For raid0, the md driver just redirects requests to the right drive.
It doesn't explicitly serialise or parallelise anything. 2.4 works in
exactly the same was as 2.2.

With a 2MB chunksize, I would expect a linear read to touch just one
drive at a time.
With a 4K chunk size, I suspect that an linear read would read from
all the drives in parallel.
You say that you reformatted to 2MB chunksize.  What did you reformat
from?

NeilBrown
