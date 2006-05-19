Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751375AbWESRDM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751375AbWESRDM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 May 2006 13:03:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751376AbWESRDM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 May 2006 13:03:12 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:12775 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751375AbWESRDL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 May 2006 13:03:11 -0400
Subject: Re: [PATCH] Register sysfs file for hotpluged new node take 2.
From: Dave Hansen <haveblue@us.ibm.com>
To: Yasunori Goto <y-goto@jp.fujitsu.com>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>,
       linux-mm <linux-mm@kvack.org>
In-Reply-To: <20060518143742.E2FB.Y-GOTO@jp.fujitsu.com>
References: <20060518143742.E2FB.Y-GOTO@jp.fujitsu.com>
Content-Type: text/plain
Date: Fri, 19 May 2006 10:01:47 -0700
Message-Id: <1148058107.6623.160.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-05-18 at 14:50 +0900, Yasunori Goto wrote:
> +       if (new_pgdat) {
> +               ret = register_one_node(nid);
> +               /*
> +                * If sysfs file of new node can't create, cpu on the node
> +                * can't be hot-added. There is no rollback way now.
> +                * So, check by BUG_ON() to catch it reluctantly..
> +                */
> +               BUG_ON(ret);
> +       } 

How about we register the node in sysfs _before_ it is
set_node_online()'d?  Effectively an empty node with no memory and no
CPUs.  It might be a wee bit confusing to any user tools watching the
NUMA sysfs stuff, but I think it beats a BUG().

-- Dave

