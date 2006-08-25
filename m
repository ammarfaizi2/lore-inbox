Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751308AbWHYR6U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751308AbWHYR6U (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 13:58:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751007AbWHYR6U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 13:58:20 -0400
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:41889 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1750724AbWHYR6T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 13:58:19 -0400
Date: Sat, 26 Aug 2006 02:57:49 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: Paul Jackson <pj@sgi.com>
Cc: haveblue@us.ibm.com, linux-kernel@vger.kernel.org, anton@samba.org,
       simon.derr@bull.net, nathanl@austin.ibm.com, akpm@osdl.org,
       y-goto@jp.fujitsu.com
Subject: Re: memory hotplug - looking for good place for cpuset hook
Message-Id: <20060826025749.6b3ae702.kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <20060825095718.9e22e777.pj@sgi.com>
References: <20060825015359.1c9eab45.pj@sgi.com>
	<20060825184717.3dbb5325.kamezawa.hiroyu@jp.fujitsu.com>
	<20060825095718.9e22e777.pj@sgi.com>
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Aug 2006 09:57:18 -0700
Paul Jackson <pj@sgi.com> wrote:

> ================================================================
> int add_memory(int nid, u64 start, u64 size)
> {
>         pg_data_t *pgdat = NULL;
>         ...
>         if (!node_online(nid)) {
>                 pgdat = hotadd_new_pgdat(nid, start);
>                 if (!pgdat)
>                         return -ENOMEM;
>                ...
>         }
>         ...
>         if (pgdat) {
>                 /* we online node here. we can't roll back from here. */
>                 node_set_online(nid);
>                 ret = register_one_node(nid);                         
> ================================================================
> 
> Is this second code chunk just as good?
> 

Ah yes. I think yours is better logic.

> I'd still be inclined to add my new cpuset hook to track
> node_online_map right after the node_set_online() call, since
> that's what changes node_online_map.  I don't think I care
> whether or not the "sysfs entry of node" is setup or not.
> 
Ok.

Thanks,
-Kame

