Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262806AbTAVUOR>; Wed, 22 Jan 2003 15:14:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262807AbTAVUOR>; Wed, 22 Jan 2003 15:14:17 -0500
Received: from packet.digeo.com ([12.110.80.53]:24965 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S262806AbTAVUOQ>;
	Wed, 22 Jan 2003 15:14:16 -0500
Date: Wed, 22 Jan 2003 12:17:12 -0800
From: Andrew Morton <akpm@digeo.com>
To: Kevin Lawton <kevinlawton2001@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Simple patches for Linux as a guest OS in a plex86 VM (please
 consider)
Message-Id: <20030122121712.19f19dac.akpm@digeo.com>
In-Reply-To: <20030122201149.94950.qmail@web80314.mail.yahoo.com>
References: <20030122115641.1be444fa.akpm@digeo.com>
	<20030122201149.94950.qmail@web80314.mail.yahoo.com>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 22 Jan 2003 20:23:19.0440 (UTC) FILETIME=[1A51B900:01C2C254]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kevin Lawton <kevinlawton2001@yahoo.com> wrote:
>
> Humm, that's a good idea.  I already made the mods
> to files to add an #include <asm/if.h>.  That would
> be a logical place to stick such macros.

<asm/if.h> is a fine place to put the macros.

However, open-coding

	#include <asm/if.h>

in the places which are known to use pushfl/popfl is fragile.  Because
someone could later do something odd which results in the generation of an
unmassaged pushfl/popfl.

You need a magic bullet.  Which is why I suggest including if.h via the build
system - making it truly global.

__ASSEMBLY__ and __KERNEL__ are provided via the build system as well, and
are in scope during that first inclusion.  So it _should_ work....


