Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751920AbWJWL3b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751920AbWJWL3b (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 07:29:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751922AbWJWL3b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 07:29:31 -0400
Received: from rgminet01.oracle.com ([148.87.113.118]:53704 "EHLO
	rgminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1751920AbWJWL3a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 07:29:30 -0400
Date: Mon, 23 Oct 2006 07:29:20 -0400
From: Chris Mason <chris.mason@oracle.com>
To: Brice Figureau <brice+lklm@daysofwonder.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Sluggish system while copying large files.
Message-ID: <20061023112920.GA5560@think.oraclecorp.com>
References: <1160747774.7929.53.camel@localhost.localdomain> <20061018150901.GC16570@think.oraclecorp.com> <1161596405.473.29.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1161596405.473.29.camel@localhost.localdomain>
User-Agent: Mutt/1.5.12-2006-07-14
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 23, 2006 at 11:40:05AM +0200, Brice Figureau wrote:
> 
> I'll try the data=writeback mount option. Is it possible to remount the
> partition and change the journal option on a running system?

Not with ext3, sorry.

> 
> > Since mysql is probably triggering tons of fsyncs or O_SYNC writes,
> > you may want to increase the size of the ext3 log.
> 
> Mysql is using O_DIRECT for its datafile. I don't know how it relates to
> the sync things, but I guess that to be truly ACID, it has to fsync the
> files on each transactions.
> How can I increase the ext3 log ?
> Any idea of the size I should use (and what is the default) ?

Even when using O_DIRECT, if the file is extended an FS commit is
triggered to record the extension.
> 
> > If mysql is constantly appending to the files holding your tables, the
> > synchronous writes are more expensive and log intensive.  Check your
> > setup to see if you can manually extend any of those files to avoid
> > constantly growing table files.
> 
> The use of a battery-backed RAID cache should mitigate the sync writes,
> and since our mysql load is quite low, the machine shouldn't definitely
> freeze for seconds while copying files.

Ok, I would start with only doing data=writeback.  That is probably a
big part of the problem.

-chris

