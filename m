Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161148AbVICFfU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161148AbVICFfU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Sep 2005 01:35:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161147AbVICFfU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Sep 2005 01:35:20 -0400
Received: from mail.kroah.org ([69.55.234.183]:59879 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1161146AbVICFfS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Sep 2005 01:35:18 -0400
Date: Fri, 2 Sep 2005 22:28:21 -0700
From: Greg KH <greg@kroah.com>
To: David Teigland <teigland@redhat.com>
Cc: Arjan van de Ven <arjan@infradead.org>, linux-fsdevel@vger.kernel.org,
       akpm@osdl.org, linux-kernel@vger.kernel.org, linux-cluster@redhat.com
Subject: Re: GFS, what's remaining
Message-ID: <20050903052821.GA23711@kroah.com>
References: <20050901104620.GA22482@redhat.com> <1125574523.5025.10.camel@laptopd505.fenrus.org> <20050902094403.GD16595@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050902094403.GD16595@redhat.com>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 02, 2005 at 05:44:03PM +0800, David Teigland wrote:
> On Thu, Sep 01, 2005 at 01:35:23PM +0200, Arjan van de Ven wrote:
> 
> > +	gfs2_assert(gl->gl_sbd, atomic_read(&gl->gl_count) > 0,);
> 
> > what is gfs2_assert() about anyway? please just use BUG_ON directly
> > everywhere
> 
> When a machine has many gfs file systems mounted at once it can be useful
> to know which one failed.  Does the following look ok?
> 
> #define gfs2_assert(sdp, assertion)                                       \
> do {                                                                      \
>         if (unlikely(!(assertion))) {                                     \
>                 printk(KERN_ERR                                           \
>                         "GFS2: fsid=%s: fatal: assertion \"%s\" failed\n" \
>                         "GFS2: fsid=%s:   function = %s\n"                \
>                         "GFS2: fsid=%s:   file = %s, line = %u\n"         \
>                         "GFS2: fsid=%s:   time = %lu\n",                  \
>                         sdp->sd_fsname, # assertion,                      \
>                         sdp->sd_fsname,  __FUNCTION__,                    \
>                         sdp->sd_fsname, __FILE__, __LINE__,               \
>                         sdp->sd_fsname, get_seconds());                   \
>                 BUG();                                                    \

You will already get the __FUNCTION__ (and hence the __FILE__ info)
directly from the BUG() dump, as well as the time from the syslog
message (turn on the printk timestamps if you want a more fine grain
timestamp), so the majority of this macro is redundant with the BUG()
macro...

thanks,

greg k-h
