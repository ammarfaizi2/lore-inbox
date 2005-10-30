Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932072AbVJ3VSU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932072AbVJ3VSU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Oct 2005 16:18:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932073AbVJ3VSU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Oct 2005 16:18:20 -0500
Received: from anf141.internetdsl.tpnet.pl ([83.17.87.141]:31154 "EHLO
	anf141.internetdsl.tpnet.pl") by vger.kernel.org with ESMTP
	id S932072AbVJ3VSU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Oct 2005 16:18:20 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Ingo Oeser <ioe-lkml@rameria.de>
Subject: Re: [PATCH 1/3] swsusp: rework swsusp_suspend
Date: Sun, 30 Oct 2005 22:18:43 +0100
User-Agent: KMail/1.8.2
Cc: Andrew Morton <akpm@osdl.org>, Pavel Machek <pavel@suse.cz>,
       linux-kernel@vger.kernel.org
References: <200510301637.48842.rjw@sisk.pl> <200510301640.34306.rjw@sisk.pl> <200510301854.25637.ioe-lkml@rameria.de>
In-Reply-To: <200510301854.25637.ioe-lkml@rameria.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200510302218.43871.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sunday, 30 of October 2005 18:54, Ingo Oeser wrote:
> Hi Rafael,
> 
> On Sunday 30 October 2005 16:40, Rafael J. Wysocki wrote:
> > This patch makes only the functions in swsusp.c call functions in snapshot.c
> > and not both ways.  Basically, it moves the code without changing its
> > functionality.
>  
> This is not quite true.
> 
> >  #else
> > -static int save_highmem(void) { return 0; }
> > +int save_highmem(void) { return 0; }
> >  int restore_highmem(void) { return 0; }
> >  #endif /* CONFIG_HIGHMEM */
> 
> Here you change code, which will be optimized completely away to
> an empty function, which bloats the kernel.
> 
> Please put these two functions into a local header like this:
> 
> #ifdef CONFIG_HIGHMEM
> int save_highmem(void);
> int restore_highmem(void);
> #else
> static inline int save_highmem(void) { return 0; }
> static inline int restore_highmem(void) { return 0; }
> #endif
> 
> 
> That way no having no highmem means, this code is not used at all
> and everything using the return code and expecting != 0 is going
> to be optimized away. 
> 
> I think everyone CCed will agree here :-)

Of course you're right, I'll do that.

Thanks a lot for the comment.

Greetings,
Rafael
