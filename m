Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284902AbSACFUI>; Thu, 3 Jan 2002 00:20:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285584AbSACFT7>; Thu, 3 Jan 2002 00:19:59 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:41997 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S284902AbSACFTp>; Thu, 3 Jan 2002 00:19:45 -0500
Message-ID: <3C33E8EA.FAF8E337@zip.com.au>
Date: Wed, 02 Jan 2002 21:15:22 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.17-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "M. Edward Borasky" <znmeb@aracnet.com>
CC: Art Hays <art@lsr.nei.nih.gov>, linux-kernel@vger.kernel.org
Subject: Re: kswapd etc hogging machine
In-Reply-To: <Pine.LNX.4.33.0201022214230.8413-100000@lsr-linux> <HBEHIIBBKKNOBLMPKCBBAECPEFAA.znmeb@aracnet.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"M. Edward Borasky" wrote:
> 
> ...
> There were a whole bunch of tuning parameters in the VM in 2.2 that got
> dropped in 2.4; maybe re-instating some of them and returning them to their
> rightful owner, the system administrator, would solve this problem once and
> for all.
> ...
> 
> Anyone else want to share my soapbox??? :))

Nope.  Not yet.

The VM system in Art's machine is not working correctly.  It is swapping
and evicting useful data when it should be dropping written-back write()
pages.  That's a bug, and there's no point in adding knobs to twiddle
the behaviour when the system clearly isn't working *as designed* yet.

If we reach the stage where everything is exactly operating as we designed
it to, and it _still_ fails under some usage patterns then yes, that's the
time to throw up our hands and add knobs.

But Art's kernel (what kernel is in RH7.2 anyway?  2.4.9 with vendor
hacks^Wfixes, I think) is nowhere near that stage.

And we, the kernel developers, should hang our heads over this.  A
vendor-released, stable kernel is performing terribly with such a
simple workload.  One year after the release of 2.4.0!

The good news is that 2.4.17 has pretty much slain this dragon.  The
-aa patches are better still, and 2.4.18 will be even better than
that.

So where does this leave Art Hays?  Yup, he's going to have to apply
the latest Service Pack.  The rawhide kernel appears to be at 2.4.16,
which isn't recent enough.  He'll need to build his own.  I'd recommend
2.4.17-rc2 with http://www.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.17rc2aa2.bz2
applied on top.

-
