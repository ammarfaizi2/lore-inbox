Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263902AbTDNTPN (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 15:15:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263904AbTDNTPN (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 15:15:13 -0400
Received: from [12.47.58.203] ([12.47.58.203]:20195 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S263902AbTDNTPL (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 14 Apr 2003 15:15:11 -0400
Date: Mon, 14 Apr 2003 12:26:59 -0700
From: Andrew Morton <akpm@digeo.com>
To: maneesh@in.ibm.com
Cc: dipankar@in.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [patch] dentry_stat fix
Message-Id: <20030414122659.308b3260.akpm@digeo.com>
In-Reply-To: <20030414180910.B27092@in.ibm.com>
References: <20030414144417.A27092@in.ibm.com>
	<20030414021448.08ff05a5.akpm@digeo.com>
	<20030414180910.B27092@in.ibm.com>
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 14 Apr 2003 19:26:54.0145 (UTC) FILETIME=[CE663310:01C302BB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Maneesh Soni <maneesh@in.ibm.com> wrote:
>
> On Mon, Apr 14, 2003 at 02:14:48AM -0700, Andrew Morton wrote:
> > Maneesh Soni <maneesh@in.ibm.com> wrote:
> > >
> > > This patch the corrects the dentry_stat.nr_unused calculation.
> > 
> > OK, I didn't even know we had a bug in there...
> > 
> > btw, can you explain to me why shrink_dcache_anon() and select_parent() are
> > putting dentries at the wrong end of dentry_unused?
> prune_dcache() picks up from this end in first round. It will reset the 
> DCACHE_REFERENCED flag and will put it to the front of dentry_unused list.
> 

Sorry, but I still don't understand why they're being put at the "oldest" end
of dentry_unused.

Also, shrink_dcache_anon() does:

	prune_dcache(found);

I hope we're not assuming that all the dentries which were just added will be
freed?  They hae the referenced bit set, and new dentries can be added...
