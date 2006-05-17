Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932111AbWEQFt1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932111AbWEQFt1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 May 2006 01:49:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932162AbWEQFt1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 May 2006 01:49:27 -0400
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:24459 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S932111AbWEQFt1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 May 2006 01:49:27 -0400
Date: Wed, 17 May 2006 14:48:41 +0900
From: Yasunori Goto <y-goto@jp.fujitsu.com>
To: Dave Hansen <haveblue@us.ibm.com>
Subject: Re: [PATCH] Register sysfs file for hotpluged new node
Cc: Andrew Morton <akpm@osdl.org>, linux-mm <linux-mm@kvack.org>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>
In-Reply-To: <1147791091.6623.93.camel@localhost.localdomain>
References: <20060516210608.A3E5.Y-GOTO@jp.fujitsu.com> <1147791091.6623.93.camel@localhost.localdomain>
X-Mailer-Plugin: BkASPil for Becky!2 Ver.2.063
Message-Id: <20060517111236.21AC.Y-GOTO@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.24.02 [ja]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Tue, 2006-05-16 at 21:23 +0900, Yasunori Goto wrote:
> > +       /*
> > +        * register this node to sysfs.
> > +        * this is depends on topology. So each arch has its own.
> > +        */
> > +       if (new_pgdat){
> > +               ret = arch_register_node(nid);
> > +               BUG_ON(ret);
> > +       } 
> 
> Please don't do BUG_ON()s for things like this.  Memory hotplug _should_
> handle failures from top to bottom and not screw you over.  It isn't a
> crime or a bug to be out of memory.  

Basically, I would like to agree. 
But, there is no way to roll back from here now.
If online_node_map is set once, then new pgdat might be touched.
There is no way to disable them.

And I suppose it is not good thing that creating sysfs file of new node
before setting online_node_map. It means user interface is shown
before system initialization completion.

(In addition, remove_memory() is not yet....)

If return code of arch_register_node is ignored, 
cpu hotplug will work without new node's file.
When we tried cpu hotplug on it, it was cause of stack dump at last.

> Have you run this past the ppc maintainers?

Nope. I just tried cross compile.
I want powerpc box for test....


Thanks.

-- 
Yasunori Goto 


