Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932313AbWETMTU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932313AbWETMTU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 May 2006 08:19:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932326AbWETMTU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 May 2006 08:19:20 -0400
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:43738 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S932313AbWETMTU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 May 2006 08:19:20 -0400
Date: Sat, 20 May 2006 21:18:54 +0900
From: Yasunori Goto <y-goto@jp.fujitsu.com>
To: Dave Hansen <haveblue@us.ibm.com>
Subject: Re: [PATCH] Register sysfs file for hotpluged new node take 2.
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>,
       linux-mm <linux-mm@kvack.org>
In-Reply-To: <1148058107.6623.160.camel@localhost.localdomain>
References: <20060518143742.E2FB.Y-GOTO@jp.fujitsu.com> <1148058107.6623.160.camel@localhost.localdomain>
X-Mailer-Plugin: BkASPil for Becky!2 Ver.2.063
Message-Id: <20060520104215.BBB9.Y-GOTO@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.24.02 [ja]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Thu, 2006-05-18 at 14:50 +0900, Yasunori Goto wrote:
> > +       if (new_pgdat) {
> > +               ret = register_one_node(nid);
> > +               /*
> > +                * If sysfs file of new node can't create, cpu on the node
> > +                * can't be hot-added. There is no rollback way now.
> > +                * So, check by BUG_ON() to catch it reluctantly..
> > +                */
> > +               BUG_ON(ret);
> > +       } 
> 
> How about we register the node in sysfs _before_ it is
> set_node_online()'d?  Effectively an empty node with no memory and no
> CPUs.  It might be a wee bit confusing to any user tools watching the
> NUMA sysfs stuff, but I think it beats a BUG().

Hmmm. I'm not sure what will happen when sysfs file is accessed by user
at this time.  I think this issue should be going to be solved when
__remove_memory() and pgdat offline will be created.

Thanks for your comment.

-- 
Yasunori Goto 


