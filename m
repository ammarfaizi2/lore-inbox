Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030419AbWFITQR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030419AbWFITQR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 15:16:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030418AbWFITQR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 15:16:17 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:36505 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1030395AbWFITQQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 15:16:16 -0400
Message-ID: <4489C8FA.4070403@garzik.org>
Date: Fri, 09 Jun 2006 15:16:10 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: adilger@clusterfs.com, torvalds@osdl.org, alex@clusterfs.com,
       ext2-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       cmm@us.ibm.com, linux-fsdevel@vger.kernel.org
Subject: Re: [Ext2-devel] [RFC 0/13] extents and 48bit ext3
References: <1149816055.4066.60.camel@dyn9047017069.beaverton.ibm.com>	<4488E1A4.20305@garzik.org>	<20060609083523.GQ5964@schatzie.adilger.int>	<44898EE3.6080903@garzik.org>	<448992EB.5070405@garzik.org>	<Pine.LNX.4.64.0606090836160.5498@g5.osdl.org>	<m33beecntr.fsf@bzzz.home.net>	<Pine.LNX.4.64.0606090913390.5498@g5.osdl.org>	<Pine.LNX.4.64.0606090933130.5498@g5.osdl.org>	<20060609181020.GB5964@schatzie.adilger.int>	<4489C0B8.7050400@garzik.org> <20060609115936.2fdda6d0.akpm@osdl.org>
In-Reply-To: <20060609115936.2fdda6d0.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.2 (----)
X-Spam-Report: SpamAssassin version 3.1.1 on srv5.dvmed.net summary:
	Content analysis details:   (-4.2 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> On Fri, 09 Jun 2006 14:40:56 -0400
> Jeff Garzik <jeff@garzik.org> wrote:
> 
>> Andreas Dilger wrote:
>>> Having a single codebase for everyone means that it is continually maintained
>>> and users of ext3 aren't left out in the cold.
>> That implies continually upgrading ext3 for newer storage technologies, 
>> which in turn implies adding all sorts of incompatible formats to 
>> support better storage scaling, and new usage models.
> 
> Look, I'm not certain either way on this - I really don't like the format
> incompatibility and I'd like to see a breakdown of the performance benefits
> of each of the proposed new features so perhaps we can cherrypick.  And I'm
> deferring judgement until I've looked at some patches.
> 
> But Jeff, please stop this wild exaggeration!  "continually upgrading",
> "all sorts of incompatible formats".  It's not helping anything.  
> 
> Today's ext3 is, afaik, 100% on-disk compatible with ext3 from five years
> ago, and probably with RH's 2.2-based implementation.  So we have not done
> and will not do the things which you are FUDding us about.
> 
> This is (again, as far as I recall) the first on-disk-incompatible change
> in ext3 which has ever been proposed.  It's not a thing which is done
> lightly and it's not a thing which is likely to happen again for a very long
> time indeed.

That's not really true, I include in the list EXT3_FEATURE_RO_COMPAT_*, 
EXT3_FEATURE_INCOMPAT_*, 32-bit uid/gid, ISTR some ACL-related mess, and 
the online resizing stuff that produces a filesystem slightly different 
than what mke2fs would produce for the same [larger] sized block device. 
  Red Hat has had at least one problem in the past where users were 
annoyed at format changes (htree?).

I certainly grant that extents and 48bit are format changes on a -much- 
larger scale than in the past.  Absolutely.

That's why I feel that this is a good point to calm down ext3 
development, and start putting stuff like extents into ext4.  If we are 
starting to make major changes to the format, that should be a signal 
that we are starting to work on a new filesystem, rather than patching 
an old one.

I disagree with the "years to stabilize ext4" argument, because we are 
starting from a known good point.  I think ext4 will be easier to 
maintain and tune for modern storage systems, if we don't have to worry 
as much about that stuff for ext3.

	Jeff


