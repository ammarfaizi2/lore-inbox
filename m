Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265176AbTFEVTK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jun 2003 17:19:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265179AbTFEVTK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jun 2003 17:19:10 -0400
Received: from fmr01.intel.com ([192.55.52.18]:43472 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id S265176AbTFEVTI convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jun 2003 17:19:08 -0400
Message-ID: <A46BBDB345A7D5118EC90002A5072C780D6F13E8@orsmsx116.jf.intel.com>
From: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
To: "'lkml (linux-kernel@vger.kernel.org)'" 
	<linux-kernel@vger.kernel.org>
Subject: How to initialize complex per-cpu variables?
Date: Thu, 5 Jun 2003 14:32:26 -0700 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi All

I am having this issue I don't know how to solve (digged
the source, it didn't clarify)

I have this kind of half complex data structure that 
needs to be per-cpu and I need to initialize them. 

The problem is it contains an array of list_heads 
and I cannot initialize that with an static initializer, 
AFAIK:

#define NUMBER_OF_QUEUES 256

struct rtf_h {
	spinlock_t lock;
	struct list_head queues[NUMBER_OF_QUEUES];
}

static DEFINE_PER_CPU (struct rtf_h, rtf_lh);

So I want to initialize those - I cannot use the variable
initializing because (a) it is very dirty to add a huge 
number of INIT_LIST_HEAD and (b) it would break the
DEFINE_PER_CPU() semantics, as I assume they are copied
and thus the values would be broken.

So I can have it initialized except the list_heads (only
the locks) and then manually initialize the list_heads 
with some rth_h_init() function;

Now the question is: how do I walk each structure that is
associated to each CPU - I mean, something like:

struct rtf_h *h;
for_each_cpu (h, rtf_lh) {
	rtf_h_init (h);
}

TIA

Iñaky Pérez-González -- Not speaking for Intel -- all opinions are my own
(and my fault)
