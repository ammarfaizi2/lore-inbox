Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932201AbVIEEZO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932201AbVIEEZO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Sep 2005 00:25:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932200AbVIEEZO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Sep 2005 00:25:14 -0400
Received: from mx1.redhat.com ([66.187.233.31]:59602 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932198AbVIEEZL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Sep 2005 00:25:11 -0400
Date: Mon, 5 Sep 2005 12:30:33 +0800
From: David Teigland <teigland@redhat.com>
To: akpm@osdl.org, Joel.Becker@oracle.com, ak@suse.de
Cc: linux-cluster@redhat.com, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [Linux-cluster] Re: GFS, what's remaining
Message-ID: <20050905043033.GB11337@redhat.com>
References: <20050901104620.GA22482@redhat.com> <20050903183241.1acca6c9.akpm@osdl.org> <20050904030640.GL8684@ca-server1.us.oracle.com> <200509040022.37102.phillips@istop.com> <20050903214653.1b8a8cb7.akpm@osdl.org> <20050904045821.GT8684@ca-server1.us.oracle.com> <20050903224140.0442fac4.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050903224140.0442fac4.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 03, 2005 at 10:41:40PM -0700, Andrew Morton wrote:
> Joel Becker <Joel.Becker@oracle.com> wrote:
> >
> >  > What happens when we want to add some new primitive which has no
> >  > posix-file analog?
> > 
> >  	The point of dlmfs is not to express every primitive that the
> >  DLM has.  dlmfs cannot express the CR, CW, and PW levels of the VMS
> >  locking scheme.  Nor should it.  The point isn't to use a filesystem
> >  interface for programs that need all the flexibility and power of the
> >  VMS DLM.  The point is a simple system that programs needing the basic
> >  operations can use.  Even shell scripts.
> 
> Are you saying that the posix-file lookalike interface provides access to
> part of the functionality, but there are other APIs which are used to
> access the rest of the functionality?  If so, what is that interface, and
> why cannot that interface offer access to 100% of the functionality, thus
> making the posix-file tricks unnecessary?

We're using our dlm quite a bit in user space and require the full dlm
API.  It's difficult to export the full API through a pseudo fs like
dlmfs, so we've not found it a very practical approach.  That said, it's a
nice idea and I'd be happy if someone could map a more complete dlm API
onto it.

We export our full dlm API through read/write/poll on a misc device.  All
user space apps use the dlm through a library as you'd expect.  The
library communicates with the dlm_device kernel module through
read/write/poll and the dlm_device module talks with the actual dlm:
linux/drivers/dlm/device.c  If there's a better way to do this, via a
pseudo fs or not, we'd be pleased to try it.

Dave

