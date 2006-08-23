Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932434AbWHWMBK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932434AbWHWMBK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 08:01:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932433AbWHWMBK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 08:01:10 -0400
Received: from nf-out-0910.google.com ([64.233.182.186]:52504 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932434AbWHWMBJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 08:01:09 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=kYN9ME2AjyukiJQxAsEruG2aWcRmC5wlMA91c4qivW/q8Lt97dtEmVmP9YRPoWneiFFq/fzvW56TadgfPZiOJLcCzjtFXpmrgpedIjVP2eZxNdWbWFByIXpBvnCX7i9fNb+bXwUJXtdI8CKt/iDuTIHAmHeE2soq1B0nuFRIibE=
Message-ID: <a2ebde260608230500o3407b108hc03debb9da6e62c@mail.gmail.com>
Date: Wed, 23 Aug 2006 20:00:59 +0800
From: "Dong Feng" <middle.fengdong@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Unnecessary Relocation Hiding?
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
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
