Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261681AbULTWt0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261681AbULTWt0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Dec 2004 17:49:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261675AbULTWrm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Dec 2004 17:47:42 -0500
Received: from gprs215-245.eurotel.cz ([160.218.215.245]:25736 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S261671AbULTWlS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Dec 2004 17:41:18 -0500
Date: Mon, 20 Dec 2004 23:41:02 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Nishanth Aravamudan <nacc@us.ibm.com>
Cc: hugang@soulinfo.com, linux-kernel@vger.kernel.org
Subject: Re: [PATH] swsusp update 1/3
Message-ID: <20041220224102.GB464@elf.ucw.cz>
References: <20041120224937.GA979@elf.ucw.cz> <20041122072215.GA13874@hugang.soulinfo.com> <20041122102612.GA1063@elf.ucw.cz> <20041122103240.GA11323@hugang.soulinfo.com> <20041122110247.GB1063@elf.ucw.cz> <20041122165823.GA10609@hugang.soulinfo.com> <20041123221430.GF25926@elf.ucw.cz> <20041124112834.GA1128@elf.ucw.cz> <20041124183031.GA6457@hugang.soulinfo.com> <20041220214517.GD13972@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041220214517.GD13972@us.ibm.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > +	if (nr_free_pages() < nr_copy_pages + PAGES_FOR_IO) {
> > +		printk("swsusp: need %d pages, free %d pages\n", 
> > +				nr_copy_pages, nr_free_pages());
> > +		printk("swsusp: Freeing memory:...     ");
> > +		while (shrink_all_memory(nr_copy_pages * 2)) {
> > +			current->state = TASK_INTERRUPTIBLE;
> > +			schedule_timeout(HZ/5);
> 
> This should be msleep_interruptible() [I do not see any wait-queue events around
> this code].

Agreed, it also makes code nicer... Anyway, the loop should not be
needed in the first place....

								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
