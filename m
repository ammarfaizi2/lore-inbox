Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261589AbUBYXB7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 18:01:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261575AbUBYW6M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 17:58:12 -0500
Received: from fw.osdl.org ([65.172.181.6]:4581 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261589AbUBYW5E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 17:57:04 -0500
Subject: Re: [PATCH 2.6.3-mm3] serialize_writeback_fdatawait patch
From: Daniel McNeil <daniel@osdl.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "linux-aio@kvack.org" <linux-aio@kvack.org>
In-Reply-To: <20040224174354.517b1d23.akpm@osdl.org>
References: <20040222172200.1d6bdfae.akpm@osdl.org>
	 <1077671733.1956.247.camel@ibm-c.pdx.osdl.net>
	 <20040224174354.517b1d23.akpm@osdl.org>
Content-Type: text/plain
Organization: 
Message-Id: <1077749819.1956.271.camel@ibm-c.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 25 Feb 2004 14:56:59 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-02-24 at 17:43, Andrew Morton wrote:

> 
> hm, OK.  I've converted all the down_read_trylock() things into a sinple
> down_read(), to address the pdflush-busywait problem which Hugh identified.
> 

The other thing we could do is add a wbc->encountered_congestion = 1
if the down_read_trylock() fails and then check for that to prevent
the busywait problem.    

> This does mean that pdflush can get blocked by ongoing sync activity but
> that's probably insignificant and we have per-spindle pdflush collision
> avoidance which will help a bit.
> 
> Call me lazy, but could you please work out the ranking of wb_rwsem with
> respect to the other VFS locks, update the locking documentation in
> mm/filemap.c and make sure that we're actually adhering to it?  Thanks.

Ok. I'm looking at this.

Daniel

