Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262233AbVAYXHp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262233AbVAYXHp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 18:07:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262230AbVAYXEP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 18:04:15 -0500
Received: from outmail1.freedom2surf.net ([194.106.33.237]:31428 "EHLO
	outmail.freedom2surf.net") by vger.kernel.org with ESMTP
	id S262227AbVAYXCW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 18:02:22 -0500
Message-ID: <41F6CFF2.7010907@f2s.com>
Date: Tue, 25 Jan 2005 23:02:10 +0000
From: Ian Molton <spyro@f2s.com>
Organization: The Dragon Roost
User-Agent: Mozilla Thunderbird 1.0 (X11/20041211)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Anton Blanchard <anton@samba.org>
CC: akpm@osdl.org, nickpiggin@yahoo.com.au, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Use MM_VM_SIZE in exit_mmap
References: <20050125142210.GI5920@krispykreme.ozlabs.ibm.com>
In-Reply-To: <20050125142210.GI5920@krispykreme.ozlabs.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anton Blanchard wrote:

 > As an aside, all architectures except one define FIRST_USER_PGD_NR as 0:
 >
 > include/asm-arm26/pgtable.h:#define FIRST_USER_PGD_NR       1

All processes on arm26 must map the same page 0 as its where the SWI 
vector table goes. The vector table is located at address 0, and as such 
becomes virtual address space once the MMU is switched on. This is 
unavoidable, unlike later ARMs which can remap it elsewhere.

The only way this could work is if you do the zeroing with all 
interrupts off and restore page 0 afterwards, which seems rather silly 
to me.
