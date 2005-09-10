Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750758AbVIJLwX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750758AbVIJLwX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Sep 2005 07:52:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750760AbVIJLwX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Sep 2005 07:52:23 -0400
Received: from ppp59-167.lns1.cbr1.internode.on.net ([59.167.59.167]:3591 "EHLO
	triton.bird.org") by vger.kernel.org with ESMTP id S1750758AbVIJLwX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Sep 2005 07:52:23 -0400
Message-ID: <4322C9DF.1090704@acquerra.com.au>
Date: Sat, 10 Sep 2005 21:56:15 +1000
From: Anthony Wesley <awesley@acquerra.com.au>
Reply-To: awesley@acquerra.com.au
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.7.8) Gecko/20050511
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: nate.diller@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: kernel 2.6.13 buffer strangeness - ext2/3/reiser4/xfs comparison
References: <432151B0.7030603@acquerra.com.au>	<EXCHG2003Zi71mrvoGd00000659@EXCHG2003.microtech-ks.com>	<5c49b0ed05090914394dba42bf@mail.gmail.com>	<432225E0.9030606@acquerra.com.au>	<5c49b0ed0509091735436260bb@mail.gmail.com>	<432231B7.2060200@acquerra.com.au>	<5c49b0ed0509091847135834c0@mail.gmail.com>	<432243AA.4000508@acquerra.com.au>	<5c49b0ed05090922021b8f8112@mail.gmail.com>	<4322B437.3010309@acquerra.com.au> <20050910044240.4e8e8e03.akpm@osdl.org>
In-Reply-To: <20050910044240.4e8e8e03.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

> Anthony Wesley <awesley@acquerra.com.au> wrote:
> 
>>I compared ext2,ext3,xfs,vfat,reiser and reiser4.
>>
>> The hands-down winner was ext2. All the others showed problems of either lower disk throughput
>> or dropped frames during video capture.
> 
> 
> ext2 is a good filesystem.  For that sort of application all the journaling
> gunk can really get in the way.
> 
> You should have tested ext3 with data=writeback.
> 

Ask and ye shall receive...

I created an ext3 fs, mounted it with data=writeback and gave it a quick spin.

The result? Lots of pauses and dropped frames during capture. This is during the part of the
process where I have gobs of free RAM that's being used for buffering so dropping frames here
is a cardinal sin.

Dunno why it's happening, but I saw it also with xfs and reiser4. ext2 on the other hand
chugs along happily, no pauses, no dropped frames until we run out of free RAM (takes about 2
minutes now after the simple kernel change).

I can understand dropped frames after we run out of ram, but not before.

regards, Anthony

-- 
Anthony Wesley
Director and IT/Network Consultant
Smart Networks Pty Ltd
Acquerra Pty Ltd

Anthony.Wesley@acquerra.com.au
Phone: (02) 62595404 or 0419409836
