Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750939AbWIUB3w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750939AbWIUB3w (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 21:29:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750937AbWIUB3w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 21:29:52 -0400
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:20427 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1750936AbWIUB3v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 21:29:51 -0400
Date: Thu, 21 Sep 2006 10:33:02 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Cc: clameter@sgi.com, lhms-devel@lists.sourceforge.net, npiggin@suse.de,
       ckrm-tech@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       pj@sgi.com, rohitseth@google.com, devel@openvz.org
Subject: Re: [Lhms-devel] [patch00/05]: Containers(V2)- Introduction
Message-Id: <20060921103302.b57d288d.kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <20060921095100.25e02b5c.kamezawa.hiroyu@jp.fujitsu.com>
References: <1158718568.29000.44.camel@galaxy.corp.google.com>
	<Pine.LNX.4.64.0609200916140.30572@schroedinger.engr.sgi.com>
	<1158773208.8574.53.camel@galaxy.corp.google.com>
	<Pine.LNX.4.64.0609201035240.31464@schroedinger.engr.sgi.com>
	<1158775678.8574.81.camel@galaxy.corp.google.com>
	<20060920155815.33b03991.pj@sgi.com>
	<1158794808.7207.14.camel@galaxy.corp.google.com>
	<Pine.LNX.4.64.0609201629220.1859@schroedinger.engr.sgi.com>
	<20060921095100.25e02b5c.kamezawa.hiroyu@jp.fujitsu.com>
Organization: Fujitsu
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Self-response..

On Thu, 21 Sep 2006 09:51:00 +0900
KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com> wrote:

> On Wed, 20 Sep 2006 16:31:22 -0700 (PDT)
> Christoph Lameter <clameter@sgi.com> wrote:
> 
> > On Wed, 20 Sep 2006, Rohit Seth wrote:
> > 
> > > Absolutely.  Since these containers are not (hard) partitioning the
> > > memory in any way so it is easy to change the limits (effectively
> > > reducing and increasing the memory limits for tasks belonging to
> > > containers).  As you said, memory hot-un-plug is important and it is
> > > non-trivial amount of work.
> > 
> > Maybe the hotplug guys want to contribute to the discussion?
> > 
> Ah, I'm reading threads with interest.

I wonder it may not good to use pgdat for resource controlling.

For example

In following scenario,
==
(1). add <pid> > /mnt/configfs/containers/my_container/add_task
(2). <pid> does some work.
(3). echo <pid> > /mnt/configfs/containers/my_container/rm_task
(4). echo <pid> > /mnt/configfs/containers/my_container2/add_task
==
(if fake-pgdat/memory-hotplug is used)
The pages used by <pid> in (2) will be accounted in 'my_container' after (3).
Is this user's wrong use of system ?

-Kame

