Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750743AbVKJJ5c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750743AbVKJJ5c (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 04:57:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750741AbVKJJ5c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 04:57:32 -0500
Received: from mail.dvmed.net ([216.237.124.58]:20716 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1750743AbVKJJ5b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 04:57:31 -0500
Message-ID: <43731980.3020802@pobox.com>
Date: Thu, 10 Nov 2005 04:57:20 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Jens Axboe <axboe@suse.de>, James.Bottomley@SteelEye.com,
       torvalds@osdl.org, linux-kernel@vger.kernel.org, len.brown@intel.com,
       tony.luck@intel.com, bcollins@debian.org, scjody@modernduck.com,
       dwmw2@infradead.org, rolandd@cisco.com, davej@codemonkey.org.uk,
       shaggy@austin.ibm.com, sfrench@us.ibm.com
Subject: git branches strategy (was Re: merge status)
References: <20051109133558.513facef.akpm@osdl.org>	<1131573041.8541.4.camel@mulgrave>	<Pine.LNX.4.64.0511091358560.4627@g5.osdl.org>	<1131575124.8541.9.camel@mulgrave>	<20051109150141.0bcbf9e3.akpm@osdl.org>	<20051110084025.GW3699@suse.de>	<20051110005653.3cb2c90f.akpm@osdl.org>	<20051110092241.GY3699@suse.de> <20051110013055.77120a56.akpm@osdl.org>
In-Reply-To: <20051110013055.77120a56.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Most of the other git-tree maintainers don't bother with any of that. 
> acpi, agp, alsa, arm, ...  xfs.  The trees which have special -mm branches
> are just drm, ieee1394, jfs, mips and netdev.

[related tangent, in case this is useful to others]

It's not quite correct to say that I have a special -mm branch.  In my 
two primary work areas, libata-dev.git and netdev-2.6.git, I have a 
bunch of branches, which fall into three categories:

	'master':	vanilla upstream Linus tree
	themes:		various patch queues, each for a single purpose.

			standard patch queues include...

			upstream: stuff queued for upstream
			upstream-fixes: stuff queued for -rc

			8139-thread: example non-upstream dev branch
			ncq: another non-upstream dev branch

	'ALL':		a superset merge of all theme branches which
			are considered OK for testing by brave users.

The 'ALL' superset branch is not only what you (Andrew) pull into -mm, 
its also the basis for -libataN and -netdevN patches, and in general the 
best way for users to slurp "all the useful bits."

Using theme branches and a superset branch allows for maximum parallel 
development -- even applying conflicting patches -- and then using git 
to merge them together.  The separated-out branches also allow for 
fine-grained selection of the material to push upstream, i.e. no false 
dependencies, easier cherrypicking.

I've actually worked this way since the early BitKeeper days; BK didn't 
make it easy for me to export the tons of local theme branches I 
manipulated, just the superset branch.  Since git makes it easy, you 
finally get the full picture of libata/netdev development, and the best 
of both worlds:  both a superset branch (easy testing) and theme 
branches (parallel development).

	Jeff


