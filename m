Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267605AbUHXMeW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267605AbUHXMeW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 08:34:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267660AbUHXMeW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 08:34:22 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:22144 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S267605AbUHXMeS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 08:34:18 -0400
Date: Tue, 24 Aug 2004 13:34:16 +0100
From: Matthew Wilcox <willy@debian.org>
To: Christoph Lameter <christoph@lameter.com>
Cc: Christoph Lameter <clameter@sgi.com>,
       William Lee Irwin III <wli@holomorphy.com>,
       "David S. Miller" <davem@redhat.com>, raybry@sgi.com, ak@muc.de,
       benh@kernel.crashing.org, manfred@colorfullife.com,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
       vrajesh@umich.edu
Subject: Re: page fault scalability patch v3: use cmpxchg, make rss atomic
Message-ID: <20040824123416.GL9660@parcelfarce.linux.theplanet.co.uk>
References: <20040815130919.44769735.davem@redhat.com> <Pine.LNX.4.58.0408151552280.3370@schroedinger.engr.sgi.com> <20040815165827.0c0c8844.davem@redhat.com> <Pine.LNX.4.58.0408151703580.3751@schroedinger.engr.sgi.com> <20040815185644.24ecb247.davem@redhat.com> <Pine.LNX.4.58.0408151924250.4480@schroedinger.engr.sgi.com> <20040816143903.GY11200@holomorphy.com> <B6E8046E1E28D34EB815A11AC8CA3129027B679F@mtv-atc-605e--n.corp.sgi.com> <Pine.LNX.4.58.0408232138540.32721@schroedinger.engr.sgi.com> <Pine.LNX.4.58.0408232243530.26785@server.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0408232243530.26785@server.home>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 23, 2004 at 10:49:31PM -0700, Christoph Lameter wrote:
> Unpatched:
> Gb Rep Threads   User      System     Wall flt/cpu/s fault/wsec
>   4   3    1    0.157s     11.197s  11.035s 69261.721  69239.940
>   4   3    2    0.145s     11.445s   6.079s 67849.528 115681.409
>   4   3    4    0.182s     13.894s   4.027s 55865.834 184108.856
>   4   3    8    0.196s     24.874s   4.025s 31369.039 184790.767
> 
> With page fault scalability patch:
>  Gb Rep Threads   User      System     Wall flt/cpu/s fault/wsec
>   4   3    1    0.176s     11.323s  11.050s 68385.368  68345.055
>   4   3    2    0.174s     10.716s   5.096s 72205.329 131848.322
>   4   3    4    0.170s     10.694s   3.040s 72380.552 231128.569
>   4   3    8    0.177s     14.717s   2.064s 52796.567 297380.041

What kind of variance are you seeing with this benchmark?  I'm suspicious
that your 2 thread case is faster than your single thread case.

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
