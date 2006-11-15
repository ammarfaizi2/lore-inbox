Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161562AbWKOVUb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161562AbWKOVUb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 16:20:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161683AbWKOVUb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 16:20:31 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:65241 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1161562AbWKOVUa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 16:20:30 -0500
From: ebiederm@xmission.com (Eric W. Biederman)
To: Andrew Morton <akpm@osdl.org>
Cc: Andi Kleen <ak@suse.de>, Linus Torvalds <torvalds@osdl.org>,
       discuss@x86-64.org, William Cohen <wcohen@redhat.com>,
       Komuro <komurojun-mbn@nifty.com>, Ernst Herzberg <earny@net4u.de>,
       Andre Noll <maan@systemlinux.org>, oprofile-list@lists.sourceforge.net,
       Jens Axboe <jens.axboe@oracle.com>,
       linux-usb-devel@lists.sourceforge.net, phil.el@wanadoo.fr,
       Adrian Bunk <bunk@stusta.de>, Ingo Molnar <mingo@redhat.com>,
       Alan Stern <stern@rowland.harvard.edu>,
       linux-pci@atrey.karlin.mff.cuni.cz,
       Stephen Hemminger <shemminger@osdl.org>,
       Prakash Punnoor <prakash@punnoor.de>, Len Brown <len.brown@intel.com>,
       Alex Romosan <romosan@sycorax.lbl.gov>, gregkh@suse.de,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrey Borzenkov <arvidjaar@mail.ru>
Subject: Re: [discuss] Re: 2.6.19-rc5: known regressions (v3)
References: <Pine.LNX.4.64.0611071829340.3667@g5.osdl.org>
	<200611151945.31535.ak@suse.de>
	<Pine.LNX.4.64.0611151105560.3349@woody.osdl.org>
	<200611152023.53960.ak@suse.de>
	<20061115122118.14fa2177.akpm@osdl.org>
Date: Wed, 15 Nov 2006 14:18:24 -0700
In-Reply-To: <20061115122118.14fa2177.akpm@osdl.org> (Andrew Morton's message
	of "Wed, 15 Nov 2006 12:21:18 -0800")
Message-ID: <m18xic4den.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> writes:

> Is it correct to say that oprofile-on-2.6.18 works, and that
> oprofile-on-2.6.19-rc5 does not?
>
> Or is there some sort of workaround for this, or does 2.6.19-rc5 only fail
> in some particular scenarios?
>
> If it's really true that oprofile is simply busted then that's a serious
> problem and we should find some way of unbusting it.  If that means just
> adding a dummy "0" entry which always returns zero or something like that,
> then fine.
>
> But we can't just go and bust it.

The simple question.  If we turn off the NMI watchdog on 2.6.19-rc5 
does oprofile work?  I believe that is what Andi said.

The description I read was a resource conflict. The resources oprofile
just expects it can used are already in use so we tell it no and
the user space oprofile doesn't cope.

Now I don't know the interface allows us to rename the interfaces
from 1 2 3 to 0 1 2.  If we can then that looks like something we can
fix.  Otherwise from the description I tend to agree with Andi.

The user space application assumed it own hardware that it did not.

Hmm.  I bet if nothing else we could move the NMI watchdog from 0 to 3
and make things work that way...


Eric
