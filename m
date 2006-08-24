Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751062AbWHXKts@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751062AbWHXKts (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 06:49:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751088AbWHXKts
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 06:49:48 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:63361 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751062AbWHXKtr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 06:49:47 -0400
Subject: Re: [ckrm-tech] [RFC][PATCH] UBC: user resource beancounters
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: sekharan@us.ibm.com
Cc: rohitseth@google.com, Rik van Riel <riel@redhat.com>,
       ckrm-tech@lists.sourceforge.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andi Kleen <ak@suse.de>, Christoph Hellwig <hch@infradead.org>,
       Andrey Savochkin <saw@sw.ru>, devel@openvz.org, hugh@veritas.com,
       Ingo Molnar <mingo@elte.hu>, Kirill Korotaev <dev@sw.ru>,
       Pavel Emelianov <xemul@openvz.org>
In-Reply-To: <1156385072.7154.59.camel@linuxchandra>
References: <44E33893.6020700@sw.ru>
	 <1155929992.26155.60.camel@linuxchandra>  <44E9B3F5.3010000@sw.ru>
	 <1156196721.6479.67.camel@linuxchandra>
	 <1156211128.11127.37.camel@galaxy.corp.google.com>
	 <1156272902.6479.110.camel@linuxchandra>
	 <1156383881.8324.51.camel@galaxy.corp.google.com>
	 <1156385072.7154.59.camel@linuxchandra>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 24 Aug 2006 12:10:08 +0100
Message-Id: <1156417808.3007.78.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Mer, 2006-08-23 am 19:04 -0700, ysgrifennodd Chandra Seetharaman:
> > A single centralized structure that has fields that are mostly used by
> > every one should be okay I think.
> 
> You mean to say definition like
> 
> struct user_beancounter {
> 	fields;/* fields that exists now */
> 	
> 	int kmemsize_ctlr_info1;
> 	char *kmemsize_ctlr_info2;
> 
> 	char *oomguar_ctlr_info1;
> 	char *oomguar_ctlr_info2;
> 
> 	/* and so on */
> }
> 
> is the right thing to do ? even though oomguar controller doesn't care
> about kmemsize_ctlr_info* etc.,


All you need is

struct wombat_controller
{
	struct user_beancounter counter;
	void (*wombat_pest_control)(struct wombat *w);
	atomic_t wombat_population;
	int (*wombat_destructor)(struct wombat *w);
};

and just embed the counter in whatever you are controlling. The point of
the beancounters themselves is to be *SIMPLE*. It's unfortunate that
some folk seem obsessed with extending them for a million theoretical
projects rather than getting them in and working and then extending them
for real projects. Please lets not have another EVMS.

Alan

