Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932126AbWBFOgM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932126AbWBFOgM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 09:36:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751098AbWBFOgM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 09:36:12 -0500
Received: from rtr.ca ([64.26.128.89]:43148 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1751095AbWBFOgL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 09:36:11 -0500
Message-ID: <43E75ED4.809@rtr.ca>
Date: Mon, 06 Feb 2006 09:36:04 -0500
From: Mark Lord <lkml@rtr.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.1) Gecko/20060130 SeaMonkey/1.0
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: David Chinner <dgc@sgi.com>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] Prevent large file writeback starvation
References: <20060206040027.GI43335175@melbourne.sgi.com> <20060205202733.48a02dbe.akpm@osdl.org>
In-Reply-To: <20060205202733.48a02dbe.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I wonder if this is related to my previous observation here,
on ext3, that large file writebacks get deferred wayyyyy too long.

Original post is below:


-------- Original Message --------
Subject: 2.6.xx:  dirty pages never being sync'd to disk?
Date: Mon, 14 Nov 2005 10:30:58 -0500
From: Mark Lord <lkml@rtr.ca>
To: Linux Kernel <linux-kernel@vger.kernel.org>

Okay, this one's been nagging me since I first began using 2.6.xx.

My Notebook computer has 2GB of RAM, and the 2.6.xx kernel seems quite
happy to leave hundreds of MB of dirty unsync'd pages laying around
more or less indefinitely.  This worries me, because that's a lot of data
to lose should the kernel crash (which it has once quite recently)
or the battery die.

/proc/sys/vm/dirty_expire_centisecs = 3000 (30 seconds)
/proc/sys/vm/dirty_writeback_centisecs = 500 (5 seconds)

My understanding (please correct if wrong) is that this means
that any (file data) page which is dirtied, should get flushed
back to disk after 30 seconds or so.

That doesn't happen here.  Hundreds of MB of dirty pages just
hang around indefinitely, until I manually type "sync",
at which point the hard drive gets very busy for 20 seconds or so.

What's going on?
