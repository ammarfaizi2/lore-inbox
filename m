Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751275AbWCVPFJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751275AbWCVPFJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 10:05:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750702AbWCVPD5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 10:03:57 -0500
Received: from mx2.suse.de ([195.135.220.15]:16257 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751275AbWCVPDb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 10:03:31 -0500
From: Andi Kleen <ak@suse.de>
To: virtualization@lists.osdl.org
Subject: Re: [RFC PATCH 18/35] Support gdt/idt/ldt handling on Xen.
Date: Wed, 22 Mar 2006 15:30:51 +0100
User-Agent: KMail/1.9.1
Cc: Chris Wright <chrisw@sous-sol.org>, linux-kernel@vger.kernel.org,
       xen-devel@lists.xensource.com, Ian Pratt <ian.pratt@xensource.com>
References: <20060322063040.960068000@sorel.sous-sol.org> <20060322063753.556397000@sorel.sous-sol.org>
In-Reply-To: <20060322063753.556397000@sorel.sous-sol.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603221530.51644.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 22 March 2006 07:30, Chris Wright wrote:

>  
> -#define load_TR_desc() __asm__ __volatile__("ltr %w0"::"q" (GDT_ENTRY_TSS*8))
> -#define load_LDT_desc() __asm__ __volatile__("lldt %w0"::"q" (GDT_ENTRY_LDT*8))
> -
> -#define load_gdt(dtr) __asm__ __volatile("lgdt %0"::"m" (*dtr))
> -#define load_idt(dtr) __asm__ __volatile("lidt %0"::"m" (*dtr))
> -#define load_tr(tr) __asm__ __volatile("ltr %0"::"mr" (tr))
> -#define load_ldt(ldt) __asm__ __volatile("lldt %0"::"mr" (ldt))
> -
> -#define store_gdt(dtr) __asm__ ("sgdt %0":"=m" (*dtr))
> -#define store_idt(dtr) __asm__ ("sidt %0":"=m" (*dtr))
> -#define store_tr(tr) __asm__ ("str %0":"=mr" (tr))
> -#define store_ldt(ldt) __asm__ ("sldt %0":"=mr" (ldt))


These are all very infrequent except perhaps LLDT. I suspect trapping would 
work too. But ok.

> -#define _set_tssldt_desc(n,addr,limit,type) \

[...]

Why are you moving these? Xen should just be parsing the same structures
as the hardware, shouldn't it?

-Andi
