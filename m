Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261583AbUBYXVa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 18:21:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261580AbUBYXVX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 18:21:23 -0500
Received: from fed1mtao05.cox.net ([68.6.19.126]:58325 "EHLO
	fed1mtao05.cox.net") by vger.kernel.org with ESMTP id S261804AbUBYXS3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 18:18:29 -0500
Date: Wed, 25 Feb 2004 16:18:28 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: George Anzinger <george@mvista.com>
Cc: kernel list <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@suse.cz>,
       "Amit S. Kale" <amitkale@emsyssoft.com>,
       kgdb-bugreport@lists.sourceforge.net
Subject: Re: [Kgdb-bugreport] [PATCH][1/3] Update CVS KGDB's serial driver
Message-ID: <20040225231828.GO1052@smtp.west.cox.net>
References: <20040225213626.GF1052@smtp.west.cox.net> <403D2B4B.8090704@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <403D2B4B.8090704@mvista.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 25, 2004 at 03:10:03PM -0800, George Anzinger wrote:

> Convention has been that control C does the break.  If I read this 
> correctly you are saying that any character does it.

There are two cases.  One is that kgdb is not connected (so it's not
active) and since we're the int handler, someone wants to connect.  This
lets us do very nice things like break in any old time (gdb doesn't need
to be modified to send a ^C before it's first packet, etc).  The second
case is that we have connected, we've issued a few commands, continued,
and we want to break in now, so we ^C in gdb (which sends a ^C to the
target) and we do what we've got to do.

So perhaps, and I haven't read all of the code again to verify this,
kgdb_connected could be eliminated in favor of debugger_active.

> If that is the intent 
> and it works, then the whole buffer interrupt characters thing can be 
> removed.  In fact, an interrupt implies we are not in kgdb (it holds all 
> interrutps off) so that test, too, can go.  The interrupt thing then 
> reduces to a breakpoint.

I'll give that a shot tomorrow and see what happens.

-- 
Tom Rini
http://gate.crashing.org/~trini/
