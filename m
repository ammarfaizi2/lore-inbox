Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751087AbWCGLGK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751087AbWCGLGK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 06:06:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751551AbWCGLGK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 06:06:10 -0500
Received: from e32.co.us.ibm.com ([32.97.110.150]:15819 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751087AbWCGLGI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 06:06:08 -0500
Date: Tue, 7 Mar 2006 16:35:53 +0530
From: Balbir Singh <balbir@in.ibm.com>
To: Kirill Korotaev <dev@sw.ru>
Cc: Neil Brown <neilb@suse.de>, Balbir Singh <bsingharora@gmail.com>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Olaf Hering <olh@suse.de>, Jan Blunck <jblunck@suse.de>,
       Kirill Korotaev <dev@openvz.org>, Al Viro <viro@ftp.linux.org.uk>
Subject: Re: [PATCH] Busy inodes after unmount, be more verbose in generic_shutdown_super
Message-ID: <20060307110553.GA15796@in.ibm.com>
Reply-To: balbir@in.ibm.com
References: <17414.38749.886125.282255@cse.unsw.edu.au> <17419.53761.295044.78549@cse.unsw.edu.au> <661de9470603052332s63fd9b2crd60346324af27fbf@mail.gmail.com> <17420.59580.915759.44913@cse.unsw.edu.au> <440D2536.60005@sw.ru> <20060307070301.GA12165@in.ibm.com> <440D3475.4040603@sw.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <440D3475.4040603@sw.ru>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >Given that background, I thought our main concern was with respect to
> >unmount. The race was between shrink_dcache_parent() (called from unmount)
> >and shrink_dcache_memory() (called from the allocator), hence the fix
> >for the race condition.
> Partial fix doesn't make much sense from my point of view.
>

IMHO, It was not a partial fix. slab_drop() addition changed the assumptions
used by this fix 
 
> >I just noticied that 2.6.16-rc* now seems to have drop_slab() where
> >PF_MEMALLOC is not set. So, we can still race with my fix if there
> >if /proc/sys/vm/drop_caches is written to and unmount is done in parallel.
> >
> >A simple hack would be to set PF_MEMALLOC in drop_slab(), but I do not
> >think it is a good idea.
> Yeah, playing with PF_MEMALLOC can be not so good idea :/
> And as it doesn't help in other cases it looks unpromising...

Yes, agreed.

> 
> >>>Have you had any other feedback on this?
> >>here it is :)
> >Thanks for your detailed feedback
> Sorry, that I did it too late :/
> 

No problem

> Thanks,
> Kirill
> 

Balbir
