Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965053AbVJUSRW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965053AbVJUSRW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Oct 2005 14:17:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965071AbVJUSRW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Oct 2005 14:17:22 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:9122 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S965053AbVJUSRV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Oct 2005 14:17:21 -0400
Date: Fri, 21 Oct 2005 11:17:06 -0700
From: Paul Jackson <pj@sgi.com>
To: Christoph Lameter <clameter@engr.sgi.com>
Cc: kamezawa.hiroyu@jp.fujitsu.com, Simon.Derr@bull.net, akpm@osdl.org,
       kravetz@us.ibm.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       magnus.damm@gmail.com, marcelo.tosatti@cyclades.com
Subject: Re: [PATCH 4/4] Swap migration V3: sys_migrate_pages interface
Message-Id: <20051021111706.14ba1569.pj@sgi.com>
In-Reply-To: <Pine.LNX.4.62.0510211005090.23359@schroedinger.engr.sgi.com>
References: <20051020225935.19761.57434.sendpatchset@schroedinger.engr.sgi.com>
	<20051020225955.19761.53060.sendpatchset@schroedinger.engr.sgi.com>
	<4358588D.1080307@jp.fujitsu.com>
	<Pine.LNX.4.61.0510210901380.17098@openx3.frec.bull.fr>
	<435896CA.1000101@jp.fujitsu.com>
	<Pine.LNX.4.62.0510210926120.23328@schroedinger.engr.sgi.com>
	<20051021100357.3397269e.pj@sgi.com>
	<Pine.LNX.4.62.0510211005090.23359@schroedinger.engr.sgi.com>
Organization: SGI
X-Mailer: Sylpheed version 2.0.0beta5 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph wrote:
> Therefore if mems_allowed is accessed from outside of the 
> task then it may not be up to date, right?

Yup - exactly.

The up to date allowed memory container for a task is in its cpuset,
which does have the locking mechanisms needed for safe access from
other tasks.

The task mems_allowed is just a private cache of the mems_allowed of
its cpuset, used for quick access from within the task context by the
page allocation code.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
