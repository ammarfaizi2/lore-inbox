Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753877AbWKHCLN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753877AbWKHCLN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 21:11:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753887AbWKHCLN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 21:11:13 -0500
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:44006 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1753877AbWKHCLM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 21:11:12 -0500
Date: Wed, 8 Nov 2006 11:13:41 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: Christoph Lameter <clameter@sgi.com>
Cc: sfr@canb.auug.org.au, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       stable@kernel.org, akpm@osdl.org
Subject: Re: [PATCH] Fix sys_move_pages when a NULL node list is passed.
Message-Id: <20061108111341.748d034a.kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <Pine.LNX.4.64.0611071800250.7749@schroedinger.engr.sgi.com>
References: <20061103144243.4601ba76.sfr@canb.auug.org.au>
	<20061108105648.4a149cca.kamezawa.hiroyu@jp.fujitsu.com>
	<Pine.LNX.4.64.0611071800250.7749@schroedinger.engr.sgi.com>
Organization: Fujitsu
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Nov 2006 18:01:11 -0800 (PST)
Christoph Lameter <clameter@sgi.com> wrote:

> On Wed, 8 Nov 2006, KAMEZAWA Hiroyuki wrote:
> 
> > >  	pm[nr_pages].node = MAX_NUMNODES;
> > 
> > I think node0 is always online...but this should be
> > 
> > pm[i].node = first_online_node; // /* any online node */
> 
> No it is a marker. The use of any node that is online could lead to a 
> false determination of the endpoint of the list.
> 
Ah.. I'm mentioning to this.
==
+			pm[i].node = 0;	/* anything to not match MAX_NUMNODES */
==
Sorry for my bad cut & paste.

It seems that this 0 will be passed to alloc_pages_node().
alloc_pages_node() doesn't check whether a node is online or not before using 
NODE_DATA().

-Kame

