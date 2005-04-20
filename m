Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261468AbVDTSyV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261468AbVDTSyV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Apr 2005 14:54:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261471AbVDTSyV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Apr 2005 14:54:21 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:38837 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261468AbVDTSyQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Apr 2005 14:54:16 -0400
Subject: Re: [RFC][PATCH] nameing reserved pages [0/3]
From: Dave Hansen <haveblue@us.ibm.com>
To: Arjan van de Ven <arjan@infradead.org>
Cc: KAMEZAWA Hiroyuki 
	<kamezawa.hiroyu.kamezawa.hiroyu@jp.fujitsu.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Hariprasad Nellitheertha [imap]" <hari@in.ibm.com>
In-Reply-To: <1114000447.6238.64.camel@laptopd505.fenrus.org>
References: <426644DA.70105@jp.fujitsu.com>
	 <1114000447.6238.64.camel@laptopd505.fenrus.org>
Content-Type: text/plain
Date: Wed, 20 Apr 2005 10:00:36 -0700
Message-Id: <1114016436.6927.9.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-04-20 at 14:34 +0200, Arjan van de Ven wrote:
> On Wed, 2005-04-20 at 21:02 +0900, KAMEZAWA Hiroyuki wrote:
> > Hi,
> > 
> > There are several types of PG_reserved pages,
> > (a) Memory Hole
> > (b) Used by Kernel
> > (c) Set by drivers
> > (d) Isorated by MCA
> > (e) used by perfmon
> > etc....
> > 
> > I think it's useful to distinguish many types of PG_reserved pages.
> 
> I'm not so sure about this. at all.

Neither am I, that's why I hoped somebody would figure out something
better :)

> > For example, Memory Hotplug can ignore (a).
> 
> Memory Hotplug can also use page_is_ram().

It uses this, to some degree, internally.  But, things like the e820
table don't get updated as memory hotplugs occur.

This should a way to give more fine-grained information about what pages
are availabe as RAM at any point in time. kdump would need something
like this to figure out which pages inside of /dev/mem are actually
valid to dump.  Here was another approach that used /proc files:

	http://lkml.org/lkml/2005/3/24/11

> /dev/memstate really looks like a bad idea to me as well... I rather
> have less than more /dev/*mem*

Any other ideas?

-- Dave

