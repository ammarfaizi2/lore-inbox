Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264829AbUEKQ1q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264829AbUEKQ1q (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 12:27:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264828AbUEKQ1q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 12:27:46 -0400
Received: from mailgate1b.savvis.net ([216.91.182.6]:54666 "EHLO
	mailgate1b.savvis.net") by vger.kernel.org with ESMTP
	id S264826AbUEKQ0d convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 12:26:33 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.6249.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: Sock leak in net/ipv4/af_inet.c - 2.4.26
Date: Tue, 11 May 2004 11:24:51 -0500
Message-ID: <3B33FD3ADBD7054DB410CD9DA314133E037DDB9D@sl6exch4>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Sock leak in net/ipv4/af_inet.c - 2.4.26
Thread-Index: AcQ3dHsI+apQxCyDQw+GliVtu9L7jg==
From: "Dickey, Dan" <Dan.Dickey@savvis.net>
To: <kuznet@ms2.inr.ac.ru>, <davem@redhat.com>
Cc: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 11 May 2004 16:24:15.0640 (UTC) FILETIME=[66F6C980:01C43774]
X-ECS-MailScanner: No virus is found
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexey & Dave,
I hope these are good addresses for you - it has been a few years since
I've tried to contact you.

I've found a leak in af_inet.c, routine inet_create().
It allocates from the sock slab using sk_alloc(), but
sk_free() is never called on these sock structs.
I'm not that familiar with the af_inet code, but I'll
continue taking a look at it to try and determine where
the missing sk_free() is supposed to be.
If either of you or anyone else has an idea, please
let me know.  We have several 2GB mem systems that need
to be rebooted every few days because of this problem.

Oh - by the way, it looks like this is happening in
net/ipv4/tcp_minisocks.c as well.  Routine tcp_create_openreq_child().
There is no corresponding sk_free() call for the sk_alloc() in here.

In order to track these down, I've added some simple debug code
around the sk_alloc/sk_free calls to track allocations.  I know
where the leaky sock structs are being allocated from, but not
where they should be freed.

The bugzilla.kernel.org bug # is 2676.
	-Dan

------
Dan A. Dickey
dan.dickey@savvis.net

