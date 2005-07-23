Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261863AbVGWRC0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261863AbVGWRC0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Jul 2005 13:02:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262360AbVGWRC0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Jul 2005 13:02:26 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:55214 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S261863AbVGWRCZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Jul 2005 13:02:25 -0400
Date: Sat, 23 Jul 2005 19:01:57 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Nishanth Aravamudan <nacc@us.ibm.com>
cc: Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>,
       domen@coderock.org, linux-kernel@vger.kernel.org, clucas@rotomalug.org
Subject: Re: [PATCH] Add schedule_timeout_{interruptible,uninterruptible}{,_msecs}()
 interfaces
In-Reply-To: <20050723163753.GC4951@us.ibm.com>
Message-ID: <Pine.LNX.4.61.0507231854180.3728@scrub.home>
References: <20050707213138.184888000@homer> <20050708160824.10d4b606.akpm@osdl.org>
 <20050723002658.GA4183@us.ibm.com> <1122078715.5734.15.camel@localhost.localdomain>
 <Pine.LNX.4.61.0507231247460.3743@scrub.home> <1122116986.3582.7.camel@localhost.localdomain>
 <Pine.LNX.4.61.0507231340070.3743@scrub.home> <20050723163753.GC4951@us.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, 23 Jul 2005, Nishanth Aravamudan wrote:

> 	set_current_state(TASK_{,UN}INTERRUPTIBLE);
> 	schedule_timeout(msecs_to_jiffies(some_constant_msecs));
> 
> just have an interface that allows
> 
> 	schedule_timeout_msecs_{,un}interruptible(some_constant_msecs);
> 
> and push the jiffies conversion to common code?

What's wrong with just:

	schedule_timeout_{,un}interruptible(msecs_to_jiffies(some_constant_msecs));

The majority of users use a constant, which can already be converted at 
compile tile.
Additionally such an interface also had to return a ms value and instead 
of that constant conversion, the user is better off to work with jiffies 
directly.

bye, Roman
