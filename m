Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030300AbVKPMUp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030300AbVKPMUp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 07:20:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030301AbVKPMUp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 07:20:45 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:24171
	"EHLO opteron.random") by vger.kernel.org with ESMTP
	id S1030300AbVKPMUp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 07:20:45 -0500
Date: Wed, 16 Nov 2005 13:20:42 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Rob Landley <rob@landley.net>
Cc: Ingo Oeser <ioe-lkml@rameria.de>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Badari Pulavarty <pbadari@us.ibm.com>,
       hugh@veritas.com, linux-mm@kvack.org
Subject: Re: [RFC] sys_punchhole()
Message-ID: <20051116122042.GE24970@opteron.random>
References: <1131664994.25354.36.camel@localhost.localdomain> <20051110153254.5dde61c5.akpm@osdl.org> <200511110925.48259.ioe-lkml@rameria.de> <200511160608.18413.rob@landley.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200511160608.18413.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 16, 2005 at 06:08:18AM -0600, Rob Landley wrote:
> You know, if you wanted to get really really gross and disgusting about this, 
> you could always have write(fd, NULL, count) punch a hole in the file.  (Then 
> have libc's write() check for NULL and error out, and have a seprate punch() 
> call that does the write with the null...)
> 
> Just one way to avoid introducing a new syscall...

That would add an unnecessary branch in write(3). I don't think it worth
it, we'd rather go full speed and use the syscall table for it. Plus it
sounds safer in general to keep it separate (just in case someone isn't
using glibc but some other dietlibc or similar ;)
