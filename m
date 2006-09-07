Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932152AbWIGQer@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932152AbWIGQer (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Sep 2006 12:34:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932212AbWIGQer
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Sep 2006 12:34:47 -0400
Received: from smtp.osdl.org ([65.172.181.4]:7656 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932152AbWIGQep (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Sep 2006 12:34:45 -0400
Date: Thu, 7 Sep 2006 09:34:17 -0700
From: Andrew Morton <akpm@osdl.org>
To: Guennadi Liakhovetski <gl@dsa-ac.de>
Cc: sct@redhat.com, adilger@clusterfs.com, linux-kernel@vger.kernel.org
Subject: Re: [2.6.18-rc6] ext3 memory leak
Message-Id: <20060907093417.54d2adf1.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.63.0609071657490.1700@pcgl.dsa-ac.de>
References: <Pine.LNX.4.63.0609071300330.1700@pcgl.dsa-ac.de>
	<Pine.LNX.4.63.0609071657490.1700@pcgl.dsa-ac.de>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Sep 2006 17:21:35 +0200 (CEST)
Guennadi Liakhovetski <gl@dsa-ac.de> wrote:

> On Thu, 7 Sep 2006, Guennadi Liakhovetski wrote:
> 
> > I've reported before in thread "[2.6.17.4] slabinfo.buffer_head increases" a 
> > memory leak in ext3. Today I verified it is still present in 2.6.18-rc6.
> 
> No, sorry, I cannot seem to reproduce it under -rc6. It seems to stabilize 
> eventually. But it doesn't under -rc2. I looked through all commits to 
> ext3 code between -rc2 and -rc6 and I don't see any obvious reasons why a 
> memory leak may have been fixed. Unless somebody can sched some light on 
> this, I'll try to upgrade the problematic system to -rc6 tomorrow.
> 
> Just to be quite sure - this cannot (or is very unlikely to) be a libc 
> bug, right?
> 

It is expected that in this situation the number of buffer_head objects will
be approximately equal to the number of pagecache pages.  So once the pagecache
has grown to consume all available memory and the kernel starts to perform pagecache
reclaim, the buffer_head count should stabilise.
