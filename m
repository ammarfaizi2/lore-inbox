Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030391AbVKCRiT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030391AbVKCRiT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 12:38:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030392AbVKCRiS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 12:38:18 -0500
Received: from lakshmi.addtoit.com ([198.99.130.6]:57863 "EHLO
	lakshmi.solana.com") by vger.kernel.org with ESMTP id S1030391AbVKCRiS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 12:38:18 -0500
Date: Thu, 3 Nov 2005 13:27:34 -0500
From: Jeff Dike <jdike@addtoit.com>
To: Badari Pulavarty <pbadari@gmail.com>
Cc: Rob Landley <rob@landley.net>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Gerrit Huizenga <gh@us.ibm.com>, Ingo Molnar <mingo@elte.hu>,
       Kamezawa Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>,
       Dave Hansen <haveblue@us.ibm.com>, Mel Gorman <mel@csn.ul.ie>,
       "Martin J. Bligh" <mbligh@mbligh.org>, Andrew Morton <akpm@osdl.org>,
       kravetz@us.ibm.com, linux-mm <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       lhms <lhms-devel@lists.sourceforge.net>
Subject: Re: [Lhms-devel] [PATCH 0/7] Fragmentation Avoidance V19
Message-ID: <20051103182734.GA6639@ccure.user-mode-linux.org>
References: <E1EXEfW-0005ON-00@w-gerrit.beaverton.ibm.com> <200511021747.45599.rob@landley.net> <43699573.4070301@yahoo.com.au> <200511030007.34285.rob@landley.net> <20051103163555.GA4174@ccure.user-mode-linux.org> <1131035000.24503.135.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1131035000.24503.135.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 03, 2005 at 08:23:20AM -0800, Badari Pulavarty wrote:
> Yep. This is the exactly the issue other product groups normally raise
> on Linux. How do we measure memory pressure in linux ? Some of our
> software products want to grow or shrink their memory usage depending
> on the memory pressure in the system.

I think this is wrong.  Applications shouldn't be measuring host
memory pressure and trying to react to it.

This gives you no way to implement a global memory use policy - you
can't say "App X is the most important thing on the system and must
have all the memory it needs in order run as quickly as possible".

You can't establish any sort of priority between apps when it comes to
memory use, or change those priorities.

And how does this work when the system can change the amount of memory
that it has, such as when the app is inside a UML?

I think the right way to go is for willing apps to have an interface
through which they can be told "change your memory consumption by +-X"
and have a single daemon on the host tracking memory use and memory
pressure, and shuffling memory between the apps.

This allows the admin to set memory use priorities between the apps
and to exempt important ones from having memory pulled.

Measuring at the bottom and pushing memory pressure upwards also works
naturally for virtual machines and the apps running inside them.  The
host will push memory pressure at the virtual machines, which in turn
will push that pressure at their apps.

With UML, I have an interface where a daemon on the host can add or
remove memory from an instance.  I think the apps that are willing to
adjust should implement something similar.

				Jeff
