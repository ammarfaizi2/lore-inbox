Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268133AbUH1XpT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268133AbUH1XpT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Aug 2004 19:45:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268134AbUH1XpT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Aug 2004 19:45:19 -0400
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:24487 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S268133AbUH1XpJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Aug 2004 19:45:09 -0400
Message-ID: <41311907.7010605@namesys.com>
Date: Sat, 28 Aug 2004 16:45:11 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nikita Danilov <nikita@clusterfs.com>
CC: Christoph Hellwig <hch@lst.de>, Christophe Saout <christophe@saout.de>,
       Andrew Morton <akpm@osdl.org>, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, flx@namesys.com, torvalds@osdl.org,
       reiserfs-list@namesys.com, Alexander Zarochentcev <zam@namesys.com>
Subject: Re: reiser4 plugins
References: <20040825152805.45a1ce64.akpm@osdl.org>	<412D9FE6.9050307@namesys.com>	<20040826014542.4bfe7cc3.akpm@osdl.org>	<1093522729.9004.40.camel@leto.cs.pocnet.net>	<20040826124929.GA542@lst.de>	<1093525234.9004.55.camel@leto.cs.pocnet.net>	<20040826130718.GB820@lst.de>	<1093526273.11694.8.camel@leto.cs.pocnet.net>	<20040826132439.GA1188@lst.de>	<1093527307.11694.23.camel@leto.cs.pocnet.net>	<20040826134034.GA1470@lst.de>	<1093528683.11694.36.camel@leto.cs.pocnet.net>	<412E786E.5080608@namesys.com>	<16687.9051.311225.697109@thebsh.namesys.com>	<412F7A59.8060508@namesys.com>	<16687.33718.571411.76990@thebsh.namesys.com>	<41305619.9030401@namesys.com> <16688.36091.861155.985990@gargle.gargle.HOWL>
In-Reply-To: <16688.36091.861155.985990@gargle.gargle.HOWL>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nikita Danilov wrote:

> > 
> > Instead what I did was discuss with Zam at the time how it could be 
> > fixed, leave it off the website until Zam was given a chance to fix it, 
>
>It wasn't Zam. It was me to begin with. OVERWRITE and MODIFY phases were
>turned off after switching to large keys.
>
> 
>
The online repacker is the best technical fix for these problems.  Tight 
packing is generally more damaged in its layout by small changes than 
loose packing, and V4 is the ultimate tight packer.  It is not clear to 
me that making V4 pack more loosely is necessarily a good idea.  These 
phases disturb the original packing at flush time, and the other phases 
don't.  One solution to try is packing less tightly.  Maybe once every 
megabyte skip forward 1 megabyte, and once every 64 megabytes skip to a 
random disk location, when allocating large new atoms.  I think I prefer 
using a repacker, but we should try it and see.  The other solutions of 
the previous email should also help a lot.  The issues of layout in this 
are similar to the ones improved by the fibration plugin.

I remember talking with not just you but zam about how we could fix it, 
and there was too much in the queue of work, and everyone was 
complaining to me that we should be debugging not optimizing, and you 
were the only one who thought it was a big deal.  I guess you still 
think it is a big issue and I still think things are good enough to use 
without it.  I still think Zam understood the issues better than you did 
(allocation is his code not yours).

There are some layout optimizations that a repacker can do best.  Still, 
there are some rough spots in the current allocation policy, and we 
should look at it.

Probably you will have reason to howl if we setup a benchmark which 
disturbs things with these phases, runs the repacker (I hope to have one 
in 6 months), and then measures our read performance compared to other 
filesystems without a repacker....;-)

Hans
