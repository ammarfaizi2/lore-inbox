Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265410AbUIAKNg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265410AbUIAKNg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 06:13:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265207AbUIAKLn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 06:11:43 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:26884 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S265410AbUIAKKH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 06:10:07 -0400
Date: Wed, 1 Sep 2004 11:09:44 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Miquel van Smoorenburg <miquels@cistron.nl>
Cc: lkml@lpbproductions.com, Timothy Miller <miller@techsource.com>,
       linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: 3ware queue depth [was: Re: HIGHMEM4G config for 1GB RAM on desktop?]
Message-ID: <20040901110944.A10160@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Miquel van Smoorenburg <miquels@cistron.nl>,
	lkml@lpbproductions.com, Timothy Miller <miller@techsource.com>,
	linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
References: <200408021602.34320.swsnyder@insightbb.com> <1094030083l.3189l.2l@traveler> <1094030194l.3189l.3l@traveler> <200409010233.31643.lkml@lpbproductions.com> <1094032735l.3189l.7l@traveler>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1094032735l.3189l.7l@traveler>; from miquels@cistron.nl on Wed, Sep 01, 2004 at 09:58:55AM +0000
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 01, 2004 at 09:58:55AM +0000, Miquel van Smoorenburg wrote:
> On 2004.09.01 11:33, Matt Heler wrote:
> >
> > I have a 3ware 7000-2 card. And I noticed the same problem. 
> > 
> > Actually what I just did now was change the max luns from 254 to 64. 
> > Recompiled and booted up. This seems to fix all my problems, and the speed 
> > seems to be quite faster then before.
> 
> Yes, that is because the queue_depth parameter gets set from
> TW_MAX_CMDS_PER_LUN by the 3w-xxxx.c driver ...
> 
> I found the 3ware patch. The patch below makes the queue depth
> an optional module parameter, makes sure that the initial
> nr_requests is twice the size of the queue_depth, and
> makes queue_depth writable for the 3ware driver.

 - the writeable queue_depth sysfs attr is fine,
 - the reverse_scan option is vetoed because it can't be supported when
   the driver will be converted to the pci_driver interface (soon)
 - I'm not so sure about the module parameter, what's the problem of beeing
   able to only change the queue depth once sysfs is mounted?

