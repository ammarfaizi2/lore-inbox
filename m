Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262062AbUHWU2H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262062AbUHWU2H (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 16:28:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266663AbUHWU1K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 16:27:10 -0400
Received: from [193.12.224.70] ([193.12.224.70]:44520 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S262062AbUHWUJG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 16:09:06 -0400
Date: Mon, 23 Aug 2004 22:08:58 +0200
From: Erik Rigtorp <erik@rigtorp.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] make swsusp produce nicer screen output
Message-ID: <20040823200858.GA4593@linux.nu>
References: <20040820152317.GA7118@linux.nu> <20040823174217.GC603@openzaurus.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040823174217.GC603@openzaurus.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 23, 2004 at 07:42:18PM +0200, Pavel Machek wrote:
> Well, it looks nice, be sure to submit smooth version :-).
I'm working on it :).

> > @@ -85,10 +85,17 @@
> >  
> >  static void free_some_memory(void)
> >  {
> > -	printk("Freeing memory: ");
> > -	while (shrink_all_memory(10000))
> > -		printk(".");
> > -	printk("|\n");
> > +	int i = 0;
> > +	char *p = "-\|/";
> > +	
> > +	printk("Freeing memory:  ");
> > +	while (shrink_all_memory(10000)) {
> > +		printk("\b%c", p[i]);
> > +		i++;
> > +		if (i > 3)
> > +			i = 0;
> > +	}
> > +	printk("\bdone\n");
> >  }
> 
> I'd leave dots here. Its usefull to see if it done something or not.

Well, it will display a spinning thingy that is updated every time
shrink_all_memory(10000) returns. Maybe you want to see how much memory was
freed?

And do we need to handle the case when nr_copy_pages < 100?

/Erik
