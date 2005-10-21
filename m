Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964995AbVJUPt7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964995AbVJUPt7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Oct 2005 11:49:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964998AbVJUPt6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Oct 2005 11:49:58 -0400
Received: from moraine.clusterfs.com ([66.96.26.190]:60829 "EHLO
	moraine.clusterfs.com") by vger.kernel.org with ESMTP
	id S964997AbVJUPt5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Oct 2005 11:49:57 -0400
From: Nikita Danilov <nikita@clusterfs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17240.54704.515573.252722@gargle.gargle.HOWL>
Date: Fri, 21 Oct 2005 15:49:04 +0400
To: Dave Hansen <haveblue@us.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, Mike Kravetz <kravetz@us.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-mm <linux-mm@kvack.org>, Magnus Damm <magnus.damm@gmail.com>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Subject: Re: [PATCH 1/4] Swap migration V3: LRU operations
Newsgroups: gmane.linux.kernel,gmane.linux.kernel.mm
In-Reply-To: <1129874762.26533.5.camel@localhost>
References: <20051020225935.19761.57434.sendpatchset@schroedinger.engr.sgi.com>
	<20051020225940.19761.93396.sendpatchset@schroedinger.engr.sgi.com>
	<1129874762.26533.5.camel@localhost>
X-Mailer: VM 7.17 under 21.5 (patch 17) "chayote" (+CVS-20040321) XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Hansen writes:

[...]

 > 
 > It makes much more sense to have something like:
 > 
 >         if (ret == ISOLATION_IMPOSSIBLE) {
 >         	 list_del(&page->lru);
 >          	 list_add(&page->lru, src);
 >         }
 > 
 > than
 > 
 > +               if (rc == -1) {  /* Not possible to isolate */
 > +                       list_del(&page->lru);
 > +                       list_add(&page->lru, src);
 > +                } if 

And
         if (ret == ISOLATION_IMPOSSIBLE)
          	 list_move(&page->lru, src);

is even better.

Nikita.
