Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264036AbTDWNkV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 09:40:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264037AbTDWNkU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 09:40:20 -0400
Received: from siaab2ab.compuserve.com ([149.174.40.130]:32391 "EHLO
	siaab2ab.compuserve.com") by vger.kernel.org with ESMTP
	id S264036AbTDWNkT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 09:40:19 -0400
Date: Wed, 23 Apr 2003 09:49:21 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: Wanted: A decent assembler
To: linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200304230952_MC3-1-35A8-EDA3@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Chuck Ebbert wrote:

> <mangled asm source>

 Should be:


.if NR_IRQS gt 16			# only build this for IO-APIC
	.align 8,0x90			# make ENTRY have exact address
irq_align=8				# start with 8-byte alignment
ENTRY(high_irq_entries_start)
.rept NR_IRQS-16			# the rest of the stubs
	.align irq_align,0x90
1:	pushl $vector-256		# 5-byte instruction
	jmp common_interrupt		# 2 or 5 bytes (8 or 32-bit offset)
2:
.if 2b-1b > 8				# offset changed to 32-bit
	irq_align=16			# switch to 16-byte alignment
.endif
.data
	.long 1b
.text
vector=vector+1
.endr
.endif


-------
 Chuck
