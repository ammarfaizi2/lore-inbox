Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751192AbVIDFuD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751192AbVIDFuD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Sep 2005 01:50:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751207AbVIDFuD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Sep 2005 01:50:03 -0400
Received: from rgminet02.oracle.com ([148.87.122.31]:52562 "EHLO
	rgminet02.oracle.com") by vger.kernel.org with ESMTP
	id S1751192AbVIDFt7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Sep 2005 01:49:59 -0400
Date: Sat, 3 Sep 2005 22:49:37 -0700
From: Joel Becker <Joel.Becker@oracle.com>
To: linux clustering <linux-cluster@redhat.com>
Cc: phillips@istop.com, linux-fsdevel@vger.kernel.org, ak@suse.de,
       linux-kernel@vger.kernel.org
Subject: Re: [Linux-cluster] Re: GFS, what's remaining
Message-ID: <20050904054936.GW8684@ca-server1.us.oracle.com>
Mail-Followup-To: linux clustering <linux-cluster@redhat.com>,
	phillips@istop.com, linux-fsdevel@vger.kernel.org, ak@suse.de,
	linux-kernel@vger.kernel.org
References: <20050901104620.GA22482@redhat.com> <20050903183241.1acca6c9.akpm@osdl.org> <20050904030640.GL8684@ca-server1.us.oracle.com> <200509040022.37102.phillips@istop.com> <20050903214653.1b8a8cb7.akpm@osdl.org> <20050904045821.GT8684@ca-server1.us.oracle.com> <20050903224140.0442fac4.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050903224140.0442fac4.akpm@osdl.org>
X-Burt-Line: Trees are cool.
X-Red-Smith: Ninety feet between bases is perhaps as close as man has ever come to perfection.
User-Agent: Mutt/1.5.10i
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 03, 2005 at 10:41:40PM -0700, Andrew Morton wrote:
> Are you saying that the posix-file lookalike interface provides access to
> part of the functionality, but there are other APIs which are used to
> access the rest of the functionality?  If so, what is that interface, and
> why cannot that interface offer access to 100% of the functionality, thus
> making the posix-file tricks unnecessary?

	Currently, this is all the interface that the OCFS2 DLM
provides.  But yes, if you wanted to provide the rest of the VMS
functionality (something that GFS2's DLM does), you'd need to use a more
concrete interface.
	IMHO, it's worthwhile to have a simple interface, one already
used by mkfs.ocfs2, mount.ocfs2, fsck.ocfs2, etc.  This is an interface
that can and is used by shell scripts even (we do this to test the DLM).
If you make it a C-library-only interface, you've just restricted the
subset of folks that can use it, while adding programming complexity.
	I think that a simple fs-based interface can coexist with a more
complex one.  FILE* doesn't give you the flexibility of read()/write(),
but I wouldn't remove it :-)

Joel

-- 

"In the beginning, the universe was created. This has made a lot 
 of people very angry, and is generally considered to have been a 
 bad move."
        - Douglas Adams

Joel Becker
Senior Member of Technical Staff
Oracle
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127
