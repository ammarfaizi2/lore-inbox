Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263954AbTIIF4U (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 01:56:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263955AbTIIF4U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 01:56:20 -0400
Received: from adsl-206-170-148-147.dsl.snfc21.pacbell.net ([206.170.148.147]:4110
	"EHLO gw.goop.org") by vger.kernel.org with ESMTP id S263954AbTIIF4T
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 01:56:19 -0400
Subject: Re: [PATCH] use group_leader->pgrp (was Re: setpgid and threads)
From: Jeremy Fitzhardinge <jeremy@goop.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Ulrich Drepper <drepper@redhat.com>, mingo@redhat.com,
       Roland McGrath <roland@redhat.com>,
       Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030908211746.25fff0f1.akpm@osdl.org>
References: <1061424262.24785.29.camel@localhost.localdomain>
	 <20030820194940.6b949d9d.akpm@osdl.org>
	 <1063072786.4004.11.camel@localhost.localdomain>
	 <20030908191215.22f501a2.akpm@osdl.org>
	 <1063073637.4004.14.camel@localhost.localdomain>
	 <20030908202147.3cba2ecd.akpm@osdl.org> <3F5D4EFA.30102@redhat.com>
	 <20030908211746.25fff0f1.akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1063086977.12268.17.camel@ixodes.goop.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Mon, 08 Sep 2003 22:56:17 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-09-08 at 21:17, Andrew Morton wrote:
> All other instances of foo->pgrp have been converted to process_group(foo),
> which is foo->group_leader->__pgrp.
> 
> Should setpgrp() in a thread affect the group leader?   It does...

Eh?  sys_setpgid() fails with EINVAL if another thread tries to change
the process group.  Oh, I see.  setpgrp() is a wrapper which passes
pid=0 to setpgid; sys_setpgid uses current->pid rather than
current->tgid, so it always uses the thread group leader's ID.  Looks OK
to me.

	J

