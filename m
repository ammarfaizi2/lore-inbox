Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263015AbTEGJK0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 05:10:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263016AbTEGJK0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 05:10:26 -0400
Received: from phoenix.infradead.org ([195.224.96.167]:6922 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S263015AbTEGJKX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 05:10:23 -0400
Date: Wed, 7 May 2003 10:22:56 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Michael Hunold <hunold@convergence.de>
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: [PATCH[[2.5][3-11] update dvb subsystem core
Message-ID: <20030507102256.B14040@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Michael Hunold <hunold@convergence.de>,
	linux-kernel@vger.kernel.org, torvalds@transmeta.com
References: <3EB7DCF0.2070207@convergence.de> <20030506220828.A19971@infradead.org> <3EB8C67A.4020500@convergence.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3EB8C67A.4020500@convergence.de>; from hunold@convergence.de on Wed, May 07, 2003 at 10:40:26AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 07, 2003 at 10:40:26AM +0200, Michael Hunold wrote:
> Hello Christoph,
> 
> > What the problem with 2.5, dvb and devfs? 
> 
> The main problem is that our development "dvb-kernel" CVS tree *should* 
> compile under 2.4 aswell, because most of the dvb-users don't want to 
> participate in kernel development in general, but only on the 
> development of the dvb subsystem. So work is done on the "dvb-kernel" 
> tree, which should be synced with the 2.5 kernel frequently.

That okay in principle, but I'd like to ask you nicely to not touch any
devfs-related stuff currently.  I'ts in flux and any external change
makes my life in cleaning up the mess a lot harder.

> > But first I have to fix the devfs API on 2.5 and randomly bringing
> > back old crap and lots of ifdefs in those changing areas won't help.
> 
> I understand. But delaying the dvb updates just because a few calls to 
> the devfs subsystem (which are now separated by #ifdefs and can easily 
> be found) is not a good option either, or is it?

I think it is :)  Esepcially as you don't just add ifdefs (which give
me lots of rejects and you much uglier code than just using the
compat header I'll send to lkml once I'm done with the API changes) but
you also change the code that's ifdefed for 2.5 to reverse change I
did.  There is a reason why I removed every occurance of devfs_handle_t
from all drivers and the particular reason is that it will go away in
the next series of patches.

