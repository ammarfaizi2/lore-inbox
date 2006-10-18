Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161312AbWJRTb3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161312AbWJRTb3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 15:31:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161311AbWJRTb3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 15:31:29 -0400
Received: from smtp.osdl.org ([65.172.181.4]:9113 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161312AbWJRTb2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 15:31:28 -0400
Date: Wed, 18 Oct 2006 12:31:15 -0700
From: Andrew Morton <akpm@osdl.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Cal Peake <cp@absolutedigital.net>, Andi Kleen <ak@suse.de>,
       Randy Dunlap <rdunlap@xenotime.net>, Jan Beulich <jbeulich@novell.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCHv2] Undeprecate the sysctl system call
Message-Id: <20061018123115.662ec5c7.akpm@osdl.org>
In-Reply-To: <1161189661.9363.83.camel@localhost.localdomain>
References: <453519EE.76E4.0078.0@novell.com>
	<200610181441.51748.ak@suse.de>
	<1161176382.9363.35.camel@localhost.localdomain>
	<200610181508.54237.ak@suse.de>
	<Pine.LNX.4.64.0610181214060.7303@lancer.cnet.absolutedigital.net>
	<1161189661.9363.83.camel@localhost.localdomain>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Oct 2006 17:41:01 +0100
Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

> Ar Mer, 2006-10-18 am 12:20 -0400, ysgrifennodd Cal Peake:
> > Until something better comes along this'll get us back to the status quo.
> > 
> > @Andrew, this patch is a replacement for the one from yesterday.
> > 
> > From: Cal Peake <cp@absolutedigital.net>
> > 
> > Undeprecate the sysctl system call and default to always include it with
> > the option for embedded folks to exclude it.  Also, remove it's entry from
> > the feature removal file and fixup the comment in it's header file.
> > 
> > Signed-off-by: Cal Peake <cp@absolutedigital.net>
> 
> Acked-by: Alan Cox <alan@redhat.com>
> 
> Maybe also add "Do not add new entries to these tables" to address
> Andi's concern about people updating them.

I agree that those tables in sysctl.h are a right royal pita to maintain. 
And there sure is a lot of gunk in there which it would be nice to scrap.

So Andi's plan sounds reasonable to me - it'd only take a few lines to
implement sysctl(CTL_KERN/KERN_VERSION) as a back-compat thing (and it'll
be faster!).  And we add a printk so we find out which other sysctls (if
any) are being used in the wild.

?

