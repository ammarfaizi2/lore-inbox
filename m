Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263626AbUCUKbL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Mar 2004 05:31:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263629AbUCUKbL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Mar 2004 05:31:11 -0500
Received: from dbl.q-ag.de ([213.172.117.3]:28650 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S263626AbUCUKbK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Mar 2004 05:31:10 -0500
Message-ID: <405D6EE3.50207@colorfullife.com>
Date: Sun, 21 Mar 2004 11:30:59 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.4.1) Gecko/20031114
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Paul Mundt <lethal@linux-sh.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: fixmap TLB flushing clarification
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>
>I'm curious about the last statement, is this to mean that a TLB entry will
>be reserved at set_fixmap() time in which the translation will happen, and
>that particular entry will be locked down for the duration of the mapping?
>  
>
No. fixmap mappings are global - identical for all processes and all 
cpus. Therefore it's not necessary to flush them during a task switch. 
But that's just an optimization, not a mandatory feature:
On x86 it's possible to mark page table entries as global. Global 
entries are not flushed by the normal tlb flush command, this gives a 
slighly better performance. If your architecture doesn't support that, 
then you can just flush everything during a task switch. I think the 
support for global entries was added for the Pentium cpus - 80486 cpus 
flush the whole tlb cache during a task switch.

--
    Manfred



