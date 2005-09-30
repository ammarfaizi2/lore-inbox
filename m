Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932593AbVI3Vo3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932593AbVI3Vo3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Sep 2005 17:44:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932595AbVI3Vo3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Sep 2005 17:44:29 -0400
Received: from smtp.osdl.org ([65.172.181.4]:18597 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932593AbVI3Vo2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Sep 2005 17:44:28 -0400
Date: Fri, 30 Sep 2005 14:44:09 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Matthew Wilcox <matthew@wil.cx>
cc: Andrew Patterson <andrew.patterson@hp.com>,
       Luben Tuikov <luben_tuikov@adaptec.com>,
       "Salyzyn, Mark" <mark_salyzyn@adaptec.com>, dougg@torque.net,
       Luben Tuikov <ltuikov@yahoo.com>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: I request inclusion of SAS Transport Layer and AIC-94xx into
 the kernel
In-Reply-To: <20050930202234.GA2571@parisc-linux.org>
Message-ID: <Pine.LNX.4.64.0509301435040.3378@g5.osdl.org>
References: <547AF3BD0F3F0B4CBDC379BAC7E4189F01A9FA11@otce2k03.adaptec.com>
 <1128105594.10079.109.camel@bluto.andrew> <433D9035.6000504@adaptec.com>
 <1128111290.10079.147.camel@bluto.andrew> <20050930202234.GA2571@parisc-linux.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 30 Sep 2005, Matthew Wilcox wrote:
> 
> There's precedent for binary data in sysfs -- pci config space is one.

In general, if the data has no semantic meaning (ie it's just a blob), and 
there really is some point to exporting it, it should be exported as a 
binary blob. There's no point in doing some random "ASCII conversion" if 
the data doesn't have any known semantics. Bytes? Words? Longwords? 
Byteorder? It's simply not a sensible operation, and the only sane 
interface is to just read a binary blob with the raw data.

That's true in general of PCI config space. Of course, _some_ parts of PCI 
config space do indeed have meaning, so you'll find the "device" and 
"vendor" and other things like that as separate nodes in /sysfs with ASCII 
representations. So sometimes you may have mixtures (but it would be 
stupid to try to "remove" the semantic data from the blob - then it would 
turn into a _true_ monster).

So it's not like binary blobs are not allowed. In general, the rule should 
be:
 - all independent values should show up as independent files (never mix 
   stuff up that you don't need to)
 - anything with semantic meaning should have the appropriate semantic 
   textual format (ie formatted ASCII, not just raw data).

The _goal_ is that you can look at sysfs with a file manager, and the 
results should make sense. 

		Linus
