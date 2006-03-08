Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932234AbWCHSjl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932234AbWCHSjl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 13:39:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932326AbWCHSjl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 13:39:41 -0500
Received: from fmr23.intel.com ([143.183.121.15]:57491 "EHLO
	scsfmr003.sc.intel.com") by vger.kernel.org with ESMTP
	id S932234AbWCHSjl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 13:39:41 -0500
Message-Id: <200603081838.k28Icwg10327@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'David Gibson'" <david@gibson.dropbear.id.au>,
       "Zhang, Yanmin" <yanmin.zhang@intel.com>
Cc: "Andrew Morton" <akpm@osdl.org>, "William Lee Irwin" <wli@holomorphy.com>,
       <linux-kernel@vger.kernel.org>
Subject: RE: hugepage: Strict page reservation for hugepage inodes
Date: Wed, 8 Mar 2006 10:38:58 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Thread-Index: AcZCmrcLRpxa8vigQ7GBTa0cXrK8/AAQ/OFA
In-Reply-To: <20060308102314.GB32571@localhost.localdomain>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Gibson wrote on Wednesday, March 08, 2006 2:23 AM
> Yes.  This is a simplifying assumption.  I know of no real application
> that will waste pages because of this behaviour.  If you know one,
> maybe we will need to reconsider.
> 
> > I have an idea. How about to record all the start/end address of
> > huge page mmaping of the inode? Long long ago, there was a patch at 
> > http://marc.theaimsgroup.com/?l=lse-tech&m=108187931924134&w=2.
> > Of course, we need port it to the latest kernel if this idea is better.
> 
> I know the patch - I was going to port it to the current kernel, but
> came up with my patch instead, because it seemed like a simpler
> approach.

I really think the Variable length reservation system is the way to go
for tracking hugetlb commit.  It is more robust and in my opinion, it
is better than traverse the page cache radix tree.  At least, you don't
have to worry about all the race condition there.  Oh, it also can get
rid of the hugetlb_instantiation_mutex that was introduced.  Someday,
people is going to scream at you for serializing hugetlb fault path.

- Ken

