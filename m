Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263088AbUBRETT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 23:19:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263082AbUBRERT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 23:17:19 -0500
Received: from dp.samba.org ([66.70.73.150]:8621 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S263088AbUBREPS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 23:15:18 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Martin Hicks <mort@wildopensource.com>
Cc: Andrew Morton <akpm@osdl.org>, steiner@sgi.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Reduce TLB flushing during process migration 
In-reply-to: Your message of "Tue, 17 Feb 2004 10:49:26 CDT."
             <20040217154926.GI12142@localhost> 
Date: Wed, 18 Feb 2004 13:34:56 +1100
Message-Id: <20040218041527.CDA312C4DF@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20040217154926.GI12142@localhost> you write:
> CC'ed Rusty because this patch is applied on top of his cpuhotplug code.

Actually, the #ifdef around that function is wrong:

#if defined(CONFIG_NUMA) || defined(CONFIG_HOTPLUG_CPU)
/* If dest_cpu is allowed for this process, migrate us to it. */
void migrate_to_cpu(int dest_cpu)

We don't use this for HOTPLUG_CPU, but we call __migrate_task()
directly.

ie. #ifdef CONFIG_NUMA is sufficient.

I do think this is an obviously good idea though.
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
