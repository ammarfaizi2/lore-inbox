Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261868AbTDKWty (for <rfc822;willy@w.ods.org>); Fri, 11 Apr 2003 18:49:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261877AbTDKWtx (for <rfc822;linux-kernel-outgoing>);
	Fri, 11 Apr 2003 18:49:53 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:33507 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S261868AbTDKWtw (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Apr 2003 18:49:52 -0400
Date: Fri, 11 Apr 2003 16:01:11 -0700
From: Greg KH <greg@kroah.com>
To: Andrew Morton <akpm@digeo.com>
Cc: Steven Dake <sdake@mvista.com>, kpfleming@cox.net,
       linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       message-bus-list@redhat.com
Subject: Re: [ANNOUNCE] udev 0.1 release
Message-ID: <20030411230111.GF3786@kroah.com>
References: <20030411172011.GA1821@kroah.com> <200304111746.h3BHk9hd001736@81-2-122-30.bradfords.org.uk> <20030411182313.GG25862@wind.cocodriloo.com> <3E970A00.2050204@cox.net> <3E9725C5.3090503@mvista.com> <20030411150933.43fd9a84.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030411150933.43fd9a84.akpm@digeo.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 11, 2003 at 03:09:33PM -0700, Andrew Morton wrote:
> Steven Dake <sdake@mvista.com> wrote:
> >
> > A much better solution could be had by select()ing on a filehandle 
> > indicating when a new hotswap event is ready to be processed.  No races, 
> > no security issues, no performance issues.
> 
> I must say that I've always felt this to be a better approach than the
> /sbin/hotplug callout.
> 
> Apart from the performance issue, it means that the kernel can buffer the
> "insertion" events which happen at boot-time discovery until the userspace
> handler attaches itself.

But how many events to we buffer?  When do we start to throw them away?
Fun policy decisions that we don't have to worry about in the current
scheme.

Also, what's the format of the kernel->user interface.  Today with
/sbin/hotplug it's a very simple, and easily changed interaction.  Using
a event reading mechanism lends itself to binary interfaces, which have
to be kept in sync with user code very tightly.

And yes, we could use ascii in the event list, but then again, a
userspace version of /sbin/hotplug that writes events to a pipe that is
read from a daemon enables the same thing to happen :)

thanks,

greg k-h
