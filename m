Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750699AbWHYJsG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750699AbWHYJsG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 05:48:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751392AbWHYJsG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 05:48:06 -0400
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:41143 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1750699AbWHYJsD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 05:48:03 -0400
Date: Fri, 25 Aug 2006 18:47:17 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: Paul Jackson <pj@sgi.com>
Cc: haveblue@us.ibm.com, linux-kernel@vger.kernel.org, anton@samba.org,
       simon.derr@bull.net, nathanl@austin.ibm.com, akpm@osdl.org,
       GOTO <y-goto@jp.fujitsu.com>
Subject: Re: memory hotplug - looking for good place for cpuset hook
Message-Id: <20060825184717.3dbb5325.kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <20060825015359.1c9eab45.pj@sgi.com>
References: <20060825015359.1c9eab45.pj@sgi.com>
Organization: Fujitsu
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Aug 2006 01:53:59 -0700
Paul Jackson <pj@sgi.com> wrote:

> >From what I see so far, the right place to call my cpuset routine to
> update its copy of node_online_map would be right after the call:
> 
> 	node_set_online(nid);
> 
> in the routine mm/memory_hotplug.c:add_memory().
> 
> Does that seem like a plausible sounding place to you?
> 
maybe

if (new_pgdat) {
	register_one_node(nid); <-- add sysfs entry of node
	<here>
}

is good.

(When I implements node-hotplug invoked by cpu-hotplug, I'll care cpuset.)

-Kame

