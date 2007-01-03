Return-Path: <linux-kernel-owner+w=401wt.eu-S1753176AbXACCAm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753176AbXACCAm (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 21:00:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753233AbXACCAl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 21:00:41 -0500
Received: from mga02.intel.com ([134.134.136.20]:39798 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753176AbXACCAl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 21:00:41 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.12,228,1165219200"; 
   d="scan'208"; a="180842060:sNHT18322969"
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Zach Brown'" <zach.brown@oracle.com>
Cc: "'Andrew Morton'" <akpm@osdl.org>, <linux-aio@kvack.org>,
       <linux-kernel@vger.kernel.org>, "'Benjamin LaHaise'" <bcrl@kvack.org>,
       <suparna@in.ibm.com>
Subject: RE: [patch] aio: streamline read events after woken up
Date: Tue, 2 Jan 2007 18:00:40 -0800
Message-ID: <001001c72eda$f892b1a0$ff0da8c0@amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 11
Thread-Index: Accu00xvTgohWpkrSN2g/VsiklPJxwABvDmQ
In-Reply-To: <0B3B0231-4AFD-4870-B96F-00AC78F80E52@oracle.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zach Brown wrote on Tuesday, January 02, 2007 5:06 PM
> To: Chen, Kenneth W
> > Given the previous patch "aio: add per task aio wait event condition"
> > that we properly wake up event waiting process knowing that we have
> > enough events to reap, it's just plain waste of time to insert itself
> > into a wait queue, and then immediately remove itself from the wait
> > queue for *every* event reap iteration.
> 
> Hmm, I dunno.  It seems like we're still left with a pretty silly loop.
> 
> Would it be reasonable to have a loop that copied multiple events at  
> a time?  We could use some __copy_to_user_inatomic(), it didn't exist  
> when this stuff was first written.

It sounds reasonable, but I think it will be complicated because of
kmap_atomic on the ring buffer, along with tail wraps around ring
buffer index there.  By then, most of you would probably veto the
patch anyway ;-)

