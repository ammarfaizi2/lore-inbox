Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932638AbVKXT34@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932638AbVKXT34 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Nov 2005 14:29:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932641AbVKXT34
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Nov 2005 14:29:56 -0500
Received: from mx2.suse.de ([195.135.220.15]:29095 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932638AbVKXT3z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Nov 2005 14:29:55 -0500
Date: Thu, 24 Nov 2005 20:29:53 +0100
From: Andi Kleen <ak@suse.de>
To: thockin@hockin.org
Cc: Andi Kleen <ak@suse.de>, "Eric W. Biederman" <ebiederm@xmission.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Gerd Knorr <kraxel@suse.de>,
       Linus Torvalds <torvalds@osdl.org>, Dave Jones <davej@redhat.com>,
       Zachary Amsden <zach@vmware.com>, Pavel Machek <pavel@ucw.cz>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "H. Peter Anvin" <hpa@zytor.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>, Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch] SMP alternatives
Message-ID: <20051124192953.GT20775@brahms.suse.de>
References: <20051124133907.GG20775@brahms.suse.de> <1132842847.13095.105.camel@localhost.localdomain> <20051124142200.GH20775@brahms.suse.de> <1132845324.13095.112.camel@localhost.localdomain> <20051124145518.GI20775@brahms.suse.de> <m1psoqgk18.fsf@ebiederm.dsl.xmission.com> <20051124153635.GJ20775@brahms.suse.de> <20051124191207.GB2468@hockin.org> <20051124191445.GR20775@brahms.suse.de> <20051124192414.GA3670@hockin.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051124192414.GA3670@hockin.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> We implemented AMD's reference algorithm, and made it work in the presence
> of a hardware IO hole.  It seems to work beautifully, but the last step is
> turning a (node:chip-select) into a (node:dimm).  Simple boards will use
> simple mappings, but we can't know that without board specific info.
> Especially with quad-rank DIMMs. :)

If you get something working it would be good if you could share the code
(even if it still needs to be tweaked) 

> 
> > > table to map chip-selects onto DIMMs? :)
> > 
> > I proposed something like that - best with an ASCII string
> > ("First DIMM on the top left corner") But getting such stuff into BIOS 
> > is difficult and long winded.
> 
> It would be easy enough to get into LinuxBIOS. :)
> 
> Seriously, this is work that is *long* overdue.  I have been wanting to
> look at this for over a year, but I have not had time.
> 
> Doing proper architecture and chipset-specific ECC/error handling which
> ties into a bigger abstracted error system is going to be really nice.

IMNSHO the x86-64 mce.c with its error log is a reasonable start. All
the smarts can be in user space and in mcelog.c. DIMM decoding
is a special case though because the information is really useful
to be printed onto the screen for fatal MCEs. So that one is better
in kernel space.

-Andi
