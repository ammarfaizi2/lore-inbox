Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263832AbTLEDX7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Dec 2003 22:23:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263836AbTLEDX7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Dec 2003 22:23:59 -0500
Received: from mtvcafw.SGI.COM ([192.48.171.6]:37465 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id S263832AbTLEDX4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Dec 2003 22:23:56 -0500
Date: Fri, 5 Dec 2003 14:20:23 +1100
From: Nathan Scott <nathans@sgi.com>
To: "Kevin P. Fleming" <kpfleming@backtobasicsmgmt.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Jens Axboe <axboe@suse.de>,
       David =?iso-8859-1?Q?Mart=EDnez?= Moreno <ender@debian.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       clubinfo.servers@adi.uam.es, Ingo Molnar <mingo@elte.hu>,
       Neil Brown <neilb@cse.unsw.edu.au>
Subject: Re: Errors and later panics in 2.6.0-test11.
Message-ID: <20031205032023.GB1693@frodo>
References: <200312031417.18462.ender@debian.org> <Pine.LNX.4.58.0312030757120.5258@home.osdl.org> <20031203162045.GA27964@suse.de> <Pine.LNX.4.58.0312030823010.5258@home.osdl.org> <3FCE1C87.2050006@backtobasicsmgmt.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FCE1C87.2050006@backtobasicsmgmt.com>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 03, 2003 at 10:25:27AM -0700, Kevin P. Fleming wrote:
> Linus Torvalds wrote:
> 
> >The ones I've seen seem to be raid-0, but Nathan (nathans@sgi.com)
> >reported problems in RAID-5 under load. I didn't decode the full oops on
> >that one, but it really looked like a stale "bi" bio that trapped on the
> >PAGE_ALLOC debug code.
> 
> The problem I reported was also with RAID-5, and I have also found a 
> problem similar to Nathan's (probably the same one) by just trying to 
> run bonnie++ on an XFS filesystem on DM over RAID-5, even after 
> formatting the XFS filesystem to forcibly align everything to RAID-5 
> stripes (64K units).

FWIW, this doesn't align _everything_ (space allocations done
through the XFS allocator are influenced, which means "most")
-- log IO is still going to be sector aligned, as are any IOs
to the four XFS allocation group header metadata structures.

cheers.

-- 
Nathan
