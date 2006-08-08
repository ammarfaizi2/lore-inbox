Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751013AbWHHFjr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751013AbWHHFjr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 01:39:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751118AbWHHFjr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 01:39:47 -0400
Received: from loewe.unit-netz.de ([212.202.148.42]:51375 "EHLO
	loewe.unit-netz.de") by vger.kernel.org with ESMTP id S1751013AbWHHFjr convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 01:39:47 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
Subject: fctnl(F_SETSIG) no longer works in 2.6.17, does in 2.6.16.
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Date: Tue, 8 Aug 2006 07:38:36 +0200
Message-ID: <664E3671B2B6DC439E0C9FFCF8E40CA205F4C6@exchange.I-BNEX>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: fctnl(F_SETSIG) no longer works in 2.6.17, does in 2.6.16.
Thread-Index: Aca6rOS2F7ZufODZRU23KqJ8lsKKaQ==
From: "Beschorner Daniel" <Daniel.Beschorner@facton.com>
To: <linux-kernel@vger.kernel.org>
Cc: <orion@cora.nwra.com>, <76306.1226@compuserve.com>,
       "Trond Myklebust" <trond.myklebust@fys.uio.no>, <sfr@canb.auug.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>> static void lease_release_private_callback(struct file_lock *fl) 
>>> { 
>>>         if (!fl->fl_file) 
>>>                 return; 
>>>         f_delown(fl->fl_file); 
>>> =>      fl->fl_file->f_owner.signum = 0; 
>>> } 

>> Why should the lease cleanup code be resetting f_owner.signum? That 
>> looks wrong. 
>> Stephen, I think this line of code predates the CITI changes. Do you 
>> know who added it and why? 

>Because when the original code was written, it was only called when we
got 
>a fcntl(F_SETLEASE, F_UNLCK) call.  The code got moved incorrectly and 
>noone noticed.

Does somebody have a patch for this issue? It breaks one important
application (Samba) in its default configuration.

Daniel
