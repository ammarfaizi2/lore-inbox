Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265141AbUGNXtC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265141AbUGNXtC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 19:49:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265228AbUGNXtC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 19:49:02 -0400
Received: from mailgate2.mysql.com ([213.136.52.47]:33442 "EHLO
	mailgate.mysql.com") by vger.kernel.org with ESMTP id S265141AbUGNXs7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 19:48:59 -0400
Subject: Re: VM Problems in 2.6.7 (Too active OOM Killer)
From: Peter Zaitsev <peter@mysql.com>
To: Andrew Morton <akpm@osdl.org>
Cc: andrea@suse.de, linux-kernel@vger.kernel.org
In-Reply-To: <20040713211721.05781fb7.akpm@osdl.org>
References: <1089771823.15336.2461.camel@abyss.home>
	 <20040714031701.GT974@dualathlon.random>
	 <1089776640.15336.2557.camel@abyss.home>
	 <20040713211721.05781fb7.akpm@osdl.org>
Content-Type: text/plain
Organization: MySQL
Message-Id: <1089848823.15336.3895.camel@abyss.home>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 14 Jul 2004 16:47:04 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-07-13 at 21:17, Andrew Morton wrote:
> Peter Zaitsev <peter@mysql.com> wrote:
> >
> > The reason for me to disable swap both in 2.4 and 2.6 is - it really
> >  hurts performance. In some cases performance can be 2-3 times slower
> >  with swap file enabled.   Using O_DIRECT and mlock() for buffers helps 
> >  but not completely.
> 
> It's strange that swap should harm performance in this manner.  Is that
> also the case on 2.6?

I've run the test and it looks like VM in 2.6 does not suffer from
excessive swapping, at least for this test. It could be you need to get
more memory load to get such effect (I was only using some 2G out of 4G
for application, the rest was file cache).

Anyway this is pretty good news.


> 
> wrt this OOM problem: it's possible that your ZONE_NORMAL got filled with
> anonymous memory which the VM is unable to do anything about.  If you're
> going to run a highmem box swapless then you should tune the kernel so that
> it doesn't use so much ZONE_NORMAL memory for anonymous pages.

My concern is mainly users which normally run kernel with default
settings. Things should work for them as well. 

To be honest I do not really understand this OOM without swap problem at
all, why is it possible to move pages from ZONE_NORMAL to swap but not
to other zones ? 


-- 
Peter Zaitsev, Senior Support Engineer
MySQL AB, www.mysql.com



