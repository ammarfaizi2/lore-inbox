Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933187AbWKMX6H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933187AbWKMX6H (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 18:58:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933188AbWKMX6G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 18:58:06 -0500
Received: from cantor2.suse.de ([195.135.220.15]:61633 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S933187AbWKMX6E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 18:58:04 -0500
From: Neil Brown <neilb@suse.de>
To: Jurriaan <thunder7@xs4all.nl>
Date: Tue, 14 Nov 2006 10:57:57 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17753.1669.983918.956944@cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: trouble with mounting a 1.5 TB raid6 volume in 2.6.19-rc5-mm1
In-Reply-To: message from thunder7@xs4all.nl on Monday November 13
References: <20061111183835.GA3801@amd64.of.nowhere>
	<17751.64583.924110.954687@cse.unsw.edu.au>
	<17752.15962.816035.80638@cse.unsw.edu.au>
	<20061113174341.GA3819@amd64.of.nowhere>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday November 13, thunder7@xs4all.nl wrote:
> From: Neil Brown <neilb@suse.de>
> Date: Mon, Nov 13, 2006 at 08:43:54PM +1100
> > On Monday November 13, neilb@suse.de wrote:
> > > 
> > > Can you try reverting this patch (patch -p1 -R) ?
> > > 
> > 
> > Yes, I'm confident that reverting that patch will fix your problem.
> > I actually found a number of errors while tracking this down :-(
> 
> Oops. Do you have some kind of test-suite to run on md-devices before
> releasing a patch? I didn't think my hardware was that exotic.

Yes, I have a test suite (part of the mdadm package - anyone can try
running it - "make everything ; sh test").
The trouble is that I don't run it as often as I should.  I plan to
fix that, but it really needs to run automatically to be reliable - I
can't be trusted to run it when required. :-(
I've taken steps to setting something up to that it does run
automagically every night against various kernels, but there is still
a way to go...

It did catch this raid6 problem when I did run it, but there were a
few other bugs in there that the test suite would not have found
(e.g. one was a memory leak and checking generically for memory leaks
is not trivial).

> 
> I had a scary moment just now, since 2.6.19-rc5-mm1 without your patch
> wanted to fsck the volume, and started repairing errors which didn't
> exist on disk. Luckily, it stopped before inode 64, and I was able to
> fsck the volume on an earlier kernel without apparent damage.
> 
> Still, a test suite seems like a good idea. Also, getting Andrew to
> either add this as a hot-fix or release -mm2 would be a good idea,
> IMVHO.

I'll suggest something when I submit the patches which fix all the
bugs I found (test-suite still running just at the moment).

NeilBrown
