Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932181AbVLDAZO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932181AbVLDAZO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Dec 2005 19:25:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932186AbVLDAZO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Dec 2005 19:25:14 -0500
Received: from anf141.internetdsl.tpnet.pl ([83.17.87.141]:51110 "EHLO
	anf141.internetdsl.tpnet.pl") by vger.kernel.org with ESMTP
	id S932181AbVLDAZL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Dec 2005 19:25:11 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH][mm][Fix] swsusp: fix counting of highmem pages
Date: Sun, 4 Dec 2005 01:26:13 +0100
User-Agent: KMail/1.8.3
Cc: Andy Isaacson <adi@hexapodia.org>, LKML <linux-kernel@vger.kernel.org>
References: <200512032140.15192.rjw@sisk.pl> <200512040102.24668.rjw@sisk.pl> <20051204001055.GE5198@elf.ucw.cz>
In-Reply-To: <20051204001055.GE5198@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512040126.14048.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sunday, 4 of December 2005 01:10, Pavel Machek wrote:
> > > Ah, okay, I see. As long as the include hack is gone, its okay with me.
> > 
> > All right.  Appended is the latest version.
> 
> Okay, seems I'll need to get latest mm version, because this changed a
> lot. Sorry, that will be tommorow afternoon.

OK

> > Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> > 
> >  kernel/power/snapshot.c |   25 ++++++++++++++++++-------
> >  kernel/power/swsusp.c   |    3 ++-
> >  2 files changed, 20 insertions(+), 8 deletions(-)
> > 
> > Index: linux-2.6.15-rc3-mm1/kernel/power/snapshot.c
> > ===================================================================
> > --- linux-2.6.15-rc3-mm1.orig/kernel/power/snapshot.c	2005-12-03 00:14:49.000000000 +0100
> > +++ linux-2.6.15-rc3-mm1/kernel/power/snapshot.c	2005-12-04 00:35:14.000000000 +0100
> > @@ -37,6 +37,12 @@
> > @@ -52,13 +58,12 @@
> >  				if (!pfn_valid(pfn))
> >  					continue;
> >  				page = pfn_to_page(pfn);
> > -				if (PageReserved(page))
> > -					continue;
> > -				if (PageNosaveFree(page))
> > -					continue;
> > -				n++;
> > +				if (!PageNosaveFree(page) && !PageReserved(page))
> > +					n++;
> >  			}
> 
> As far as I can see, this does not change anything. Can you keep it
> out?

OK

> >  		}
> > +	if (n > 0)
> > +		n += (n * KMALLOC_SIZE + PAGE_SIZE - 1) / PAGE_SIZE + 1;
> >  	return n;
> >  }
> 
> Can't you just n += n/50 here? Playing with KMALLOC_SIZE knows way too
> much about memory allocation details.

I do the "n + n/50" later on, so I can just drop all of the above changes
if they are too complicated.

Greetings,
Rafael
