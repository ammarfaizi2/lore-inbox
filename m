Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263767AbTIBT3S (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Sep 2003 15:29:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263784AbTIBT3S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Sep 2003 15:29:18 -0400
Received: from fw.osdl.org ([65.172.181.6]:10709 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263767AbTIBT3R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Sep 2003 15:29:17 -0400
Date: Tue, 2 Sep 2003 12:35:21 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: mochel@cherise
To: Andrew Morton <akpm@osdl.org>
cc: Bongani Hlope <bonganilinux@mweb.co.za>, <linux-kernel@vger.kernel.org>
Subject: Re: [OOPS][RESEND] 2.6.0-test4-mm4
In-Reply-To: <20030901223056.2700543d.akpm@osdl.org>
Message-ID: <Pine.LNX.4.44.0309021233420.5614-100000@cherise>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> OK, it's a straightforward use-after-free in kobject_cleanup().  I snarfed
> a patch from Pat which allows arbitrary-length kobject names.  Maybe it
> wasn't quite ready yet.
> 
> t->release points at cdev_dynamic_release(), which frees the kobj.

Bah, I'm just retarded. It should be something like: 

 +	if (kobj->k_name != kobj->name)
 +		kfree(kobj->k_name);
  	if (t && t->release)
  		t->release(kobj);

I'll send you an updated patch shortly, once I get my trees in sync again. 


	Pat


