Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272224AbTGYRDt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jul 2003 13:03:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272225AbTGYRDt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jul 2003 13:03:49 -0400
Received: from bristol.phunnypharm.org ([65.207.35.130]:59296 "EHLO
	bristol.phunnypharm.org") by vger.kernel.org with ESMTP
	id S272224AbTGYRDs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jul 2003 13:03:48 -0400
Date: Fri, 25 Jul 2003 13:07:53 -0400
From: Ben Collins <bcollins@debian.org>
To: Sam Bromley <sbromley@cogeco.ca>, Torrey Hoffman <thoffman@arnor.net>,
       gaxt <gaxt@rogers.com>, Linux Kernel <linux-kernel@vger.kernel.org>,
       linux firewire devel <linux1394-devel@lists.sourceforge.net>
Subject: Re: Firewire
Message-ID: <20030725170753.GC14038@phunnypharm.org>
References: <1059103424.24427.108.camel@daedalus.samhome.net> <20030725041234.GX1512@phunnypharm.org> <20030725053920.GH23196@ruvolo.net> <20030725133438.GZ1512@phunnypharm.org> <20030725142907.GI23196@ruvolo.net> <20030725142926.GD1512@phunnypharm.org> <20030725154009.GF1512@phunnypharm.org> <20030725160706.GK23196@ruvolo.net> <20030725161803.GJ1512@phunnypharm.org> <20030725170255.GN23196@ruvolo.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030725170255.GN23196@ruvolo.net>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 25, 2003 at 10:02:55AM -0700, Chris Ruvolo wrote:
> On Fri, Jul 25, 2003 at 12:18:04PM -0400, Ben Collins wrote:
> > Ok, in ieee1394_core.c, when it does the "packet removed in
> > abort_timedouts" could you make it print the value of jiffies, expire
> > and packet->sendtime?
> 
> 
> So, abort_timedouts() is called by the scheduler as part of work queue
> handling?  Every HZ or based on the expire timeout?

Hmm. It's scheduled as soon as there are pending_packets, and it is
rescheduled as long as the pending_packets list isn't empty. Maybe it
isn't relinquishing enough time to the nodemgr to get it's job done.

I think that's the problem. Let me code up a patch.


-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
