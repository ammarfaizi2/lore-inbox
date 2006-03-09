Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932624AbWCIAT7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932624AbWCIAT7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 19:19:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932625AbWCIAT7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 19:19:59 -0500
Received: from fmr22.intel.com ([143.183.121.14]:63178 "EHLO
	scsfmr002.sc.intel.com") by vger.kernel.org with ESMTP
	id S932624AbWCIAT7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 19:19:59 -0500
Message-Id: <200603090019.k290JDg13362@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'David Gibson'" <david@gibson.dropbear.id.au>
Cc: "Zhang, Yanmin" <yanmin.zhang@intel.com>, "Andrew Morton" <akpm@osdl.org>,
       "William Lee Irwin" <wli@holomorphy.com>,
       <linux-kernel@vger.kernel.org>
Subject: RE: hugepage: Strict page reservation for hugepage inodes
Date: Wed, 8 Mar 2006 16:19:13 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Thread-Index: AcZDDc9O9uuaIdR9SAecQcseiRSvrwAAE+yQ
In-Reply-To: <20060308235207.GB17590@localhost.localdomain>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Gibson wrote on Wednesday, March 08, 2006 3:52 PM
> But I don't see that recording all the mapped ranges will avoid the
> need for the fault serialization.  At least the version of apw's
> reservation patch I looked at most recently would certainly still
> suffer from the alloc/instantiate race on the last hugepage in the
> system.

No, it doesn't.  Because with strict commit accounting, you know that
every hugetlb page is accounted for.  So there is no backout path for
multiple instantiation race.  Thread that lost in the race will always
go back to retry in hugetlb_no_page().  And since reservation is also
accounted in a global variable, total hugetlb pool won't fall below
what was reserved plus what is in use.  Even if sys admin tries to
reduce hugetlb pool, kernel won't release any pages that are reserved.

- Ken

