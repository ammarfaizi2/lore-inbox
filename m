Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263591AbUC3Jz4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 04:55:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263593AbUC3Jzz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 04:55:55 -0500
Received: from ecbull20.frec.bull.fr ([129.183.4.3]:6290 "EHLO
	ecbull20.frec.bull.fr") by vger.kernel.org with ESMTP
	id S263591AbUC3Jzv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 04:55:51 -0500
Message-ID: <40694474.50776A10@nospam.org>
Date: Tue, 30 Mar 2004 11:57:08 +0200
From: Zoltan Menyhart <Zoltan.Menyhart_AT_bull.net@nospam.org>
Reply-To: Zoltan.Menyhart@bull.net
Organization: Bull S.A.
X-Mailer: Mozilla 4.78 [en] (X11; U; AIX 4.3)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: Erich Focht <efocht@hpce.nec.com>
CC: linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Migrate pages from a ccNUMA node to another
References: <4063F188.66DB690A@nospam.org> <200403300116.01877.efocht@hpce.nec.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Erich Focht wrote:
> 
> Szia Zoltan,
> 
> > - Migrate pages identified by their physical addresses to another NUMA node
> You want this only for your "AI" keeping track of the hw counters in
> the chipset? I hope you can teach it to keep track of the bandwidth of
> all processes on the machine, otherwise it might disturb the processes
> more than it helps them... and waste the machine's bandwidth with
> migrating pages.

Szervusz Erich,

I put AI between quotation marks because it is not a real intelligence.
It should not waste much time on being intelligent :-)
At least we have not managed to find out a general purpose solution that
could cope with no matter what application.
We try to tune parameters, like sampling period / time, how many pages
are checked, when we consider a page as "hot", how many % or # cycles
distant vs. local justifies the migration...
We try to set up a "profile" for an application.
The launcher of the application takes into account the profile and
the AI evaluates the HW counters according this profile info.
I think most of the huge applications of our clients will run several
times with different data but with the data of similar behavior.
The clients will have the ability to tune their application profiles. 

> > - Migrate pages of a virtual user address range to another NUMA node
> This is good. I'm thinking about the rss/node patches, they would tell
> you when you should think about migrating something for a process. My
> current usage model would be simpler: for a given mm migrate all pages
> currently on node A to node B. But the flexibility of your API will
> certainly not remain unused.

You should migrate if it worth the cost of the migration to do
(private malloc()-ed data, stack,...).

Do you mean to guess in the kernel what pages to move ?

I need "real information" :-)) to decide, this is either I ask the HW or
I wait the application to tell me its requirement.

> > BTW Has someone a machine with a chip set other than i82870 ?
> ??? As far as I know SGI, HP, NEC and IBM have all their own NUMA
> chipsets for IA64. Was this the question? Are you looking for hardware
> counters?

I'd like to know - and someone to try :-)) - how much it costs on another
chip set to measure the page usage statistics, say for 1 Gbytes of memory...

Thanks,

Zoltán
