Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263918AbTIIDU2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 23:20:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263919AbTIIDU2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 23:20:28 -0400
Received: from fw.osdl.org ([65.172.181.6]:30367 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263918AbTIIDU1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 23:20:27 -0400
Date: Mon, 8 Sep 2003 20:21:47 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: mingo@redhat.com, drepper@redhat.com, roland@redhat.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] use group_leader->pgrp (was Re: setpgid and threads)
Message-Id: <20030908202147.3cba2ecd.akpm@osdl.org>
In-Reply-To: <1063073637.4004.14.camel@localhost.localdomain>
References: <1061424262.24785.29.camel@localhost.localdomain>
	<20030820194940.6b949d9d.akpm@osdl.org>
	<1063072786.4004.11.camel@localhost.localdomain>
	<20030908191215.22f501a2.akpm@osdl.org>
	<1063073637.4004.14.camel@localhost.localdomain>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeremy Fitzhardinge <jeremy@goop.org> wrote:
>
> On Mon, 2003-09-08 at 19:12, Andrew Morton wrote:
> > and to then rename task_struct.pgrp to something else, to pick up any
> > missed conversions?
> 
> Probably a good idea.

Caught a few:

drivers/char/tty_io.c: In function `tty_check_change':
drivers/char/tty_io.c:332: structure has no member named `pgrp'
drivers/char/tty_io.c:334: structure has no member named `pgrp'

	if (is_orphaned_pgrp(current->pgrp))
		return -EIO;
	(void) kill_pg(current->pgrp,SIGTTOU,1);

should these be converted?


drivers/char/tty_io.c: In function `tty_open':
drivers/char/tty_io.c:1409: structure has no member named `pgrp'

		tty->pgrp = current->pgrp;

this one?

drivers/char/tty_io.c: In function `tiocsctty':
drivers/char/tty_io.c:1583: structure has no member named `pgrp'

        tty->pgrp = current->pgrp;

and this.  I think so?
