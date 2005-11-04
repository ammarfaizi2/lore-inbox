Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161140AbVKDLZA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161140AbVKDLZA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 06:25:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161143AbVKDLZA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 06:25:00 -0500
Received: from ns.firmix.at ([62.141.48.66]:60350 "EHLO ns.firmix.at")
	by vger.kernel.org with ESMTP id S1161140AbVKDLY7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 06:24:59 -0500
Subject: Re: [patch] swapin rlimit
From: Bernd Petrovitsch <bernd@firmix.at>
To: Ingo Molnar <mingo@elte.hu>
Cc: Andrew Morton <akpm@osdl.org>, Badari Pulavarty <pbadari@gmail.com>,
       Linus Torvalds <torvalds@osdl.org>, jdike@addtoit.com, rob@landley.net,
       nickpiggin@yahoo.com.au, gh@us.ibm.com, kamezawa.hiroyu@jp.fujitsu.com,
       haveblue@us.ibm.com, mel@csn.ul.ie, mbligh@mbligh.org,
       kravetz@us.ibm.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
       lhms-devel@lists.sourceforge.net
In-Reply-To: <20051104102118.GA26388@elte.hu>
References: <E1EXEfW-0005ON-00@w-gerrit.beaverton.ibm.com>
	 <200511021747.45599.rob@landley.net> <43699573.4070301@yahoo.com.au>
	 <200511030007.34285.rob@landley.net>
	 <20051103163555.GA4174@ccure.user-mode-linux.org>
	 <1131035000.24503.135.camel@localhost.localdomain>
	 <20051103205202.4417acf4.akpm@osdl.org> <20051104072628.GA20108@elte.hu>
	 <1131099267.30726.43.camel@tara.firmix.at> <20051104102118.GA26388@elte.hu>
Content-Type: text/plain
Organization: Firmix Software GmbH
Date: Fri, 04 Nov 2005 12:17:49 +0100
Message-Id: <1131103069.2034.11.camel@tara.firmix.at>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-11-04 at 11:21 +0100, Ingo Molnar wrote:
> * Bernd Petrovitsch <bernd@firmix.at> wrote:
> > On Fri, 2005-11-04 at 08:26 +0100, Ingo Molnar wrote:
> > > * Andrew Morton <akpm@osdl.org> wrote:
> > > > Similarly, that SGI patch which was rejected 6-12 months ago to kill 
> > > > off processes once they started swapping.  We thought that it could be 
> > > > done from userspace, but we need a way for userspace to detect when a 
> > > > task is being swapped on a per-task basis.
> > > 
> > > wouldnt the clean solution here be a "swap ulimit"?
> > 
> > Hmm, where is the difference to "mlockall(MCL_CURRENT|MCL_FUTURE);"? 
> > OK, mlockall() can only be done by root (processes).
> 
> what do you mean? mlockall pins down all pages. swapin ulimit kills the 
                                                in memory.
> task (and thus frees all the RAM it had) when it touches swap for the 
> first time. These two solutions almost oppose each other!

Almost IMHO as locked pages in RAM avoid swapping totally. Probably
"complement each other" is more correct.

Given the limit for "max locked memory" it should pretty much behave the
same if the process gets on his limits.
OK, the difference may be loaded executable and lib pages.

Hmm, delivering a signal on the first swapped out page might be another
simple solution and the process might do something to avoid it.

The nice thing about "swap ulimit" is: It is easy to understand what it
is (which is always a good thing).
Generating a similar effect with the combination of 2 other features is
probably somewhat more arcane.

	Bernd
-- 
Firmix Software GmbH                   http://www.firmix.at/
mobil: +43 664 4416156                 fax: +43 1 7890849-55
          Embedded Linux Development and Services

