Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265096AbUFRK0B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265096AbUFRK0B (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 06:26:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265100AbUFRK0B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 06:26:01 -0400
Received: from linuxhacker.ru ([217.76.32.60]:3006 "EHLO shrek.linuxhacker.ru")
	by vger.kernel.org with ESMTP id S265096AbUFRKV7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 06:21:59 -0400
Date: Fri, 18 Jun 2004 13:15:20 +0300
From: Oleg Drokin <green@linuxhacker.ru>
To: Helge Hafting <helge.hafting@hist.no>
Cc: Petter Larsen <pla@morecom.no>, linux-kernel@vger.kernel.org,
       ext3 <ext3-users@redhat.com>
Subject: Re: mode data=journal in ext3. Is it safe to use?
Message-ID: <20040618101520.GA2389@linuxhacker.ru>
References: <40FB8221D224C44393B0549DDB7A5CE83E31B1@tor.lokal.lan> <1087322976.1874.36.camel@pla.lokal.lan> <200406160734.i5G7YZwV002051@car.linuxhacker.ru> <1087460837.2765.31.camel@pla.lokal.lan> <20040617170939.GO2659@linuxhacker.ru> <40D2B8C3.8090908@hist.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40D2B8C3.8090908@hist.no>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Fri, Jun 18, 2004 at 11:41:23AM +0200, Helge Hafting wrote:

> >If you can reproduce a garbage in files in ordered journal mode, that 
> >would be a
> >bug that should be fixed then.
> Hard to _produce_, but consider:
> 1. Write data to an existing file
> 2. Sync metadata
> 3. data is forced out because of ordered mode, a powerout crash happens
>    in the middle of this. The file now has a block with a mix of new 
> and old,

Well, this is not much worse than having two blocks, one from old file
and one from new after a crash.

>    it may even be unreadable due to a bad sector checksum.

Well, in data journaled mode you may get unreadable journal, is this much
better? (Also original question was about CF flash media, so no bad sector
problems I presume).

> With data journalling you either get the old data (because the crash 
> happened
> during a write to the journal) or new data (crash happened during data 
> write,

Well, while with data journaling mode your granularity is one block,
with data ordered it is one sector.

> the data is restored from the good copy in the journal.)

Bye,
    Oleg
