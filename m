Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262352AbTEFEcx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 00:32:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262357AbTEFEcx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 00:32:53 -0400
Received: from pizda.ninka.net ([216.101.162.242]:28900 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S262352AbTEFEcw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 00:32:52 -0400
Date: Mon, 05 May 2003 20:37:58 -0700 (PDT)
Message-Id: <20030505.203758.48517285.davem@redhat.com>
To: akpm@digeo.com
Cc: rusty@rustcorp.com.au, dipankar@in.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kmalloc_percpu
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20030505212816.7cb0ec49.akpm@digeo.com>
References: <1052187119.983.5.camel@rth.ninka.net>
	<20030506040856.8B3712C36E@lists.samba.org>
	<20030505212816.7cb0ec49.akpm@digeo.com>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Andrew Morton <akpm@digeo.com>
   Date: Mon, 5 May 2003 21:28:16 -0700
   
   It's OK as long as nobody uses the feature!
   
I think this is closer to say, allocation of kmap types,
than it is to vmalloc() et al. (as you suggest).

   Ho-hum.  Can the magical constant become a __setup thing?
   
Remember that there are physical limitations, for example
on ia64, as to how big this thing can be.  So whatever any
of us think about physical limitations, we have to deal with
them anyways :-)

I think firstly, that we should define that this isn't
something you be doing after module_init()  (ie. your
->open() example, that's rediculious).  Ideas on how to
enforce this are welcome.

Next, we can calculate how much per-cpu space all the modules
need.  And because we can do that, we can preallocate slots
if we wanted to in order to deal with whatever theoretical
fragmentation problems you think exist (much like how Jakub Jelink's
prelinking works).

I personally don't know how smart it is to let random modules use
kmalloc_percpu() with impunity.  But aparently someone thinks
there is some value in that.
