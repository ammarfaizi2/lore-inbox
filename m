Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291842AbSBAQlZ>; Fri, 1 Feb 2002 11:41:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291843AbSBAQlJ>; Fri, 1 Feb 2002 11:41:09 -0500
Received: from ns.caldera.de ([212.34.180.1]:6805 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S291852AbSBAQkO>;
	Fri, 1 Feb 2002 11:40:14 -0500
Date: Fri, 1 Feb 2002 17:40:01 +0100
From: Christoph Hellwig <hch@caldera.de>
To: Adam Keys <akeys@post.cis.smu.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][RFC] kthread abstraction
Message-ID: <20020201174001.A4448@caldera.de>
Mail-Followup-To: Christoph Hellwig <hch@caldera.de>,
	Adam Keys <akeys@post.cis.smu.edu>, linux-kernel@vger.kernel.org
In-Reply-To: <20020201163818.A32551@caldera.de> <20020201163337.DHBU26243.rwcrmhc51.attbi.com@there>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020201163337.DHBU26243.rwcrmhc51.attbi.com@there>; from akeys@post.cis.smu.edu on Fri, Feb 01, 2002 at 10:32:59AM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 01, 2002 at 10:32:59AM -0600, Adam Keys wrote:
> On February 01, 2002 09:38, Christoph Hellwig wrote:
> > Currently the startup of custom kernel threads contains lots
> > of duplicated code (and bugs!).
> 
> Very interesting and approachable patch.  Am I correct this replaces the API 
> for starting threads like bdflush and kswapd?  Is this just an API 
> cleanliness thing or is there a performance motivation?

It layers ontop of the old kernel_thread() API.
Currently all user had to duplicate the surrounding code - I've just
created a bunch of helper routines.

> >     void kthread_stop(struct kthread *kth)
> 
> Do you think you could get by just passing struct task_struct here?  I 
> realize that would make it less pleasant for calling functions.  However, it 
> would also prevent you from changing something else in the kthread in a later 
> version and catching a caller by surprise.

No - I need the other struct kthread fields - that's why the structure
exists in the first time..

	Christoph

-- 
Of course it doesn't work. We've performed a software upgrade.
