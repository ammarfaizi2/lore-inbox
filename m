Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261745AbULUWdW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261745AbULUWdW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Dec 2004 17:33:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261860AbULUWdW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Dec 2004 17:33:22 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:8891 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261745AbULUWdS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Dec 2004 17:33:18 -0500
Date: Wed, 22 Dec 2004 09:32:42 +1100
From: Nathan Scott <nathans@sgi.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: "Nathaniel W. Filardo" <nwf@andrew.cmu.edu>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] XFS crash using Realtime Preemption patch
Message-ID: <20041222093242.B674830@wobbly.melbourne.sgi.com>
References: <Pine.LNX.4.60-041.0412182025220.5487@unix49.andrew.cmu.edu> <20041221104042.GA31843@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20041221104042.GA31843@elte.hu>; from mingo@elte.hu on Tue, Dec 21, 2004 at 11:40:43AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 21, 2004 at 11:40:43AM +0100, Ingo Molnar wrote:
> 
> * Nathaniel W. Filardo <nwf@andrew.cmu.edu> wrote:
> 
> > Hello all.
> > 
> > Using 2.6.10-rc3-mm1-V0.7.33-04 and TCFQ ver 17, I get the following
> > crash while trying to sync the portage tree, though the system seems
> > stable under interactive load (read: an rm command went OK prior to
> > this crash).
> > 
> > Machine is a 933MHz transmeta laptop with IDE disk.
> > 
> > Any more information you need?
> > --nwf;
> > 
> > kernel BUG at kernel/rt.c:1210!
> 
> Seems like an XFS bug at first sight. The BUG() means that an up_write()
> was done while a down_read() was active for the lock. Does XFS really do
> this?

That should definately not happen.  Something has gone wrong in
mrlock.h if so - or it could be the incore xfs_inode has been
trampled on, and the mrlock writer state has become inappropriately
set.. that would cause the wrong branch to be taken and we'd end
up with the situation you've described here.

cheers.

-- 
Nathan
