Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263868AbTIICKv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 22:10:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263871AbTIICKv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 22:10:51 -0400
Received: from fw.osdl.org ([65.172.181.6]:47843 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263868AbTIICKu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 22:10:50 -0400
Date: Mon, 8 Sep 2003 19:12:15 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: mingo@redhat.com, drepper@redhat.com, roland@redhat.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] use group_leader->pgrp (was Re: setpgid and threads)
Message-Id: <20030908191215.22f501a2.akpm@osdl.org>
In-Reply-To: <1063072786.4004.11.camel@localhost.localdomain>
References: <1061424262.24785.29.camel@localhost.localdomain>
	<20030820194940.6b949d9d.akpm@osdl.org>
	<1063072786.4004.11.camel@localhost.localdomain>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeremy Fitzhardinge <jeremy@goop.org> wrote:
>
> On Wed, 2003-08-20 at 19:49, Andrew Morton wrote:
> > Using current->thread_group->foo sounds like a reasonable solution
> 
> Here's a patch to use group_leader->pgrp rather than just ->pgrp so that
> all threads in a group appear to have the same process group ID.

Just a quick maintainance thing:


> -				if (is_orphaned_pgrp(current->pgrp))
> +				if (is_orphaned_pgrp(current->group_leader->pgrp))

Would it make sense to do this via

	if (is_orphaned_pgrp(process_group(current)))

and to then rename task_struct.pgrp to something else, to pick up any
missed conversions?

