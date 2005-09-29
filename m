Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932246AbVI2Qqb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932246AbVI2Qqb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 12:46:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932244AbVI2Qqb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 12:46:31 -0400
Received: from qproxy.gmail.com ([72.14.204.204]:40893 "EHLO qproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932246AbVI2Qqa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 12:46:30 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:subject:from:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:x-mailer;
        b=pgVyCP+TgZrK6kNufERAzECrS4c6NY007IPkFBhQ4qHIsfigetxVd6IpxUHRQzuNyoYQ0xSiKUtuqUvj2qF1aOsg1XAQDxBh8pUg2yR4p1XxmHSelt+cGzSGWdrBtLh63UaHwZGofS8vdaJ0ZLUlfZcBHT4iq+RrTvCFiyoy4cg=
Subject: Re: 2.6.14-rc2-rt2
From: Badari Pulavarty <pbadari@gmail.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20050926070210.GA5157@elte.hu>
References: <20050913100040.GA13103@elte.hu> <20050926070210.GA5157@elte.hu>
Content-Type: multipart/mixed; boundary="=-Adfzz52zjuaNZorPPOmB"
Date: Thu, 29 Sep 2005 09:45:46 -0700
Message-Id: <1128012346.16275.71.camel@dyn9047017102.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Adfzz52zjuaNZorPPOmB
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, 2005-09-26 at 09:02 +0200, Ingo Molnar wrote:
> i have released the 2.6.14-rc2-rt2 tree, which can be downloaded from 
> the usual place:
> 
>    http://redhat.com/~mingo/realtime-preempt/
> 

Hi Ingo,

I noticed that you moved to "-rt7" already.
 "-rt7" fails to compile with CONFIG_NUMA.

mm/slab.c:2404: error: conflicting types for `kmem_cache_alloc_node'
include/linux/slab.h:122: error: previous declaration of
`kmem_cache_alloc_node'

Here is the simple fix.

Thanks,
Badari



--=-Adfzz52zjuaNZorPPOmB
Content-Disposition: attachment; filename=rt7-fix.patch
Content-Type: text/x-patch; name=rt7-fix.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

--- linux-2.6.14-rc2/mm/slab.c	2005-09-29 02:55:11.000000000 -0700
+++ linux-2.6.14-rc2-rt7/mm/slab.c	2005-09-29 02:48:05.000000000 -0700
@@ -2400,7 +2400,7 @@ out:
  * and can sleep. And it will allocate memory on the given node, which
  * can improve the performance for cpu bound structures.
  */
-void *kmem_cache_alloc_node(kmem_cache_t *cachep, int flags, int nodeid)
+void *kmem_cache_alloc_node(kmem_cache_t *cachep, unsigned int __nocast flags, int nodeid)
 {
 	int loop;
 	void *objp;

--=-Adfzz52zjuaNZorPPOmB--

