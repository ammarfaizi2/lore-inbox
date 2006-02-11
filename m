Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932230AbWBKEQa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932230AbWBKEQa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 23:16:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932234AbWBKEQa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 23:16:30 -0500
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:1216 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S932227AbWBKEQ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 23:16:29 -0500
Date: Sat, 11 Feb 2006 13:15:17 +0900
From: Yasunori Goto <y-goto@jp.fujitsu.com>
To: Dave Hansen <haveblue@us.ibm.com>
Subject: Re: [Lhms-devel] [RFC/PATCH: 002/010] Memory hotplug for new nodes with pgdat allocation. (Wait table and zonelists initalization)
Cc: "Luck, Tony" <tony.luck@intel.com>, Andi Kleen <ak@suse.de>,
       "Tolentino, Matthew E" <matthew.e.tolentino@intel.com>,
       linux-ia64@vger.kernel.org,
       Linux Kernel ML <linux-kernel@vger.kernel.org>,
       x86-64 Discuss <discuss@x86-64.org>,
       Linux Hotplug Memory Support 
	<lhms-devel@lists.sourceforge.net>,
       Hiroyuki KAMEZAWA <kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <1139589128.9209.80.camel@localhost.localdomain>
References: <20060210223841.C532.Y-GOTO@jp.fujitsu.com> <1139589128.9209.80.camel@localhost.localdomain>
X-Mailer-Plugin: BkASPil for Becky!2 Ver.2.063
Message-Id: <20060211125941.D35C.Y-GOTO@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.24.02 [ja]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> On Fri, 2006-02-10 at 23:20 +0900, Yasunori Goto wrote:
> > 
> >  static __meminit
> >  void zone_wait_table_init(struct zone *zone, unsigned long
> > zone_size_pages)
> >  {
> > -       int i;
> > +       int i, hotadd = (system_state == SYSTEM_RUNNING);
> >         struct pglist_data *pgdat = zone->zone_pgdat;
> > +       unsigned long allocsize;
> >  
> >         /*
> >          * The per-page waitqueue mechanism uses hashed waitqueues
> >          * per zone.
> >          */
> > +       if (hotadd && (zone_size_pages == PAGES_PER_SECTION))
> > +               zone_size_pages = PAGES_PER_SECTION << 2; 
> 
> I don't think I understand this calculation.  You online only 4 sections
> worth of pages?

Ummmmm.
I realized that I've forgotten many things about this patch
due to long time keeping in storage. 
At least here looks strange indeed.
I need shake my brain to recall it. :-(


-- 
Yasunori Goto 



