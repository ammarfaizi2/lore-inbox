Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263663AbUDODWz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 23:22:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263633AbUDODWz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 23:22:55 -0400
Received: from fw.osdl.org ([65.172.181.6]:63884 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263663AbUDODWy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 23:22:54 -0400
Date: Wed, 14 Apr 2004 20:21:53 -0700
From: Andrew Morton <akpm@osdl.org>
To: Nathan Lynch <nathanl@austin.ibm.com>
Cc: linux-kernel@vger.kernel.org, olof@austin.ibm.com
Subject: Re: [PATCH] Increase number of dynamic inodes in procfs (2.6.5)
Message-Id: <20040414202153.731d6933.akpm@osdl.org>
In-Reply-To: <407DFDE7.5050803@austin.ibm.com>
References: <407C4130.8000901@austin.ibm.com>
	<20040413170642.22894ebc.akpm@osdl.org>
	<407DF5AD.5090909@austin.ibm.com>
	<20040414195116.778fa4b2.akpm@osdl.org>
	<407DFDE7.5050803@austin.ibm.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nathan Lynch <nathanl@austin.ibm.com> wrote:
>
> Andrew Morton wrote:
> > Nathan Lynch <nathanl@austin.ibm.com> wrote:
> > 
> >>>This open-codes a simple version of lib/idr.c.  Please use lib/idr.c
> >>
> >> > instead.  There's an example in fs/super.c
> >>
> >> Ok, thanks for the tip.  Is this better?
> > 
> > 
> > Looks OK.  How well tested was it?  Nothing calls init_proc_inum_idr().
> > Maybe all-zeroes happens to work.
> 
> Sorry, I tested it all day; it just happens to work :)

heh.  It gave me an instasplat with spinlock debugging enabled.

> I think 
> the call to idr_remove in fs/super.c::set_anon_super needs to be holding 
> unnamed_dev_lock.

Indeed.  I'll fix that up, thanks.
