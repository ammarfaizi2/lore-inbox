Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261769AbTGHNHU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jul 2003 09:07:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262116AbTGHNHU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jul 2003 09:07:20 -0400
Received: from blackbird.intercode.com.au ([203.32.101.10]:32007 "EHLO
	blackbird.intercode.com.au") by vger.kernel.org with ESMTP
	id S261769AbTGHNHS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jul 2003 09:07:18 -0400
Date: Tue, 8 Jul 2003 23:20:30 +1000 (EST)
From: James Morris <jmorris@intercode.com.au>
To: Andrew Morton <akpm@osdl.org>
cc: jgarzik@pobox.com, <sds@epoch.ncsc.mil>, <torvalds@osdl.org>,
       <viro@parcelfarce.linux.theplanet.co.uk>, <alan@lxorguk.ukuu.org.uk>,
       <hch@infradead.org>, <greg@kroah.com>, <chris@wirex.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Add SELinux module to 2.5.74-bk1
In-Reply-To: <20030708030931.6864972b.akpm@osdl.org>
Message-ID: <Mutt.LNX.4.44.0307082306440.8213-100000@excalibur.intercode.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Jul 2003, Andrew Morton wrote:

> Comparing the complexity (size) of this code with the q-n-d hash tables
> which are currently used one does wonder how useful it all will be.  The
> additional indirections are not needed with q-n-d hashes.

I guess this is the big issue -- will the code potentially be useful to 
anyone else?

Any important hashing is likely to involve specialized techniques 
(e.g. RCU, per-cpu and various lockless strategies), and likely not use 
this library code.

> But if it doesn't significantly add to the overall selinux patch then I
> guess it makes sense.

It doesn't add anything really, just some minor cleanups to make it more
suitable for general use.

It is also possible that the SELinux code may be further refined for 
performance and utilize specialized hashing/locking techniques which are 
no longer accommodated by this generic hashtab code.

My feeling at the moment is that there is probably not a compelling case
to pull the hashtab code out of SELinux into a kernel library, although
many of the suggestions would be worth applying to the SELinux resident
version.


- James
-- 
James Morris
<jmorris@intercode.com.au>

