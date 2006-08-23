Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932442AbWHWMZN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932442AbWHWMZN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 08:25:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932441AbWHWMZN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 08:25:13 -0400
Received: from nf-out-0910.google.com ([64.233.182.184]:6524 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932442AbWHWMZL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 08:25:11 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Sy1UEeOwonoAQrGKvLXdwyWZ3LDLut2r5SMliijul6VGzbXmMSD/eflEvabpZAN6ArQin69gJRBWGdbCuZGPWKCShd8Pv7Dic0/Qg+4P3cW9AViNnH4v+DUKS93j36qNiV7pduixdqGzWLFLVHdrDD9TSQR+QNIEiJPjDXFgzcY=
Message-ID: <a2ebde260608230525w76a3ea6kef7a09e13f0018ea@mail.gmail.com>
Date: Wed, 23 Aug 2006 20:25:03 +0800
From: "Dong Feng" <middle.fengdong@gmail.com>
Subject: Unnecessary Relocation Hiding?
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <a2ebde260608230500o3407b108hc03debb9da6e62c@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <a2ebde260608230500o3407b108hc03debb9da6e62c@mail.gmail.com>
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, all,

I have a question. Why shall we need a RELOC_HIDE() macro in the
definition of per_cpu()? Maybe the question is actually why we need
macro RELOC_HIDE() at all. I changed the following line in
include/asm-generic/percpu.h, from

#define per_cpu(var, cpu) (*RELOC_HIDE(&per_cpu__##var, __per_cpu_offset[cpu]))

to

#define per_cpu(var, cpu) (*((unsigned long)(&per_cpu__##var) +
__per_cpu_offset[cpu]))

I recompiled the code and it works well on my Intel Dual-core laptop.
It essentially the same as to change the definition of RELOC_HIDE(),
from

#define RELOC_HIDE(ptr, off) \
 ({ unsigned long __ptr; \
   __asm__ ("" : "=r"(__ptr) : "0"(ptr)); \
   (typeof(ptr)) (__ptr + (off)); })

to


#define RELOC_HIDE(ptr, off) \
 ({ unsigned long __ptr; \
   __ptr = (unsigned long)ptr; \
   (typeof(ptr)) (__ptr + (off)); })


Why shouldn't we have a pure C solution in this part?

Best Regards.
Feng,Dong
