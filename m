Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262947AbVCWXno@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262947AbVCWXno (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 18:43:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262950AbVCWXnn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 18:43:43 -0500
Received: from fire.osdl.org ([65.172.181.4]:63709 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262947AbVCWXme (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 18:42:34 -0500
Date: Wed, 23 Mar 2005 15:42:32 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: aebr@win.tue.nl, cmm@us.ibm.com, andrea@suse.de,
       linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net
Subject: Re: OOM problems on 2.6.12-rc1 with many fsx tests
Message-Id: <20050323154232.376f977f.akpm@osdl.org>
In-Reply-To: <25760000.1111620606@flay>
References: <20050315204413.GF20253@csail.mit.edu>
	<20050316003134.GY7699@opteron.random>
	<20050316040435.39533675.akpm@osdl.org>
	<20050316183701.GB21597@opteron.random>
	<1111607584.5786.55.camel@localhost.localdomain>
	<20050323144953.288a5baf.akpm@osdl.org>
	<17250000.1111619602@flay>
	<20050323152055.6fc8c198.akpm@osdl.org>
	<20050323232656.GA5704@pclin040.win.tue.nl>
	<25760000.1111620606@flay>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Martin J. Bligh" <mbligh@aracnet.com> wrote:
>
> >> Nothing beats poking around in a dead machine's guts with kgdb though.
> > 
> > Everyone his taste.
> > 
> > But I was surprised by
> > 
> >> SwapTotal:     1052216 kB
> >> SwapFree:      1045984 kB
> > 
> > Strange that processes are killed while lots of swap is available.
> 
> I don't think we're that smart about it. If we're really low on mem, it
> seems we invoke the OOM killer whether processes are causing the problem
> or not. 
> 
> OTOH, if we can't free the kernel mem, we don't have much choice, but 
> it's not really helping much ;-)
> 

I'm suspecting here that we simply leaked a refcount on every darn
pagecache page in the machine.  Note how mapped memory has shrunk down to
less than a megabyte and everything which can be swapped out has been
swapped out.

If so, then oom-killing everything in the world is pretty inevitable.
