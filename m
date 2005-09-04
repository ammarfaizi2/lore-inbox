Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751315AbVIDJLu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751315AbVIDJLu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Sep 2005 05:11:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751312AbVIDJLt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Sep 2005 05:11:49 -0400
Received: from rgminet01.oracle.com ([148.87.122.30]:12417 "EHLO
	rgminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1751310AbVIDJLs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Sep 2005 05:11:48 -0400
Date: Sun, 4 Sep 2005 02:11:18 -0700
From: Joel Becker <Joel.Becker@oracle.com>
To: Andrew Morton <akpm@osdl.org>
Cc: phillips@istop.com, linux-cluster@redhat.com, wim.coekaerts@oracle.com,
       linux-fsdevel@vger.kernel.org, ak@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [Linux-cluster] Re: GFS, what's remaining
Message-ID: <20050904091118.GZ8684@ca-server1.us.oracle.com>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>, phillips@istop.com,
	linux-cluster@redhat.com, wim.coekaerts@oracle.com,
	linux-fsdevel@vger.kernel.org, ak@suse.de,
	linux-kernel@vger.kernel.org
References: <20050901104620.GA22482@redhat.com> <200509040022.37102.phillips@istop.com> <20050903214653.1b8a8cb7.akpm@osdl.org> <200509040240.08467.phillips@istop.com> <20050904002828.3d26f64c.akpm@osdl.org> <20050904080102.GY8684@ca-server1.us.oracle.com> <20050904011805.68df8dde.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050904011805.68df8dde.akpm@osdl.org>
X-Burt-Line: Trees are cool.
X-Red-Smith: Ninety feet between bases is perhaps as close as man has ever come to perfection.
User-Agent: Mutt/1.5.10i
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 04, 2005 at 01:18:05AM -0700, Andrew Morton wrote:
> > 	I thought I stated this in my other email.  We're not intending
> > to extend dlmfs.
> 
> Famous last words ;)

	Heh, of course :-)

> I don't buy the general "fs is nice because we can script it" argument,
> really.  You can just write a few simple applications which provide access
> to the syscalls (or the fs!) and then write scripts around those.

	I can't see how that works easily.  I'm not worried about a
tarball (eventually Red Hat and SuSE and Debian would have it).  I'm
thinking about this shell:

	exec 7</dlm/domainxxxx/lock1
	do stuff
	exec 7</dev/null

If someone kills the shell while stuff is doing, the lock is unlocked
because fd 7 is closed.  However, if you have an application to do the
locking:

	takelock domainxxx lock1
	do sutff
	droplock domainxxx lock1

When someone kills the shell, the lock is leaked, becuase droplock isn't
called.  And SEGV/QUIT/-9 (especially -9, folks love it too much) are
handled by the first example but not by the second.
	
Joel

-- 

"Same dancers in the same old shoes.
 You get too careful with the steps you choose.
 You don't care about winning but you don't want to lose
 After the thrill is gone."

Joel Becker
Senior Member of Technical Staff
Oracle
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127

