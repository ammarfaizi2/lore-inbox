Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265161AbUGOBZ0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265161AbUGOBZ0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 21:25:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264966AbUGOBYP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 21:24:15 -0400
Received: from mailgate2.mysql.com ([213.136.52.47]:22724 "EHLO
	mailgate.mysql.com") by vger.kernel.org with ESMTP id S266005AbUGOAct
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 20:32:49 -0400
Subject: Re: VM Problems in 2.6.7 (Too active OOM Killer)
From: Peter Zaitsev <peter@mysql.com>
To: Andrew Morton <akpm@osdl.org>
Cc: andrea@suse.de, linux-kernel@vger.kernel.org
In-Reply-To: <20040714154427.14234822.akpm@osdl.org>
References: <1089771823.15336.2461.camel@abyss.home>
	 <20040714031701.GT974@dualathlon.random>
	 <1089776640.15336.2557.camel@abyss.home>
	 <20040713211721.05781fb7.akpm@osdl.org>
	 <1089848823.15336.3895.camel@abyss.home>
	 <20040714154427.14234822.akpm@osdl.org>
Content-Type: text/plain
Organization: MySQL
Message-Id: <1089851451.15336.3962.camel@abyss.home>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 14 Jul 2004 17:30:52 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-07-14 at 15:44, Andrew Morton wrote:

> 
> > To be honest I do not really understand this OOM without swap problem at
> > all, why is it possible to move pages from ZONE_NORMAL to swap but not
> > to other zones ? 
> 
> If the kernel has no swap there is nothing it can do with an anonymous page
> (ie: the thing whcih malloc() gives you).  It is effectively pinned memory,
> because there's nowhere we can write it to get rid of it.

Why can't it be moved to other zone if there is a lot of place where ?
In general I was not pushing system in some kind of stress mode - There
was still a lot of cache memory available. Why it could not be instead
shrunk to accommodate allocation ? 

As I understand in my case with 4G there is  Normal zone and HighMem
zone where "user" anonymous memory can be located in any of these zones.
Is this observation correct ? 

 
> 
> If you end up pinning all of your ZONE_NORMAL pages with anonymous memory,
> further GFP_KERNEL allocation attempts will go oom.

Aha I see. So user level memory allocations can't cause OOM only kernel
level allocations can ?   In this case why do not you have some reserved
amount of space for these types of allocations by default ? 

In this case I also do not understand how swap space helps here ? If you
can't move page to over zone or shrink cache because of allocation type
how it happens you can however perform page swap ? 



-- 
Peter Zaitsev, Senior Support Engineer
MySQL AB, www.mysql.com



