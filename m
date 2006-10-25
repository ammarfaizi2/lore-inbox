Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423128AbWJYIjY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423128AbWJYIjY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Oct 2006 04:39:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423135AbWJYIjY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Oct 2006 04:39:24 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:23489 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1423128AbWJYIjW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Oct 2006 04:39:22 -0400
Date: Wed, 25 Oct 2006 18:38:30 +1000
From: David Chinner <dgc@sgi.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: David Chinner <dgc@sgi.com>, "Rafael J. Wysocki" <rjw@sisk.pl>,
       Nigel Cunningham <ncunningham@linuxmail.org>,
       Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       xfs@oss.sgi.com
Subject: Re: [PATCH] Freeze bdevs when freezing processes.
Message-ID: <20061025083830.GI11034@melbourne.sgi.com>
References: <1161576735.3466.7.camel@nigel.suspend2.net> <200610231236.54317.rjw@sisk.pl> <20061024144446.GD11034@melbourne.sgi.com> <200610241730.00488.rjw@sisk.pl> <20061024163345.GG11034@melbourne.sgi.com> <20061024213737.GD5662@elf.ucw.cz> <20061025001331.GP8394166@melbourne.sgi.com> <20061025081001.GL5851@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061025081001.GL5851@elf.ucw.cz>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 25, 2006 at 10:10:01AM +0200, Pavel Machek wrote:
> > Hence the only way to correctly rebuild the XFS state on resume is
> > to quiesce the filesystem on suspend and thaw it on resume so as to
> > trigger log recovery.
> 
> No, during suspend/resume, memory image is saved, and no state is
> lost. We would not even have to do sys_sync(), and suspend/resume
> would still work properly.

It seems to me that you ensure the filesystem is synced to disk and
then at some point later you record the memory state of the
filesystem, but these happen at different times. That leaves a
window for things to get out of sync again, right?

Cheers,

Dave.

-- 
Dave Chinner
Principal Engineer
SGI Australian Software Group
