Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750773AbVKMWcd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750773AbVKMWcd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Nov 2005 17:32:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750776AbVKMWcd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Nov 2005 17:32:33 -0500
Received: from anf141.internetdsl.tpnet.pl ([83.17.87.141]:41879 "EHLO
	anf141.internetdsl.tpnet.pl") by vger.kernel.org with ESMTP
	id S1750773AbVKMWcc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Nov 2005 17:32:32 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFT][PATCH 2/3] swsusp: introduce the swap map structure
Date: Sun, 13 Nov 2005 23:33:13 +0100
User-Agent: KMail/1.8.3
Cc: LKML <linux-kernel@vger.kernel.org>
References: <200511122113.22177.rjw@sisk.pl> <200511122122.45063.rjw@sisk.pl> <20051113211652.GE2119@elf.ucw.cz>
In-Reply-To: <20051113211652.GE2119@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200511132333.13647.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sunday, 13 of November 2005 22:16, Pavel Machek wrote:
> Hi!
> 
> > This patch introduces the swap map structure that can be used by swsusp for
> > keeping tracks of data pages written to the swap.  The structure itself is
> > described in a comment within the patch.
> > 
> > The overall idea is to reduce the amount of metadata written to the swap
> > and to write and read the image pages sequentially, in a file-alike way.
> > This makes the swap-handling part of swsusp fairly independent of its
> > snapshot-handling part and will hopefully allow us to completely
> > separate these two parts in the future.
> > 
> > Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> 
> ACK.
> 
> > +struct swap_map_handle {
> > +	void			*tfm; /* Needed for the encryption */
> > +	struct swap_map_page	*cur;
> > +	unsigned int		k;
> > +};
> 
> I thought you killed encryption in 1/3?

And I thought so, but this one apparently survived ...

> > @@ -33,6 +33,9 @@
> >  
> >  #include "power.h"
> >  
> > +struct pbe *pagedir_nosave = NULL;
> > +unsigned int nr_copy_pages = 0;
> > +
> >  #ifdef CONFIG_HIGHMEM
> >  struct highmem_page {
> >  	char *data;
> 
> You don't need to initialize to zero/NULL.

OK

I'll make the changes and post for inclusion into -mm in a couple of days.

Greetings,
Rafael
