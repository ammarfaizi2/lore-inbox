Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262591AbVDPDBD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262591AbVDPDBD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Apr 2005 23:01:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262595AbVDPDBD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Apr 2005 23:01:03 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:65012 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S262591AbVDPDA6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Apr 2005 23:00:58 -0400
From: "Sven Dietrich" <sdietrich@mvista.com>
To: "'Steven Rostedt'" <rostedt@goodmis.org>,
       "'Inaky Perez-Gonzalez'" <inaky@linux.intel.com>
Cc: "'Bill Huey'" <bhuey@lnxw.com>, <dwalker@mvista.com>, <mingo@elte.hu>,
       <linux-kernel@vger.kernel.org>, "'Esben Nielsen'" <simlo@phys.au.dk>,
       <robustmutexes@lists.osdl.org>
Subject: RE: FUSYN and RT
Date: Fri, 15 Apr 2005 20:00:29 -0700
Message-ID: <000801c54230$73a0f940$c800a8c0@mvista.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.6626
In-Reply-To: <1113618713.4294.126.camel@localhost.localdomain>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > 
> > 	/** A fuqueue, a prioritized wait queue usable from
> kernel space. */
> > 	struct fuqueue {
> > 	        spinlock_t lock;        
> > 	        struct plist wlist;
> > 	        struct fuqueue_ops *ops;
> > 	};
> > 
> 
> Would the above spinlock_t be a raw_spinlock_t? This goes
> back to my first question. I'm not sure how familiar you are 
> with Ingo's work, but he has turned all spinlocks into 
> mutexes, and when you really need an original spinlock, you 
> declare it with raw_spinlock_t.  
> 

This one probably should be a raw_spinlock. 
This lock is only held to protect access to the queues.
Since the queues are already priority ordered, there is
little benefit to ordering -the order of insertion-
in case of contention on a queue, compared with the complexity.

Just what you want to say to a guy who says he is tired  ;)

Sven



