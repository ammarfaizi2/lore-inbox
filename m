Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750894AbWESOOV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750894AbWESOOV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 May 2006 10:14:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751332AbWESOOV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 May 2006 10:14:21 -0400
Received: from mx1.redhat.com ([66.187.233.31]:35043 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750894AbWESOOU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 May 2006 10:14:20 -0400
Message-ID: <446DD282.5080402@redhat.com>
Date: Fri, 19 May 2006 10:13:22 -0400
From: Satoshi Oshima <soshima@redhat.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>, Richard J Moore <richardj_moore@uk.ibm.com>
CC: Andrew Morton <akpm@osdl.org>,
       "Keshavamurthy, Anil S" <anil.s.keshavamurthy@intel.com>,
       "Hideo AOKI@redhat" <haoki@redhat.com>,
       Masami Hiramatsu <hiramatu@sdl.hitachi.co.jp>,
       Jim Keniston <jkenisto@us.ibm.com>, linux-kernel@vger.kernel.org,
       Ananth N Mavinakayanahalli <mananth@in.ibm.com>,
       Prasanna S Panchamukhi <prasanna@in.ibm.com>,
       sugita <sugita@sdl.hitachi.co.jp>, systemtap@sources.redhat.com,
       systemtap-owner@sourceware.org
Subject: Re: [PATCH] kprobes: bad manipulation of 2 byte opcode on x86_64
References: <OFAED3DE10.BAEAFDF2-ON41257173.002E89ED-41257173.002E9AB6@uk.ibm.com> <200605191333.11930.ak@suse.de>
In-Reply-To: <200605191333.11930.ak@suse.de>
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> On Friday 19 May 2006 10:29, Richard J Moore wrote:
>> Is there any possibility of a inducing a page fault when checking the
>> second byte?
> 
> AFAIK instr is in the out of line instruction copy. Kernel would need
> to be pretty broken already if that page faulted.

There is no possibility that copied instruction step over 
a page boundary. Instruction slot is in the page that 
is allocated in get_insn_slot(). And get_insn_slot() 
acquires the page by module_alloc(), and divides into
slots.

Satoshi Oshima
