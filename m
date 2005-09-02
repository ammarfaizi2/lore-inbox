Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030403AbVIBG3F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030403AbVIBG3F (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 02:29:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030439AbVIBG3F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 02:29:05 -0400
Received: from smtp200.mail.sc5.yahoo.com ([216.136.130.125]:5773 "HELO
	smtp200.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S1030403AbVIBG3E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 02:29:04 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:Subject:References:In-Reply-To:Content-Type;
  b=1VysjNhUIIdfeEbkttZmxQnrjY5euPlVvgS3oHh1brxEi+gQZecDEvMGaSLbMoSXZT/vEN3/Pf1I4zsqDrOiFIOH/JJ4C8W+IepING0aas9vliP12SerbmMqrHOJcvkdEPV9OBjSmAJJKo/2vdjYYqTV7lvOIKZDft41GVipiko=  ;
Message-ID: <4317F136.4040601@yahoo.com.au>
Date: Fri, 02 Sep 2005 16:29:10 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.10) Gecko/20050802 Debian/1.7.10-1
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Memory Management <linux-mm@kvack.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.6.13] lockless pagecache 2/7
References: <4317F071.1070403@yahoo.com.au> <4317F0F9.1080602@yahoo.com.au>
In-Reply-To: <4317F0F9.1080602@yahoo.com.au>
Content-Type: multipart/mixed;
 boundary="------------010307040504080703080909"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010307040504080703080909
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

2/7
Implement atomic_cmpxchg for i386 and ppc64. Is there any
architecture that won't be able to implement such an operation?

-- 
SUSE Labs, Novell Inc.


--------------010307040504080703080909
Content-Type: text/plain;
 name="atomic_cmpxchg.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="atomic_cmpxchg.patch"

Introduce an atomic_cmpxchg operation. Implement this for i386 and ppc64.

Signed-off-by: Nick Piggin <npiggin@suse.de>

Index: linux-2.6/include/asm-i386/atomic.h
===================================================================
--- linux-2.6.orig/include/asm-i386/atomic.h
+++ linux-2.6/include/asm-i386/atomic.h
@@ -215,6 +215,8 @@ static __inline__ int atomic_sub_return(
 	return atomic_add_return(-i,v);
 }
 
+#define atomic_cmpxchg(v, old, new)	((int)cmpxchg(&((v)->counter), old, new))
+
 #define atomic_inc_return(v)  (atomic_add_return(1,v))
 #define atomic_dec_return(v)  (atomic_sub_return(1,v))
 
Index: linux-2.6/include/asm-ppc64/atomic.h
===================================================================
--- linux-2.6.orig/include/asm-ppc64/atomic.h
+++ linux-2.6/include/asm-ppc64/atomic.h
@@ -162,6 +162,8 @@ static __inline__ int atomic_dec_return(
 	return t;
 }
 
+#define atomic_cmpxchg(v, o, n)	((int)cmpxchg(&((v)->counter), (o), (n)))
+
 #define atomic_sub_and_test(a, v)	(atomic_sub_return((a), (v)) == 0)
 #define atomic_dec_and_test(v)		(atomic_dec_return((v)) == 0)
 

--------------010307040504080703080909--
Send instant messages to your online friends http://au.messenger.yahoo.com 
