Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261961AbUCDXXl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Mar 2004 18:23:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261964AbUCDXXl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Mar 2004 18:23:41 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:41736
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S261961AbUCDXXj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Mar 2004 18:23:39 -0500
Date: Fri, 5 Mar 2004 00:24:18 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Rik van Riel <riel@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, Peter Zaitsev <peter@mysql.com>,
       mbligh@aracnet.com, linux-kernel@vger.kernel.org
Subject: Re: 2.4.23aa2 (bugfixes and important VM improvements for the high end)
Message-ID: <20040304232418.GW4922@dualathlon.random>
References: <20040304175821.GO4922@dualathlon.random> <Pine.LNX.4.44.0403041711500.20043-100000@chimarrao.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0403041711500.20043-100000@chimarrao.boston.redhat.com>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 04, 2004 at 05:14:30PM -0500, Rik van Riel wrote:
> > or maybe you mean the page_table_lock hold during copy-user that Andrew
> > mentioned? (copy-user doesn't mean "all VM operations" not sure if you
> > meant this or the usual locking of every 2.4/2.6 kernel out there)
> 
> True, there are some other operations.  However, when

could you name one that is serialized in 4:4 and not in 3:1 with an mm
lock? just curious. there are tons of VM operations serialized by the
page_table_lock that hurts with threads in 3:1 too. I understood only
copy-user needs the additional locking.

> you consider the fact that copy-user operations are
> needed for so many things they are the big bottleneck.
> 
> Making it possible to copy things to and from userspace
> in a lockless way will help performance quite a bit...

I don't expect an huge speedup but certainly it would be measurable.
