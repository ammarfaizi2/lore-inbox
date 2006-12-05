Return-Path: <linux-kernel-owner+willy=40w.ods.org-S968313AbWLEEG7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S968313AbWLEEG7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 23:06:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S968317AbWLEEG7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 23:06:59 -0500
Received: from ns2.suse.de ([195.135.220.15]:34254 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S968313AbWLEEG6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 23:06:58 -0500
From: Neil Brown <neilb@suse.de>
To: Jiri Kosina <jikos@jikos.cz>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Date: Tue, 5 Dec 2006 15:07:11 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17780.61551.896455.157225@cse.unsw.edu.au>
Subject: Re: 2.6.19-rc6-mm2
In-Reply-To: message from Neil Brown on Tuesday December 5
References: <20061128020246.47e481eb.akpm@osdl.org>
	<Pine.LNX.4.64.0611290147400.28502@twin.jikos.cz>
	<17780.52337.767875.963882@cse.unsw.edu.au>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday December 5, neilb@suse.de wrote:
> 
> I notice it says:
>                      |
>                      v
> >  090: 6b 6b 6b 6b 6a 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
> >  Single bit error detected. Probably bad RAM.
> >  Run memtest86+ or a similar memory test tool.
> 
> Have you tried running memtest86 ??

As Andrew correctly pointed out, this bit error is not a RAM problem.
It is actually the low bit of a counter a spinlock that was
decremented just before the WARN_ON.  So it simply indicates that the
inode had already been freed, which I think we knew already.

Unfortunately I still have no idea why that inode had been
freed but was still referenced by a dentry....

How repeatable as this bug?  How did you narrow it down to that patch?
Did you use git-bisect or something else?


Thanks,
NeilBrown
