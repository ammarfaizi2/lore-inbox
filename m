Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261561AbTEXOag (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 May 2003 10:30:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261780AbTEXOag
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 May 2003 10:30:36 -0400
Received: from x35.xmailserver.org ([208.129.208.51]:15241 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S261561AbTEXOaf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 May 2003 10:30:35 -0400
X-AuthUser: davidel@xmailserver.org
Date: Sat, 24 May 2003 07:43:12 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mcafeelabs.com
To: "Boehm, Hans" <hans_boehm@hp.com>
cc: "'Arjan van de Ven'" <arjanv@redhat.com>, Hans Boehm <Hans.Boehm@hp.com>,
       "MOSBERGER, DAVID (HP-PaloAlto,unix3)" <davidm@hpl.hp.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-ia64@linuxia64.org
Subject: RE: [Linux-ia64] Re: web page on O(1) scheduler
In-Reply-To: <Pine.LNX.4.55.0305232225010.3538@bigblue.dev.mcafeelabs.com>
Message-ID: <Pine.LNX.4.55.0305240716230.3978@bigblue.dev.mcafeelabs.com>
References: <75A9FEBA25015040A761C1F74975667D01442109@hplex4.hpl.hp.com>
 <Pine.LNX.4.55.0305232225010.3538@bigblue.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 May 2003, Davide Libenzi wrote:

> You need a write memory barrier even on the unlock. Consider this :
>
> 	spinlock = 1;
> 	...
> 	protected_resource = NEWVAL;
> 	spinlock = 0;
>
> ( where spinlock = 0/1 strip down, but do not lose the concept, the lock
> operation ). If a CPU reorder those writes, another CPU might see the lock
> drop before the protected resource assignment. And this is usually bad
> for obvious reasons.

David made me notice about a brain misfire here. You need protection even
for loads crossing the unlock. For the same obvious reasons :) Yes, a
realease barrier will be sufficent for ia64, while you'll need an mfence
on P4.



- Davide

