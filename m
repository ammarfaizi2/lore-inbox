Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261665AbULTWrh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261665AbULTWrh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Dec 2004 17:47:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261675AbULTWrg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Dec 2004 17:47:36 -0500
Received: from gprs215-245.eurotel.cz ([160.218.215.245]:24712 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S261665AbULTWkX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Dec 2004 17:40:23 -0500
Date: Mon, 20 Dec 2004 23:40:06 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Nishanth Aravamudan <nacc@us.ibm.com>
Cc: hugang@soulinfo.com, linux-kernel@vger.kernel.org
Subject: Re: swsusp bigdiff [was Re: [PATCH] Software Suspend split to two stage V2.]
Message-ID: <20041220224005.GA464@elf.ucw.cz>
References: <20041119194007.GA1650@hugang.soulinfo.com> <20041120003010.GG1594@elf.ucw.cz> <20041220214443.GC13972@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041220214443.GC13972@us.ibm.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!


> > @@ -85,13 +86,26 @@
> >  
> >  static void free_some_memory(void)
> >  {
> > -	printk("Freeing memory: ");
> > -	while (shrink_all_memory(10000))
> > -		printk(".");
> > -	printk("|\n");
> > +	int i;
> > +	for (i=0; i<5; i++) {
> > +		int i = 0, tmp;
> > +		long pages = 0;
> > +		char *p = "-\\|/";
> > +
> > +		printk("Freeing memory...  ");
> > +		while ((tmp = shrink_all_memory(10000))) {
> > +			pages += tmp;
> > +			printk("\b%c", p[i]);
> > +			i++;
> > +			if (i > 3)
> > +				i = 0;
> > +		}
> > +		printk("\bdone (%li pages freed)\n", pages);
> > +		current->state = TASK_INTERRUPTIBLE;
> > +		schedule_timeout(HZ/5);
> 
> This should be msleep_interruptible() [I do not see any wait-queue events around
> this code].

Ugh, okay, this is my dirty hack to work around shrink_all_memory()
problems. Fixed, anyway.
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
