Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264087AbTEWPup (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 May 2003 11:50:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264088AbTEWPuo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 May 2003 11:50:44 -0400
Received: from h68-147-142-75.cg.shawcable.net ([68.147.142.75]:48120 "EHLO
	schatzie.adilger.int") by vger.kernel.org with ESMTP
	id S264087AbTEWPun (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 May 2003 11:50:43 -0400
Date: Fri, 23 May 2003 10:02:14 -0600
From: Andreas Dilger <adilger@clusterfs.com>
To: Andrew Morton <akpm@digeo.com>
Cc: Alex Tomas <bzzz@tmi.comex.ru>, linux-kernel@vger.kernel.org,
       ext2-devel@lists.sourceforge.net
Subject: Re: [Ext2-devel] Re: [RFC] probably invalid accounting in jbd
Message-ID: <20030523100214.B16920@schatzie.adilger.int>
Mail-Followup-To: Andrew Morton <akpm@digeo.com>,
	Alex Tomas <bzzz@tmi.comex.ru>, linux-kernel@vger.kernel.org,
	ext2-devel@lists.sourceforge.net
References: <87d6igmarf.fsf@gw.home.net> <1053376482.11943.15.camel@sisko.scot.redhat.com> <87he7qe979.fsf@gw.home.net> <1053377493.11943.32.camel@sisko.scot.redhat.com> <87addhd2mc.fsf@gw.home.net> <20030521093848.59ada625.akpm@digeo.com> <871xypx62o.fsf_-_@gw.home.net> <20030523012636.1d272586.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030523012636.1d272586.akpm@digeo.com>; from akpm@digeo.com on Fri, May 23, 2003 at 01:26:36AM -0700
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On May 23, 2003  01:26 -0700, Andrew Morton wrote:
> umm, one possible solution to that is to rework the t_outstanding_credits
> logic so that we instead record:
> 
> 	number of buffers attached to the transaction +
> 		sum of the initial size of all currently-running handles.
> 
> as each handle is closed off, we subtract its initial size from the above
> metric.  Any buffers which that handle happened to add to the lists would
> have already been accounted for, when they were added.

One other benefit of doing it that way is that having the original handle
size kept in the handle means that you can properly flag errors when a
nested transaction is "started" on an existing handle and the new start
wants more credits than were actually in the handle.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

