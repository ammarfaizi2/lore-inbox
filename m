Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316583AbSE0LvY>; Mon, 27 May 2002 07:51:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316588AbSE0LvX>; Mon, 27 May 2002 07:51:23 -0400
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:7041 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S316583AbSE0LvW>; Mon, 27 May 2002 07:51:22 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: "Stephen C. Tweedie" <sct@redhat.com>
Date: Mon, 27 May 2002 21:50:34 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15602.7562.776171.139609@notabene.cse.unsw.edu.au>
Cc: Daniel Phillips <phillips@bonn-fries.net>, linux-kernel@vger.kernel.org
Subject: Re: Thoughts on using fs/jbd from drivers/md
In-Reply-To: message from Stephen C. Tweedie on Monday May 27
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday May 27, sct@redhat.com wrote:
> Hi,
> 
> On Sun, May 26, 2002 at 10:41:22AM +0200, Daniel Phillips wrote:
> > On Thursday 16 May 2002 17:17, Stephen C. Tweedie wrote:
> > > Most applications are not all that bound by write latency.
> > 
> > But some are.  Transaction processing applications, where each transaction 
> > has to be safely on disk before it can be acknowledged, care about write 
> > latency a lot, since it translates more or less directly into throughput.
> 
> Not really.  They care about throughput, and will happily sacrifice
> latency for that.

And some aren't...  my main thrust for pursuing this idea was to
present minimal latency to the application.  That is why I want to use
NVRAM for the journal.
My particular application is an NFS server which traditionally suffers
badly if there is too much latency.
Certainly there are situations where a small drop in latency can
improve throughput, but I want to maximise the throughout without any
cost in latency.  And I am willing to spend on the NVRAM to do it.

I'm seeing two very different approaches to journalling an MD device
being significant.
One journals to NVRAM and trys to minimise latency, and works for any
RAID level.  It is basically a write-behind cache.

The other journals to a normal drive and only works for RAID5 (which
is the only level that really needs a journal other than for latency
reasons) and writes to the journal after a the stripe parity
calculation and before the data+parity is sent to disc.

They will probably be very different implementations, though they will
hopefully have a very similar interface.

NeilBrown
