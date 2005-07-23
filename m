Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261264AbVGWRR4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261264AbVGWRR4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Jul 2005 13:17:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262130AbVGWRR4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Jul 2005 13:17:56 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:59822 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S261264AbVGWRRz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Jul 2005 13:17:55 -0400
Date: Sat, 23 Jul 2005 19:17:37 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Nishanth Aravamudan <nacc@us.ibm.com>
cc: Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>,
       domen@coderock.org, linux-kernel@vger.kernel.org, clucas@rotomalug.org
Subject: Re: [PATCH] Add schedule_timeout_{interruptible,uninterruptible}{,_msecs}()
 interfaces
In-Reply-To: <20050723164310.GD4951@us.ibm.com>
Message-ID: <Pine.LNX.4.61.0507231911540.3743@scrub.home>
References: <20050707213138.184888000@homer> <20050708160824.10d4b606.akpm@osdl.org>
 <20050723002658.GA4183@us.ibm.com> <1122078715.5734.15.camel@localhost.localdomain>
 <Pine.LNX.4.61.0507231247460.3743@scrub.home> <1122116986.3582.7.camel@localhost.localdomain>
 <Pine.LNX.4.61.0507231340070.3743@scrub.home> <1122123085.3582.13.camel@localhost.localdomain>
 <Pine.LNX.4.61.0507231456000.3728@scrub.home> <20050723164310.GD4951@us.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, 23 Jul 2005, Nishanth Aravamudan wrote:

> > Keep the thing as simple as possible and jiffies _are_ simple. Please show 
> > me the problem, that needs to be fixed.
> 
> I am not sure why jiffies are any simpler than milliseconds. In the
> millisecond case, conversion happens in common code and only needs to be
> audited once. In the jiffies case, I have to check *every* caller to see
> if they are doing stupid math :)

Jiffies are the basic time unit for kernel timers, hiding that fact gives 
users only wrong expectations about them.
I don't mind using helper functions, but constant conversion can already 
happen at compile time and for variable timeouts the user should seriously 
consider using jiffies directly instead of constantly converting time 
values.

bye, Roman
