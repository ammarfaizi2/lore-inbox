Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262532AbSIPQfh>; Mon, 16 Sep 2002 12:35:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262613AbSIPQfh>; Mon, 16 Sep 2002 12:35:37 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.103]:7398 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S262532AbSIPQfg>;
	Mon, 16 Sep 2002 12:35:36 -0400
Message-ID: <3D860943.9070903@us.ibm.com>
Date: Mon, 16 Sep 2002 09:39:31 -0700
From: Dave Hansen <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (compatible; MSIE5.5; Windows 98;
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
CC: Samuel Flory <sflory@rackable.com>, Stephen Lord <lord@sgi.com>,
       Austin Gonyou <austin@coremetrics.com>,
       Christian Guggenberger 
	<christian.guggenberger@physik.uni-regensburg.de>,
       Linux Kernel <linux-kernel@vger.kernel.org>, linux-xfs@oss.sgi.com
Subject: Re: 2.4.20pre5aa2
References: <20020911201602.A13655@pc9391.uni-regensburg.de> <1031768655.24629.23.camel@UberGeek.coremetrics.com> <20020911184111.GY17868@dualathlon.random> <3D81235B.6080809@rackable.com> <20020913002316.GG11605@dualathlon.random> <1031878070.1236.29.camel@snafu> <20020913005440.GJ11605@dualathlon.random> <3D8149F6.9060702@rackable.com> <20020913125345.GO11605@dualathlon.random> <3D8600DD.1010707@us.ibm.com> <20020916162001.GK11605@dualathlon.random>
X-Enigmail-Version: 0.65.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:
 > On Mon, Sep 16, 2002 at 09:03:41AM -0700, Dave Hansen wrote:
 >
 >>+	vmi = get_vmalloc_info();
 >
 > hmm, not sure if it's better to slowdown vmalloc instead of
 > /proc/meminfo and to keep meminfo o1. In theory vmalloc should be used
 > only for persistent infrequent allocations, so meminfo has a chance to
 > be recalled more frequently with monitors like xosview during workloads.
 > Admittedly in final production with no monitoring meminfo is going to
 > never be recalled, however I like the idea to keep meminfo very quick.

When I first set out to do it, I modified vmalloc.  But, I decided that it would
probably be easier to get a patch in that didn't modify vmalloc itself.  The
used calculation is much easier (used += requested_size), but the largest free
chunk gets harder to do.  I think that this would have required vfree to get
into the game as well.  It seemed much easier to just make meminfo do a little
more work.

-- 
Dave Hansen
haveblue@us.ibm.com

