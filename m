Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267891AbUHXOsd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267891AbUHXOsd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 10:48:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267934AbUHXOsd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 10:48:33 -0400
Received: from adsl-209-204-138-32.sonic.net ([209.204.138.32]:64702 "EHLO
	server.home") by vger.kernel.org with ESMTP id S267891AbUHXOs2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 10:48:28 -0400
Date: Tue, 24 Aug 2004 07:47:39 -0700 (PDT)
From: Christoph Lameter <christoph@lameter.com>
X-X-Sender: christoph@server.home
To: Matthew Wilcox <willy@debian.org>
cc: Christoph Lameter <clameter@sgi.com>,
       William Lee Irwin III <wli@holomorphy.com>,
       "David S. Miller" <davem@redhat.com>, raybry@sgi.com, ak@muc.de,
       benh@kernel.crashing.org, manfred@colorfullife.com,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
       vrajesh@umich.edu
Subject: Re: page fault scalability patch v3: use cmpxchg, make rss atomic
In-Reply-To: <20040824123416.GL9660@parcelfarce.linux.theplanet.co.uk>
Message-ID: <Pine.LNX.4.58.0408240743180.3853@server.home>
References: <20040815130919.44769735.davem@redhat.com>
 <Pine.LNX.4.58.0408151552280.3370@schroedinger.engr.sgi.com>
 <20040815165827.0c0c8844.davem@redhat.com> <Pine.LNX.4.58.0408151703580.3751@schroedinger.engr.sgi.com>
 <20040815185644.24ecb247.davem@redhat.com> <Pine.LNX.4.58.0408151924250.4480@schroedinger.engr.sgi.com>
 <20040816143903.GY11200@holomorphy.com>
 <B6E8046E1E28D34EB815A11AC8CA3129027B679F@mtv-atc-605e--n.corp.sgi.com>
 <Pine.LNX.4.58.0408232138540.32721@schroedinger.engr.sgi.com>
 <Pine.LNX.4.58.0408232243530.26785@server.home>
 <20040824123416.GL9660@parcelfarce.linux.theplanet.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: -4.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Aug 2004, Matthew Wilcox wrote:

> On Mon, Aug 23, 2004 at 10:49:31PM -0700, Christoph Lameter wrote:
> > Unpatched:
> > Gb Rep Threads   User      System     Wall flt/cpu/s fault/wsec
> >   4   3    1    0.157s     11.197s  11.035s 69261.721  69239.940
> >   4   3    2    0.145s     11.445s   6.079s 67849.528 115681.409
> >   4   3    4    0.182s     13.894s   4.027s 55865.834 184108.856
> >   4   3    8    0.196s     24.874s   4.025s 31369.039 184790.767
> >
> > With page fault scalability patch:
> >  Gb Rep Threads   User      System     Wall flt/cpu/s fault/wsec
> >   4   3    1    0.176s     11.323s  11.050s 68385.368  68345.055
> >   4   3    2    0.174s     10.716s   5.096s 72205.329 131848.322
> >   4   3    4    0.170s     10.694s   3.040s 72380.552 231128.569
> >   4   3    8    0.177s     14.717s   2.064s 52796.567 297380.041
>
> What kind of variance are you seeing with this benchmark?  I'm suspicious
> that your 2 thread case is faster than your single thread case.

What is so suspicious about it? Two CPUs can do the job faster than a
single one. Thats the way it should be and the point of these
patches is to reduce locking so that this can happen in a more efficient
way.

There are some variances in these tests especially if one uses low memory
settings such as 1GB 2GB and to some extend also at 4GB. 16 GB gives quite
stable results but the machine I had available for this only had 8 GB. See
my earlier posts on the subject for other test results.
