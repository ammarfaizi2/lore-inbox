Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265284AbTLGBPd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Dec 2003 20:15:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265285AbTLGBPd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Dec 2003 20:15:33 -0500
Received: from fmr05.intel.com ([134.134.136.6]:34003 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP id S265284AbTLGBPV convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Dec 2003 20:15:21 -0500
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: RE: [RFC/PATCH] FUSYN Realtime & Robust mutexes for Linux try 2
Date: Sat, 6 Dec 2003 17:15:16 -0800
Message-ID: <A20D5638D741DD4DBAAB80A95012C0AE0125DED1@orsmsx409.jf.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [RFC/PATCH] FUSYN Realtime & Robust mutexes for Linux try 2
Thread-Index: AcO6KrVu+uNLshYETm2zUY2/Ep48KQCM2i6g
From: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
To: "Jamie Lokier" <jamie@shareable.org>
Cc: <linux-kernel@vger.kernel.org>, <robustmutexes@lists.osdl.org>
X-OriginalArrivalTime: 07 Dec 2003 01:15:17.0004 (UTC) FILETIME=[92F65CC0:01C3BC5F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> From: Jamie Lokier [mailto:jamie@shareable.org]

I had one question for you I forgot to ask wrt to fulocks. 

In the vlocator code I ripped your stuff for get_futex_key()
to generate the unique ID. Now, in ufulocks I need to access
the user space page where the vfulock is to modify it when 
we fiddle with the ownership of fulock state to keep it in sync;
in every case we need to pull it up from swap if it is there
because we'll read and potentially write.

As I do it now is the lazy way. I just pin the page and keep
it in fulock->page. This is kind of ugly because it reverts
back to the old futex behavior of 'page pinned while waiting'.

Now, I'd love to be able to have a key that can be used to pull
the 'struct page' from, so I don't need to pin the page
while waiting.

This would be easy to do if we only had the lock and unlock 
cases, as both have direct and easy access to the location of
the vfulock in current's address space. 

However, the problem is in __ufulock_exit(); in this case, we
don't necessarily have access to the address space of the 
exiting thread. I am thinking of just adding the user space
address an an ownership property so __ufulock_exit() can use
it, but I am kind of concerned on what would happen if a shared
area were unmapped while owning a lock that is supposed to be
on it.

Do you have any ideas on what would be a good way to do this?

Iñaky Pérez-González -- Not speaking for Intel -- all opinions are my own (and my fault)
