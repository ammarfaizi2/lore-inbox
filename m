Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262646AbVCPPde@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262646AbVCPPde (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 10:33:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261262AbVCPPch
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 10:32:37 -0500
Received: from mail3.utc.com ([192.249.46.192]:20467 "EHLO mail3.utc.com")
	by vger.kernel.org with ESMTP id S262641AbVCPPbS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 10:31:18 -0500
Message-ID: <42385129.90408@cybsft.com>
Date: Wed, 16 Mar 2005 09:30:49 -0600
From: "K.R. Foley" <kr@cybsft.com>
Organization: Cybersoft Solutions, Inc.
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Frank Rowand <frowand@mvista.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] ppc RT: Realtime preempt support for PPC
References: <422CCC1D.1050902@mvista.com> <20050316100914.GA16012@elte.hu>
In-Reply-To: <20050316100914.GA16012@elte.hu>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------020607000707080204000903"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020607000707080204000903
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Ingo Molnar wrote:
> hi Frank - sorry about the late reply, was busy with other things. Your
> ppc patches look mostly mergeable, with some small details still open:
> 
> * Frank Rowand <frowand@mvista.com> wrote:
> 
> 
>>The patches are:
>>
>> 1/5 ppc_rt.patch          - the core realtime functionality for PPC
> 
> 
> what is the rationale behind the rt_lock.h changes? The #ifdef
> CONFIG_PPC32 changes in generic code are not really acceptable, the -RT
> tree tries to keep a single spinlock definition and debugging
> primitives, across all architectures.
> 
> to drive things forward, i've applied the first 3 patches (except the
> rt_lock.h chunk from the first patch), and released it as part of the
> 40-03 patch:
> 
>   http://redhat.com/~mingo/realtime-preempt/
> 

Is no one else having trouble compiling this one? The attached one liner 
reverses a one line in the above patch.

kr

--------------020607000707080204000903
Content-Type: text/x-patch;
 name="jbdfix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="jbdfix.patch"

--- linux-2.6.11/include/linux/jbd.h.orig	2005-03-16 09:18:51.000000000 -0600
+++ linux-2.6.11/include/linux/jbd.h	2005-03-16 09:19:24.000000000 -0600
@@ -65,6 +65,7 @@ extern int journal_enable_debug;
 		}							\
 	} while (0)
 #else
+#define jbd_debug(f, a...)   /**/
 #endif
 
 extern void * __jbd_kmalloc (const char *where, size_t size, int flags, int retry);

--------------020607000707080204000903--
