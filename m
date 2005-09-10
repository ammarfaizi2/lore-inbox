Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750739AbVIJKUN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750739AbVIJKUN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Sep 2005 06:20:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750742AbVIJKUN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Sep 2005 06:20:13 -0400
Received: from ppp59-167.lns1.cbr1.internode.on.net ([59.167.59.167]:63238
	"EHLO triton.bird.org") by vger.kernel.org with ESMTP
	id S1750739AbVIJKUL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Sep 2005 06:20:11 -0400
Message-ID: <4322B437.3010309@acquerra.com.au>
Date: Sat, 10 Sep 2005 20:23:51 +1000
From: Anthony Wesley <awesley@acquerra.com.au>
Reply-To: awesley@acquerra.com.au
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.7.8) Gecko/20050511
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: nate.diller@gmail.com
CC: linux-kernel@vger.kernel.org
Subject: Re: kernel 2.6.13 buffer strangeness - ext2/3/reiser4/xfs comparison
References: <432151B0.7030603@acquerra.com.au>	 <EXCHG2003Zi71mrvoGd00000659@EXCHG2003.microtech-ks.com>	 <5c49b0ed05090914394dba42bf@mail.gmail.com>	 <432225E0.9030606@acquerra.com.au>	 <5c49b0ed0509091735436260bb@mail.gmail.com>	 <432231B7.2060200@acquerra.com.au>	 <5c49b0ed0509091847135834c0@mail.gmail.com>	 <432243AA.4000508@acquerra.com.au> <5c49b0ed05090922021b8f8112@mail.gmail.com>
In-Reply-To: <5c49b0ed05090922021b8f8112@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nate Diller wrote:
> i really recommend you focus on getting better disk bandwidth, you stand 
> to gain a lot more from that approach.  i presume you're on ext3; 
> perhaps you should try reiser4 or xfs, they are more likely to meet your 
> disk bandwidth requirements.
> 
> NATE

While I have already solved the issue that was troubling me, I also spent some time comparing different
filesystems as reccommended by Nate, with interesting results.

My method was simple - make a filesystem and the set it as the target for my video capture. With video
coming in at 25MBytes/sec and going out to disk at about 15-20MBytes/sec it is an interesting test of the
vm and filesystem.

I compared ext2,ext3,xfs,vfat,reiser and reiser4.

The hands-down winner was ext2. All the others showed problems of either lower disk throughput
or dropped frames during video capture.

Only ext2 went the full distance - no dropped frames until we run out of RAM, and good disk throughput.

xfs,reiser and reiser4 had slightly higher disk write speed, but showed performance problems
that caused lots of dropped frames so they must be ruled out at this stage.

I know that xfs and reiser4 are supposed to be faster for some things, but it seems to me that they
are not the best choice when you are predominantly writing lots and lots of 600k files :-)

regards, Anthony

-- 
Anthony Wesley
Director and IT/Network Consultant
Smart Networks Pty Ltd
Acquerra Pty Ltd

Anthony.Wesley@acquerra.com.au
Phone: (02) 62595404 or 0419409836
