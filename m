Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261847AbVDUUIs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261847AbVDUUIs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Apr 2005 16:08:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261848AbVDUUIs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Apr 2005 16:08:48 -0400
Received: from rrcs-24-227-247-8.sw.biz.rr.com ([24.227.247.8]:10387 "EHLO
	emachine.austin.ammasso.com") by vger.kernel.org with ESMTP
	id S261847AbVDUUIi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Apr 2005 16:08:38 -0400
Message-ID: <4268080E.3000303@ammasso.com>
Date: Thu, 21 Apr 2005 15:07:42 -0500
From: Timur Tabi <timur.tabi@ammasso.com>
Organization: Ammasso
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en, en-gb
MIME-Version: 1.0
To: Andy Isaacson <adi@hexapodia.org>
CC: Troy Benjegerdes <hozer@hozed.org>, Bernhard Fischer <blist@aon.at>,
       Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org,
       openib-general@openib.org
Subject: Re: [openib-general] Re: [PATCH][RFC][0/4] InfiniBand userspace verbs
 implementation
References: <20050421173821.GA13312@hexapodia.org> <4267F367.3090508@ammasso.com> <20050421195641.GB13312@hexapodia.org>
In-Reply-To: <20050421195641.GB13312@hexapodia.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Isaacson wrote:

> I'm familiar with MPI 1.0 and 2.0, but I haven't been following the
> development of modern messaging APIs, so I might not make sense here...
> 
> Assuming that the app calls into the library on a fairly regular basis,

Not really.  The whole point is to have the adapter DMA the data directly from memory to 
the network.  That's why it's called RDMA - remote DMA.

> Therefore, cluster admins are going to do their
> darndest to avoid this behavior, so we might as well just kill the job
> and make it explicit.

Yes, and if it turns out that the same MPI application dies on Linux but not on Solaris 
because Linux doesn't really care if the memory stays pinned, then we're going to see a 
lot of MPI customers transitioning away from Linux.

> *You* need to come up with a solution that looks good to *the community*
> if you want it merged.  

True, but I'm not going to waste my time adding this support if the consensus I get from 
the kernel developers that they don't want Linux to behave this way.

> Do you guys simply raise RLIMIT_MEMLOCK to allow apps to lock their
> pages?  Or are you doing something more nasty?

A little more nasty.  I raise RLIMIT_MEMLOCK in the driver to "unlimited" and also set 
cap_raise(IPC_LOCK).  I do this because I need to support all 2.4 and 2.6 kernel versions 
with the same driver, but only 2.6.10 and later have any support for non-root mlock().

If and when our driver is submitted to the official kernel, that nastiness will be removed 
of course.

-- 
Timur Tabi
Staff Software Engineer
timur.tabi@ammasso.com

One thing a Southern boy will never say is,
"I don't think duct tape will fix it."
      -- Ed Smylie, NASA engineer for Apollo 13
