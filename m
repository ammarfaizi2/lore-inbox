Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265002AbUD2WWA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265002AbUD2WWA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 18:22:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265003AbUD2WWA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 18:22:00 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:4993 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S265002AbUD2WV6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 18:21:58 -0400
Date: Thu, 29 Apr 2004 15:18:17 -0700
From: Paul Jackson <pj@sgi.com>
To: Andrew Morton <akpm@osdl.org>, Shailabh Nagar <nagar@watson.ibm.com>
Cc: vonbrand@inf.utfsm.cl, nickpiggin@yahoo.com.au, jgarzik@pobox.com,
       brettspamacct@fastclick.com, linux-kernel@vger.kernel.org
Subject: Re: ~500 megs cached yet 2.6.5 goes into swap hell
Message-Id: <20040429151817.49df30a9.pj@sgi.com>
In-Reply-To: <20040429145725.267ea7b8.akpm@osdl.org>
References: <40904A84.2030307@yahoo.com.au>
	<200404292001.i3TK1BYe005147@eeyore.valparaiso.cl>
	<20040429133613.791f9f9b.pj@sgi.com>
	<20040429141947.1ff81104.akpm@osdl.org>
	<20040429143403.35a7a550.pj@sgi.com>
	<20040429145725.267ea7b8.akpm@osdl.org>
Organization: SGI
X-Mailer: Sylpheed version 0.9.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew wrote:
> Even if the background activity was clamped to just a few megs
> of cache you'll find that the seek activity is a killer, and
> needs a limitation mechanism.

True - the seek activity is another critical resource that would need to
be throttled to keep updatedb/backup from interferring with my late
night labours.

Let's see, that's:
 1) cpu scheduling ticks
 2) memory for virtual address backing store
 3) memory for file related caching
 4) disk arm motion

Hmmm ... actually not so much a numa-placement extension, but rather a
CKRM opportunity.

CKRM focuses on measuring and restraining how much of specified critical
resources a task is using; numa placement on which cpus or memory nodes
are allowed to be used at all.

See further the CKRM thread of Shailabh Nagar, also running on lkml
today.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
