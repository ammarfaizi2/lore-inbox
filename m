Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265978AbUGNWur@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265978AbUGNWur (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 18:50:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265973AbUGNWur
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 18:50:47 -0400
Received: from fw.osdl.org ([65.172.181.6]:11433 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265971AbUGNWuo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 18:50:44 -0400
Date: Wed, 14 Jul 2004 14:35:08 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: mikpe@csd.uu.se, B.Zolnierkiewicz@elka.pw.edu.pl, dgilbert@interlog.com,
       linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH][2.6.8-rc1-mm1] drivers/scsi/sg.c gcc341 inlining fix
Message-Id: <20040714143508.3dc25d58.akpm@osdl.org>
In-Reply-To: <40F57D14.9030005@pobox.com>
References: <200407141751.i6EHprhf009045@harpo.it.uu.se>
	<40F57D14.9030005@pobox.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik <jgarzik@pobox.com> wrote:
>
> Or you could just call it "gcc is dumb" rather than a compiler bug.

Yeah, but doing:

	static inline foo(void);

	bar()
	{
		...
		foo();
	}

	static inline foo(void)
	{
		...
	}

is pretty dumb too.  I don't see any harm if this compiler feature/problem
pushes us to fix the above in the obvious way.

Plus if we do, the inlining attempt actually succeed, on all compiler
versions.

