Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266476AbUG2BGa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266476AbUG2BGa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 21:06:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267397AbUG2BG3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 21:06:29 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:60344 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S266476AbUG2BGT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 21:06:19 -0400
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andrew Morton <akpm@osdl.org>, suparna@in.ibm.com, fastboot@osdl.org,
       mbligh@aracnet.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       jbarnes@engr.sgi.com
Subject: Re: [Fastboot] Re: Announce: dumpfs v0.01 - common RAS output API
References: <16734.1090513167@ocs3.ocs.com.au>
	<20040725235705.57b804cc.akpm@osdl.org>
	<m1r7qw7v9e.fsf@ebiederm.dsl.xmission.com>
	<200407280903.37860.jbarnes@engr.sgi.com> <25870000.1091042619@flay>
	<m14qnr7u7b.fsf@ebiederm.dsl.xmission.com>
	<20040728133337.06eb0fca.akpm@osdl.org>
	<1091044742.31698.3.camel@localhost.localdomain>
	<m1llh367s4.fsf@ebiederm.dsl.xmission.com>
	<1091055311.31923.3.camel@localhost.localdomain>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 28 Jul 2004 19:05:36 -0600
In-Reply-To: <1091055311.31923.3.camel@localhost.localdomain>
Message-ID: <m18yd362sf.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

> On Iau, 2004-07-29 at 00:17, Eric W. Biederman wrote:
> > What is your concern with stopping DMA?
> > - Not smashing the recovery routine.
> > - Getting a corrupted core dump because of on-going DMA?
> 
> Completely random happenings occurring when they are trivial to avoid.
> Given all the worries about SHA signed in kernel standalone objects I
> find it farcical that the same people don't even care about ensuring
> something isnt DMAing over their dump partition description.

I was asking so I could give a better answer.

As far as I can tell the long term solution is to simply run the
dumper from memory that reserved in the kernel that called panic().

At that point you might get a corrupt DUMP. But it is extremely
unlikely any DMA transactions will touch your reserved memory.
Only the most buggy drivers or hardware will be running
DMA to the invalid addresses.  At which point there is
very little you can do in any event.

Eric
