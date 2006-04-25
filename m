Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932114AbWDYSEE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932114AbWDYSEE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 14:04:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932113AbWDYSEE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 14:04:04 -0400
Received: from mx1.redhat.com ([66.187.233.31]:4268 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932103AbWDYSEC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 14:04:02 -0400
Date: Tue, 25 Apr 2006 13:04:33 -0500
From: David Teigland <teigland@redhat.com>
To: "Artem B. Bityutskiy" <dedekind@oktetlabs.ru>
Cc: Steven Whitehouse <swhiteho@redhat.com>, Andrew Morton <akpm@osdl.org>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 12/16] GFS2: Mounting & sysfs interface
Message-ID: <20060425180433.GA17525@redhat.com>
References: <1145636505.3856.116.camel@quoit.chygwyn.com> <444E53FC.5060100@oktetlabs.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <444E53FC.5060100@oktetlabs.ru>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 25, 2006 at 08:53:16PM +0400, Artem B. Bityutskiy wrote:
> Hello,
> 
> last time I tried to use "bare" sysfs functions to create my sysfs 
> hierarchy I ended up with a problem that the module refcount is not 
> increased when those sysfs files are opened. So I could open a sysfs 
> file from userspace, do rmmod and enjoy oops.
> 
> Then I started using the class and class_device stuff, which have an 
> .owner field, and all became fine.
> 
> I'm not sure if this is a problem of sysfs, but I suspect it could take 
> care of module refcount better.
> 
> In your patch, I looked for THIS_MODULE pattern and did not find. I did 
> not try, but I suspect your code is not devoid of the problem I 
> described. So, this is just FYI and may be not the case.

Others have also alluded to /sys/fs/ races that we'll probably need to
resolve.  In this case the question is more about umount than rmmod since
the mount should reference the module.

Thanks,
Dave

